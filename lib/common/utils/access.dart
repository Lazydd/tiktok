import 'dart:io';
// 使用 Uint8List 数据类型
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tiktok/common/index.dart';
import 'package:native_device_orientation/native_device_orientation.dart';

import 'package:path_provider/path_provider.dart';
// 授权管理
import 'package:permission_handler/permission_handler.dart';
// 保存文件或图片到本地
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

enum AccessEnum {
  takePhoto,
  photoLibrary,
}

abstract class Access {
  /// 相册权限 动态申请权限，需要区分android和ios，很多时候它两配置权限时各自的名称不同
  static Future<bool> requestPhotoPermisson() async {
    if (Platform.isIOS) {
      final result = await [Permission.photos].request();
      return result[Permission.photos] == PermissionStatus.granted ||
          result[Permission.photos] == PermissionStatus.limited;
    }
    if (Platform.isAndroid) {
      final result = await [Permission.storage].request();
      return result[Permission.storage] == PermissionStatus.granted;
    }
    return false;
  }

  /// 相机权限 动态申请权限，需要区分android和ios，很多时候它两配置权限时各自的名称不同
  static Future<bool> requestCameraPermisson() async {
    if (Platform.isIOS) {
      final result = await [Permission.camera].request();
      return result[Permission.camera] == PermissionStatus.granted ||
          result[Permission.camera] == PermissionStatus.limited;
    }
    if (Platform.isAndroid) {
      final result = await [Permission.storage].request();
      return result[Permission.storage] == PermissionStatus.granted;
    }
    return false;
  }

  /// 是否开启相机，开机了回调回去，否则警告框提示；isNavigatorPop：是否需要隐藏某些弹框页，默认不隐藏
  static Future<void> openCamera(BuildContext context,
      {required Function onCameraGranted, bool isNavigatorPop = false}) async {
    if (await requestCameraPermisson()) {
      onCameraGranted();
    } else {
      // isNavigatorPop：是否需要隐藏某些弹框页，默认不隐藏
      if (isNavigatorPop) {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      }
      //未开权限弹框提示
      // ignore: use_build_context_synchronously
      showPermissionAlertDialog(context, "未开启相机权限，是否开启相机权限？");
    }
  }

  /// 打开设置
  static Future<void> setting() async => await openAppSettings();

  /// 保存网络图片到相册
  static Future<void> saveNetWorkImage(
    BuildContext context,
    String imageUrl,
  ) async {
    if (await requestPhotoPermisson()) {
      var response = await Dio()
          .get(imageUrl, options: Options(responseType: ResponseType.bytes));
      final result = await ImageGallerySaverPlus.saveImage(
        Uint8List.fromList(response.data),
        quality: 80,
        name: DateTime.now().millisecondsSinceEpoch.toString(), //取时间戳作为文件名
      );
      if (result["isSuccess"]) {
        Loading.success("已保存到相册");
      } else {
        Loading.error("保存失败");
      }
    } else {
      //未开权限弹框提示
      // ignore: use_build_context_synchronously
      showPermissionAlertDialog(context, "未开启相册权限，是否开启相册权限？");
    }
  }

  static Future<Uint8List> readFileByte(String filePath) async {
    Uri myUri = Uri.parse(filePath);
    File file = File.fromUri(myUri);
    late Uint8List bytes;
    await file.readAsBytes().then((value) {
      bytes = Uint8List.fromList(value);
      if (kDebugMode) {
        print('reading of bytes is completed');
      }
    }).catchError((onError) {
      if (kDebugMode) {
        print('Exception Error while reading audio from path:$onError');
      }
    });
    return bytes;
  }

  /// 保存本地图片到相册
  static Future<void> saveAssetsImg(
    BuildContext context,
    String url, {
    //是否是本地图片，指的是项目里的路径，例如"assets/images/3.0x/default.png"
    bool isAsset = false,
  }) async {
    if (await requestPhotoPermisson()) {
      ByteData data;
      if (isAsset) {
        data = await rootBundle.load(url);
      } else {
        Uint8List byteArray = await readFileByte(url);
        data = ByteData.view(byteArray.buffer);
      }

      List<int> bytesData =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      if (bytesData.isNotEmpty) {
        final result = await ImageGallerySaverPlus.saveImage(
          Uint8List.fromList(bytesData),
          quality: 80,
          name: DateTime.now().millisecondsSinceEpoch.toString(), //取时间戳作为文件名
        );
        if (result['isSuccess']) {
          Loading.success("已保存到相册");
        } else {
          Loading.error("保存失败");
        }
      }
    } else {
      //未开权限弹框提示
      // ignore: use_build_context_synchronously
      showPermissionAlertDialog(context, "未开启相册权限，是否开启相册权限？");
    }
  }

  /// 下载视频时间会比较旧，最好加个等待框 http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4
  static Future<void> saveVideo(BuildContext context, String url) async {
    if (await requestPhotoPermisson()) {
      var appDocDir = await getTemporaryDirectory();
      String savePath =
          "${appDocDir.path}/${DateTime.now().millisecondsSinceEpoch.toString()}.mp4";
      await Dio().download(url, savePath,
          onReceiveProgress: (int current, int total) {
        Loading.showProgress(current / total,
            status:
                "文件下载中(${(current / total * 100).truncate().toString()}%),请稍后....");
      });
      final result = await ImageGallerySaverPlus.saveFile(savePath);
      if (result["isSuccess"]) {
        Loading.success("已保存到相册");
      } else {
        Loading.error("保存失败");
      }
    } else {
      //未开权限弹框提示
      // ignore: use_build_context_synchronously
      showPermissionAlertDialog(context, "未开启相册权限，是否开启相册权限？");
    }
  }

  /// 保存gif动画
  static Future<void> saveGif(BuildContext context, String url) async {
    if (await requestPhotoPermisson()) {
      var appDocDir = await getTemporaryDirectory();
      String savePath = "${appDocDir.path}/temp.gif";
      String fileUrl = url;
      await Dio().download(fileUrl, savePath);
      final result = await ImageGallerySaverPlus.saveFile(savePath,
          isReturnPathOfIOS: true);
      if (result['isSuccess']) {
        Loading.success("已保存到相册");
      } else {
        Loading.error("保存失败");
      }
    } else {
      //未开权限弹框提示
      // ignore: use_build_context_synchronously
      showPermissionAlertDialog(context, "未开启相册权限，是否开启相册权限？");
    }
  }

  /// 访问图片资源库
  static showPhotoLibrary(BuildContext context, {int maxAssets = 1}) async {
    if (await requestPhotoPermisson()) {
      if (context.mounted) {
        final List<AssetEntity>? entityList = await AssetPicker.pickAssets(
          context,
          pickerConfig: AssetPickerConfig(
            maxAssets: maxAssets,
            requestType: RequestType.image,
            textDelegate: const AssetPickerTextDelegate(),
          ),
        );
        if (entityList != null) {
          return {
            "key": entityList[0].id,
            "file": await entityList[0].file,
          };
        }
      }
    } else {
      //未开权限弹框提示
      // ignore: use_build_context_synchronously
      showPermissionAlertDialog(context, "未开启相册权限，是否开启相册权限？");
    }
  }

  /// 拍照
  // static showTakePhoto(BuildContext context) async {
  //   final AssetEntity? entity = await CameraPicker.pickFromCamera(
  //     context,
  //     pickerConfig: CameraPickerConfig(
  //       onEntitySaving: (ctx, pickerType, File file) {
  //         print(file.path);
  //         Navigator.of(context);
  //         return file;
  //       },
  //     ),
  //   );
  //   if (entity != null) {
  //     return {
  //       "key": entity.id,
  //       "file": await entity.file,
  //     };
  //   }
  // }
  /// 拍照
  /// isAutoSave:是否自动保存到相册
  static showTakePhoto(BuildContext context, {bool isAutoSave = false}) async {
    File? fileToBeHandle;
    // Future<NativeDeviceOrientation>? orientationFuture;
    int rotate = 0;
    final AssetEntity? entity = await CameraPicker.pickFromCamera(
      context,
      pickerConfig: CameraPickerConfig(
        enableRecording: false,
        lockCaptureOrientation: DeviceOrientation.portraitUp,
        cameraQuarterTurns: 0,
        onXFileCaptured: (xFile, cmeraPickerViewType) {
          // 图像旋转
          NativeDeviceOrientationCommunicator()
              .orientation(useSensor: true)
              .then((value) {
            NativeDeviceOrientation? orientation = value;
            switch (orientation) {
              case NativeDeviceOrientation.landscapeRight:
                rotate = 90;
                break;
              case NativeDeviceOrientation.portraitDown:
                rotate = 180;
                break;
              case NativeDeviceOrientation.landscapeLeft:
                rotate = 270;
                break;
              default:
                rotate = 0;
            }
          });

          return false;
        },
        onEntitySaving: isAutoSave
            ? null
            : (ctx, pickerType, File file) {
                fileToBeHandle = file;
                Navigator.of(context)
                  ..pop()
                  ..pop();
              },
      ),
    );

    if (fileToBeHandle != null) {
      return {
        "key": fileToBeHandle!.path,
        "file": fileToBeHandle,
        "rotate": rotate,
      };
    }
    if (entity != null) {
      return {
        "key": entity.id,
        "file": await entity.file,
        "rotate": rotate,
      };
    }
  }

  /// 未开权限弹框提示
  static showPermissionAlertDialog(BuildContext context, String content) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text(
              "提示",
              style: TextStyle(color: Colors.blue),
            ),
            content: Text(content),
            actions: <Widget>[
              CupertinoDialogAction(
                child: const Text(
                  "取消",
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              CupertinoDialogAction(
                child: const Text("确认"),
                onPressed: () {
                  Navigator.pop(context);
                  // 打开手机上该App的权限设置页面
                  Access.setting();
                },
              ),
            ],
          );
        });
  }
}
