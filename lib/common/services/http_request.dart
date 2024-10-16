import 'dart:io';

import 'package:icebery_flutter/global.dart';
import 'package:icebery_flutter/pages/index.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;

import '../index.dart';

class HttpRequestService extends GetxService {
  static HttpRequestService get to => Get.find();

  late final Dio _dio;

  @override
  void onInit() {
    super.onInit();
    // 初始 dio
    var options = BaseOptions(
      baseUrl: Constants.apiUrl,
      connectTimeout: const Duration(milliseconds: 10000), //10秒
      receiveTimeout: const Duration(milliseconds: 5000), //5秒
      headers: {},
      contentType: "application/json; charset=utf-8",
      responseType: ResponseType.json,
    );

    _dio = Dio(options);
    // 拦截器
    _dio.interceptors.add(RequestInterceptors());

    // 在调试模式下需要抓包调试，所以我们使用代理，并禁用HTTPS证书校验 - 如果不需要，就在proxy.dart 文件中将PROXY_ENABLE设置成false，重新运行即可。
    if (!Global.isRelease && PROXY_ENABLE) {
      _dio.httpClientAdapter = IOHttpClientAdapter(createHttpClient: () {
        final HttpClient client =
            HttpClient(context: SecurityContext(withTrustedRoots: false));
        client.findProxy = (uri) {
          return "PROXY $PROXY_IP:$PROXY_PORT";
        };
        client.badCertificateCallback =
            ((X509Certificate cert, String host, int port) => true);
        return client;
      });
    }
  }

  // 自己设置url进行外部传入
  void setOptions(String api) {
    _dio.options = _dio.options.copyWith(baseUrl: api);
  }

  /// get 请求
  Future<Response> get(
    String url, {
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    Options requestOptions = options ?? Options();
    Response response = await _dio.get(
      url,
      queryParameters: params,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response;
  }

  /// post 请求
  Future<Response> post(
    String url, {
    Map<String, dynamic>? params,
    dynamic data,
    String contentType = "json",
    Options? options,
    CancelToken? cancelToken,
  }) async {
    Options requestOptions = options ?? Options();
    // json 格式 / form 表单格式
    Response response = await _dio.post(
      url,
      queryParameters: params,
      data: contentType == "json"
          ? data
          : data != null
              ? FormData.fromMap(data)
              : null, // form表单形式的记得此处的data是json，记得模型转json【xxx.toJson()】
      options: requestOptions,
      cancelToken: cancelToken,
    );

    return response;
  }

  /// put 请求
  Future<Response> put(
    String url, {
    dynamic data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    var requestOptions = options ?? Options();
    Response response = await _dio.put(
      url,
      data: data ?? {},
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response;
  }

  Future<Response> delete(
    String url, {
    dynamic data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    var requestOptions = options ?? Options();
    Response response = await _dio.delete(
      url,
      data: data ?? {},
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response;
  }
}

/// 拦截
class RequestInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // super.onRequest(options, handler);
    if (UserService.to.hasToken) {
      options.headers['accessToken'] = UserService.to.token; //Bearer Token
    }
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode != 200 && response.statusCode != 201) {
      handler.reject(
        DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
        ),
        true,
      );
    } else {
      int ret = 0;
      // String? info = response.data["info"] ?? "";
      // 退出登录的一些错误码
      const invalidTokenCodes = ["-2002", "3131"];
      if (ret == 0) {
        handler.next(response);
      } else if (invalidTokenCodes.contains(ret.toString())) {
        // 退出登录
        _errorNoAuthLogout();
      } else {
        handler.reject(
          DioException(
            requestOptions: response.requestOptions,
            response: response,
            type: DioExceptionType.badResponse,
          ),
          true,
        );
      }
    }
  }

  /// 退出并重新登录
  _errorNoAuthLogout() {
    //添加提示 todo
    Loading.error("登录已过期，请重新登录");

    /// 添加登录过期的校验，防止反复跳转到登录页
    if (Get.currentRoute == '/LoginPage') {
      return;
    }
    UserService.to.logout();
    Get.offAll(() => const LoginPage());
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final exception = HttpException(err.message ?? "未知错误");
    switch (err.type) {
      // 服务端自定义错误体处理
      case DioExceptionType.badResponse:
        {
          // doing..
          final response = err.response;
          var statusCode = response?.statusCode;
          var msg = '';
          switch (response!.statusCode) {
            case 401: // 401 标识没有登录认证
              msg = "未授权，登录账号已过期";
              _errorNoAuthLogout();
              break;
            case 404:
              msg = "未找到数据";
              break;
            case 500:
              msg = "服务器错误";
              break;
            case 502:
              msg = "网关错误";
              break;
            default:
              {
                statusCode = response.data["ret"] ?? statusCode;
                msg = response.data["info"] ?? "未知错误";
                break;
              }
          }
          Loading.error("$msg【$statusCode】");
        }
        break;
      case DioExceptionType.connectionTimeout:
        Loading.error("网络连接超时");
        break;
      case DioExceptionType.sendTimeout:
        Loading.error("网络连接超时");
        break;
      case DioExceptionType.receiveTimeout:
        Loading.error("网络连接超时");
        break;
      case DioExceptionType.cancel:
        Loading.error("网络连接取消");
        break;
      case DioExceptionType.unknown:
        Loading.error("该服务器不存在");
        break;
      default:
        Loading.error("未知错误");
        break;
    }
    err = err.copyWith(error: exception);
    handler.next(err);
  }
}
