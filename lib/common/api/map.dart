import 'package:tiktok/common/index.dart';
import 'package:dio/dio.dart';

abstract class MapAPI {
  /// 关键字搜索
  /// keywords 地点关键字
  static Future<List<MapPoiModel>> searchText({
    required String searchValue,
    required String location,
    String pageSize = "25",
    String pageNum = "1",
  }) async {
    var response = await Dio().get(
      "",
      queryParameters: {
        "key": Constants.mapKey,
        "keywords": searchValue,
        // 文档参考 https://lbs.amap.com/api/webservice/download
        "region": "410700",
        "city_limit": true,
        "page_size": pageSize,
        "page_num": pageNum,
      },
    )
        // ignore: body_might_complete_normally_catch_error
        .catchError((onError) {});
    if (response.data["status"] == "1") {
      List<String> locationList = location.split(",");
      String lng = double.parse(locationList[0]).toStringAsFixed(6);
      String lat = double.parse(locationList[1]).toStringAsFixed(6);
      List<MapPoiModel> poiList = [];
      for (var item in response.data['pois']) {
        MapPoiModel model = MapPoiModel.fromJson(item);
        double distance = Location.distanceBetween(
          double.parse(lng),
          double.parse(lat),
          double.parse(model.location.split(",")[0]),
          double.parse(model.location.split(",")[1]),
        );
        model.distance = "$distance";
        poiList.add(model);
      }
      return await sortByMapPoiDistance(poiList);
    } else {
      Loading.error("未搜索到周边信息");
      return [];
    }
  }

  /// 逆地理编码
  /// locaiton 经纬度 传入内容规则：经度在前，纬度在后，经纬度间以“,”分割，经纬度小数点后不要超过 6 位
  /// radius 搜索半径 默认500
  /// extensions 返回结果控制 extensions 参数默认取值是 base，也就是返回基本地址信息；
  /// extensions 参数取值为 all 时会返回基本地址信息、附近 POI 内容、道路信息以及道路交叉口信息。
  static Future<List<MapPoiModel>> reverseGeocoding({
    required String location,
    String? radius = "100",
    String? extensions = "all",
  }) async {
    List<String> locationList = location.split(",");
    String lng = double.parse(locationList[0]).toStringAsFixed(6);
    String lat = double.parse(locationList[1]).toStringAsFixed(6);
    var params = {
      "key": Constants.mapKey,
      "location": "$lng,$lat",
      "radius": radius,
      "extensions": extensions,
    };
    var response = await Dio()
        .get(
          "",
          queryParameters: params,
        )
        // ignore: body_might_complete_normally_catch_error
        .catchError((onError) {});
    if (response.data["status"] == "1") {
      List<MapPoiModel> poiList = [];
      for (var item in response.data['regeocode']['pois']) {
        MapPoiModel model = MapPoiModel.fromJson(item);
        poiList.add(model);
      }
      return await sortByMapPoiDistance(poiList);
    } else {
      Loading.error("未搜索到周边信息");
      return [];
    }
  }

  /// 周边搜索
  static Future<List<MapPoiModel>> getMapAround({
    required String location,
    String? radius = "300",
    String pageSize = "25",
    String pageNum = "1",
  }) async {
    String types =
        "10000|20000|30000|40000|50000|60000|70000|80000|90000|100000|110000|120000|130000|140000|150000|160000|170000|180000|190000|200000|220000|990000";
    List<String> locationList = location.split(",");
    String lng = double.parse(locationList[0]).toStringAsFixed(6);
    String lat = double.parse(locationList[1]).toStringAsFixed(6);
    var params = {
      "key": Constants.mapKey,
      "location": "$lng,$lat",
      "radius": radius,
      "types": types,
      "page_size": pageSize,
      "page_num": pageNum,
    };
    var response = await Dio()
        .get(
          "",
          queryParameters: params,
        )
        // ignore: body_might_complete_normally_catch_error
        .catchError((onError) {});
    if (response.data["status"] == "1") {
      List<MapPoiModel> poiList = [];
      for (var item in response.data['pois']) {
        MapPoiModel model = MapPoiModel.fromJson(item);
        poiList.add(model);
      }
      return poiList;
    } else {
      Loading.error("未搜索到周边信息");
      return [];
    }
  }

  /// 根据距离进行排序 - 地图
  static Future<List<MapPoiModel>> sortByMapPoiDistance(
      List<MapPoiModel> poiList) async {
    poiList.sort((a, b) {
      double d1 = double.parse(a.distance ?? '0');
      double d2 = double.parse(b.distance ?? '0');
      return d1.compareTo(d2);
    });
    return poiList;
  }

  /// 获取附近范围内的点位信息 distance = 1 表示 1km
  static Future<List<DataPoiModel>> getDataNearbyPoint({
    required String longitude,
    required String latitude,
    String? distance = '0.5',
  }) async {
    var params = {
      "lng": longitude,
      "lat": latitude,
      "distance": distance,
    };
    var response = await HttpRequestService.to.get(
      "",
      params: params,
    );
    if (response.data["body"] != null) {
      List<DataPoiModel> poiList = [];
      for (var item in response.data['body']) {
        DataPoiModel model = DataPoiModel.fromJson(item);
        model.distance = Location.distanceBetween(
          double.parse(longitude),
          double.parse(latitude),
          model.longitude!,
          model.latitude!,
        );
        poiList.add(model);
      }
      return await sortByDataPoiDistance(poiList);
    }
    return [];
  }

  /// 根据距离进行排序 - 点位
  static Future<List<DataPoiModel>> sortByDataPoiDistance(
      List<DataPoiModel> poiList) async {
    poiList.sort((a, b) {
      double d1 = a.distance ?? 0.0;
      double d2 = b.distance ?? 0.0;
      return d1.compareTo(d2);
    });
    return poiList;
  }
}
