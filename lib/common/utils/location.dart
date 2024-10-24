import 'package:geolocator/geolocator.dart';

// 经纬度测试网址 https://lbsyun.baidu.com/jsdemo/demo/yLngLatLocation.htm
class Location {
  /// 定位权限请求
  static Future<dynamic> requestLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      return false;
    } else {
      var res = await getCurrentLocation();
      return res;
    }
  }

  /// 获取当前定位
  static Future<Position?> getCurrentLocation(
      {LocationAccuracy? accuracy}) async {
    try {
      var pos = await Geolocator.getCurrentPosition(
        timeLimit: const Duration(milliseconds: 500),
        desiredAccuracy: accuracy ?? LocationAccuracy.high,
        forceAndroidLocationManager: true,
      );
      return pos;
    } catch (e) {
      return Geolocator.getLastKnownPosition(forceAndroidLocationManager: true);
    }
  }

  /// 计算定位间的距离 A点起始经纬度 - B点结束经纬度
  static double distanceBetween(
      double lng1, double lat1, double lng2, double lat2) {
    // console.log(
    //     "${Geolocator.distanceBetween(120.22672515213924, 30.209069515780577, 120.22672515213924, 30.201069515780577)}");
    return Geolocator.distanceBetween(lat1, lng1, lat2, lng2);
  }

  /// 距离单位
  static String formatDistance(double distance) {
    if (distance < 1000) {
      return '${distance.toStringAsFixed(1)}m';
    } else {
      double kmDistance = distance / 1000;
      return '${kmDistance.toStringAsFixed(1)}km';
    }
  }
}
