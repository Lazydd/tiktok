// ignore_for_file: no_leading_underscores_for_local_identifiers

part of 'index.dart';

enum TitleStatusEnum {
  first, // 第一次
  loading, // 加载中
  error, // 无经纬度数据
  success, // 成功
}

class MapController extends GetxController {
  MapController(
    bool _isOnlyRead,
    String _receiveLocation,
    String _receiveName,
    bool _isNearBy,
    bool _isSearch,
    bool _isRealTimePosition,
  ) {
    isOnlyRead = _isOnlyRead;
    receiveLocation = _receiveLocation;
    isNear = _isNearBy;
    isSearch = _isSearch;
    isRealTimePosition = _isRealTimePosition;
    if (_receiveName.isEmpty && _isOnlyRead) {
      locationName = "未知区域";
    } else {
      locationName = _receiveName.isNotEmpty ? _receiveName : "当前位置";
    }
    locationBottom = _isOnlyRead
        ? ScreenFunc.screenHeight * 0.15
        : ScreenFunc.screenHeight * 0.4;
  }

  /// 是否只读
  late bool isOnlyRead;

  /// 接收到的位置
  late String receiveLocation;

  /// 是否展示附近的点位
  late bool isNear;

  /// 是否文本框搜索
  late bool isSearch;

  /// 是否实时定位
  late bool isRealTimePosition;

  // web控制器
  late InAppWebViewController webViewController;

  /// url地址
  String innerUrl = "https://www.baidu.com";
  // String innerUrl = "${Constants.mainBaseUrl}/maps";

  /// 当前的经纬度
  String currentTitle = "加载中，请稍后...";
  TitleStatusEnum titleStatus = TitleStatusEnum.loading;

  /// 经度纬度数组
  List<double> currentLocation = [];

  bool isSuccessLocalLocation = false;

  /// 是否进行重定位
  bool isReLocation = false;

  /// 拖拽组件controller
  DraggableScrollableController dragController =
      DraggableScrollableController();

  /// 定位的位置
  double locationBottom = 0; // ScreenFunc.screenHeight * 0.4

  /// 当前选择的地名
  String locationName = "";

  /// 附近POI列表
  List<MapPoiModel> mapPoiList = [];

  /// 附近点位列表
  List<DataPoiModel> dataPoiList = [];

  String poiId = "";

  bool isLoading = true;

  /// 是否完成
  bool isDone = false;

  /// 当前选的点位
  DataPoiModel? currentDataPoi;

  /// 上下拉刷新控制器
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  // 页码
  int _page = 1;
  // 页尺寸
  final int _limit = 25;
  // 上拉加载
  void onLoading() async {
    if (mapPoiList.isNotEmpty && mapPoiList.length == _limit * _page) {
      double lng = currentLocation[0];
      double lat = currentLocation[1];
      onGPStoCGCSJS(lng, lat, (lng1, lat1) async {
        _page++;
        List<MapPoiModel> tmpList = await MapAPI.getMapAround(
          location: "$lng1,$lat1",
          pageSize: _limit.toString(),
          pageNum: _page.toString(),
        );
        mapPoiList.addAll(tmpList);
        if (mapPoiList.isNotEmpty) {
          onLocationMapPoiClickHandle(mapPoiList[0], isCenter: false);
        }
        // 加载完成
        refreshController.loadComplete();
        update(["map_bottom"]);
      });
    } else {
      refreshController.loadNoData();
    }
  }

  // web 提供的相关方法 =======================

  // 当 WebView 的主页收到 HTTP 错误时触发该事件
  onWebLoadHttpError(
      InAppWebViewController controller,
      WebResourceRequest webResourceRequest,
      WebResourceResponse webResourceResponse) {}

  /// 获取当前定位数据
  requestCurrentLocation() async {
    var res = await Location.requestLocation();
    currentTitle = "获取当前定位信息中，请稍后...";
    titleStatus = TitleStatusEnum.loading;
    // console.log("res:$res");
    update(["site_web_title"]);
    await Future.delayed(const Duration(milliseconds: 500));
    currentLocation = [];
    if (res != null && res != false) {
      Position position = res as Position;
      await Future.delayed(const Duration(milliseconds: 500));
      currentLocation.add(position.longitude);
      currentLocation.add(position.latitude);
      currentTitle = "${position.longitude} & ${position.latitude}";
      titleStatus = TitleStatusEnum.success;
      isReLocation = true;
      isDone = true;
      onSetMapCenterEvaluateJS();
      // 是否查询附近点位，若否则使用高德接口查询
      if (isNear) {
        onInitNearByMapPOI();
      } else {
        if (isSearch) {
          searchKeyWord.value = "";
          searchEditController.text = "";
        }
        onInitMapPOI();
      }
      isSuccessLocalLocation = true;
      update(["site_web"]);
    }
    if (res == false) {
      isSuccessLocalLocation = false;
      currentTitle = "重新点击左侧箭头即可使用定位功能";
      titleStatus = TitleStatusEnum.first;
    }
    if (res == null) {
      currentTitle = "请在空旷且网络环境良好的地方进行定位";
      isSuccessLocalLocation = false;
      titleStatus = TitleStatusEnum.error;
    }
    update(["site_web_title", "location_icon"]);
  }

  /// 定位外部传值的定位数据
  requestReceiveLocation() {
    if (receiveLocation.isNotEmpty) {
      List locationList = receiveLocation.split(",");
      currentLocation.add(double.parse(locationList[0]));
      currentLocation.add(double.parse(locationList[1]));
      currentTitle = "${locationList[0]} & ${locationList[1]}";
      isSuccessLocalLocation = true;
      isReLocation = false;
      titleStatus = TitleStatusEnum.success;
      onSetMapCenterEvaluateJS();
      if (!isOnlyRead) {
        if (isNear) {
          onInitNearByMapPOI();
        } else {
          onInitMapPOI();
        }
        isDone = true;
      }
      if (isRealTimePosition) {
        getRealLocation();
        periodGetRealTimeLocation();
      }
    } else {
      currentTitle = "获取失败,请检查是否有定位数据";
      titleStatus = TitleStatusEnum.error;
      isSuccessLocalLocation = false;
    }
    update(["site_web", "site_web_title", "location_icon"]);
  }

  /// 获取周边POI
  onInitMapPOI() async {
    isLoading = true;
    _page = 1;
    double lng = currentLocation[0];
    double lat = currentLocation[1];
    mapPoiList = [];
    update(["map_bottom"]);
    // GPS转高德
    onGPStoCGCSJS(lng, lat, (lng1, lat1) async {
      if (isSearch && searchKeyWord.value.isNotEmpty) {
        mapPoiList = await MapAPI.searchText(
          searchValue: searchKeyWord.value,
          location: "$lng1,$lat1",
        );
      } else {
        mapPoiList = await MapAPI.getMapAround(
          location: "$lng1,$lat1",
          pageSize: _limit.toString(),
          pageNum: _page.toString(),
        );
      }

      if (mapPoiList.isNotEmpty) {
        onLocationMapPoiClickHandle(
          mapPoiList[0],
          isCenter: isSearch ? true : false,
        );
      }
      isLoading = false;
      update(["map_bottom"]);
    });
  }

  /// 接口获取周围点位数据
  onInitNearByMapPOI() async {
    isLoading = true;
    double lng = currentLocation[0];
    double lat = currentLocation[1];
    // 测试经纬度 35.274736	113.869655
    dataPoiList = await MapAPI.getDataNearbyPoint(
      longitude: lng.toString(),
      latitude: lat.toString(),
    );
    if (dataPoiList.isNotEmpty) {
      onLocationDataPoiClickHandle(dataPoiList[0], isCenter: false);
    }
    onRenderAreaPointList(dataPoiList);
    isLoading = false;
    update(["map_bottom"]);
  }

  /// Map POI点击事件
  onLocationMapPoiClickHandle(MapPoiModel poi, {bool isCenter = true}) {
    if (poi.id != null && poi.id != poiId) {
      poiId = poi.id!;
      locationName = poi.name!;
      List locationList = poi.location!.split(",");
      double lng = double.parse(locationList[0]);
      double lat = double.parse(locationList[1]);
      // 高德转GPS
      onCGCStoGPSJS(lng, lat, (lng1, lat1) {
        currentLocation = [];
        currentLocation.add(lng1);
        currentLocation.add(lat1);
        currentTitle = "$lng1 & $lat1";
        onRenderCenterEvaluateJS(lng1, lat1);
        if (isCenter) {
          isReLocation = false;
          onPanToCenterJS(lng1, lat1);
        }
        update(["map_bottom", "site_web_title", "location_icon"]);
      });
    }
  }

  /// 后台获取 Data POI点击事件
  onLocationDataPoiClickHandle(DataPoiModel poi, {bool isCenter = true}) {
    if (poi.pointId != null && poi.pointId != poiId) {
      poiId = poi.pointId!;
      locationName = poi.areaName!;
      double lng = poi.longitude!;
      double lat = poi.latitude!;
      currentDataPoi = poi;
      // =======
      currentLocation = [];
      currentLocation.add(lng);
      currentLocation.add(lat);
      currentTitle = "$lng & $lat";
      onRenderCenterEvaluateJS(lng, lat);
      if (isCenter) {
        isReLocation = false;
        onPanToCenterJS(lng, lat);
      }
      update(["map_bottom", "site_web_title", "location_icon"]);
      // 高德转GPS
      /*
      onCGCStoGPSJS(lng, lat, (lng1, lat1) {
        currentLocation = [];
        currentLocation.add(lng1);
        currentLocation.add(lat1);
        currentTitle = "$lng1 & $lat1";
        onRenderCenterEvaluateJS(lng1, lat1);
        if (isCenter) {
          isReLocation = false;
          onPanToCenterJS(lng1, lat1);
        }
        update(["map_bottom", "site_web_title", "location_icon"]);
      });
      */
    }
  }

  // ================== js方法 ==================
  /// 设置经纬度返回中心点位 - JS方法
  onSetMapCenterEvaluateJS() {
    if (currentLocation.isNotEmpty) {
      String yourCode =
          "window.mapSetCenter(${currentLocation[0]},${currentLocation[1]})";
      onJavaScriptEvaluate(yourCode, (value) {});
    }
  }

  /// 绘制中心点位 - 只有在可拖动地图的情况下且接收到js的回调时触发
  onRenderCenterEvaluateJS(double longitude, double latitude) {
    if (currentLocation.isNotEmpty) {
      String yourCode = "window.renderCustomPoint($longitude,$latitude)";
      onJavaScriptEvaluate(yourCode, (value) {});
    }
  }

  /// 指定某个经纬度为中点
  onPanToCenterJS(double longitude, double latitude) {
    if (currentLocation.isNotEmpty) {
      String yourCode = "window.panTo($longitude,$latitude)";
      onJavaScriptEvaluate(yourCode, (value) {});
    }
  }

  /// Google坐标系 转 高德坐标系
  onGPStoCGCSJS(double longitude, double latitude, cb) {
    if (currentLocation.isNotEmpty) {
      String yourCode = "window.gpsTogcj($longitude,$latitude)";
      onJavaScriptEvaluate(yourCode, (value) {
        if (value.runtimeType.toString() == "List<dynamic>" ||
            value.runtimeType.toString() == "List<Object?>") {
          double lng = value[0];
          double lat = value[1];
          cb(lng, lat);
        }
      });
    }
  }

  /// 高德坐标系 转 Google坐标系
  onCGCStoGPSJS(double longitude, double latitude, cb) {
    if (currentLocation.isNotEmpty) {
      String yourCode = "window.gcjTogps($longitude,$latitude)";
      onJavaScriptEvaluate(yourCode, (value) {
        if (value.runtimeType.toString() == "List<dynamic>" ||
            value.runtimeType.toString() == "List<Object?>") {
          double lng = value[0];
          double lat = value[1];
          cb(lng, lat);
        }
      });
    }
  }

  /// 在地图上渲染所有点位的位置
  onRenderAreaPointList(List<DataPoiModel> dataPoiList) {
    List<Map<String, dynamic>> pointMapList = dataPoiList.map((point) {
      return point.toJson();
    }).toList();
    if (currentLocation.isNotEmpty) {
      String yourCode =
          "window.renderAreaPointList(${jsonEncode(pointMapList)})";
      onJavaScriptEvaluate(yourCode, (value) {});
    }
  }

  /// 触发JavaScript方法
  onJavaScriptEvaluate(String jsSourceCode, cb) {
    webViewController.evaluateJavascript(source: jsSourceCode).then((value) {
      // console.error("触发JS之后进行回调:$value");
      cb(value);
    });
  }

  // ================== js方法 ==================

  // ================== 实时定位 ==================
  /// 实时定位所需的定时器
  late Timer timer;

  /// 当前经度纬度数组
  List<double> realTimeLocation = [];

  /// 实时距离
  String realDistance = '0m';

  /// 提示目标位置和实时定位之间的信息
  onDistanceToast() {
    double targetLng = currentLocation[0];
    double targetLat = currentLocation[1];
    double realLng = realTimeLocation[0];
    double realLat = realTimeLocation[1];
    String targetInfo = "目标位置【蓝】：$targetLng & $targetLat";
    String currentInfo = "当前位置【红】：$realLng & $realLat";
    String result = "$targetInfo\n$currentInfo\n距离：$realDistance";
    Clipboard.setData(ClipboardData(text: result));
    Loading.toast("经纬度已复制");
  }

  /// 触发获取当前位置
  void periodGetRealTimeLocation() async {
    timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      getRealLocation();
      if (isCollection) {
        collectionTime += 3;
        update(["location_collection"]);
        if (collectionTime > collectionMaxTime) {
          collectionTime = 0;
          isCollection = false;
          update(["location_collection"]);
          String result = seriesGPSList.join("\n");
          Clipboard.setData(ClipboardData(text: result));
          Loading.toast("经纬度已复制");
        }
      }
    });
  }

  /// 获取定位信息
  getRealLocation() async {
    var res = await Location.requestLocation();
    if (res != null && res != false) {
      Position position = res as Position;
      double lng = position.longitude;
      double lat = position.latitude;
      if (isCollection) {
        if (collectionTime == 3) {
          seriesGPSList.add("${DateTime.now()} - $lng,$lat");
        } else {
          seriesGPSList.add("$collectionTime - $lng,$lat");
        }
      }
      realTimeLocation = [lng, lat];
      onRenderCenterEvaluateJS(lng, lat);
      realDistance = Location.formatDistance(Location.distanceBetween(
          currentLocation[0], currentLocation[1], lng, lat));
      update(["site_web_title"]);
    }
  }

  /// 是否采集连续定位数据
  bool isCollection = false;

  /// 采集的数据
  List<String> seriesGPSList = [];

  /// 采集时间
  int collectionTime = 0;

  int collectionMaxTime = 60;

  /// 点击开始采集方法
  void onCollectionTap() {
    if (isCollection == false) {
      isCollection = true;
      collectionTime = 0;
      seriesGPSList = [];
    }
  }

  /// 搜索控制器
  final TextEditingController searchEditController = TextEditingController();

  /// 搜索关键词
  final searchKeyWord = "".obs;

  /// 每次输入 - 防抖处理
  onChangeValueHandle(String value) {
    UtilsFunc.debounce(() {
      searchKeyWord.value = value;
      update(["site_web_title"]);
    }, durationTime: 500);
  }

  onSubmitSearch(String value) {
    searchKeyWord.value = value;
    onInitMapPOI();
  }

  /// 清空文本框
  onClearTextFieldHandle() {
    searchKeyWord.value = "";
    searchEditController.clear();
    // onSubmitSearch("");
    update(["site_web_title"]);
  }

  _initData() {
    dragController.addListener(() {
      // console.log("监听了:${dragController.size}");
      //  dragController.jumpTo(0.5);
      double currentSize = dragController.size;
      locationBottom = currentSize * ScreenFunc.screenHeight;
      update(["location_icon_postion", "embed_web"]);
    });
    update(["site_web"]);
  }

  double progressValue = 0;
  onWebProgressChanged(InAppWebViewController controller, int progress) {
    if (progress == 100) {}
    progressValue = progress == 100 ? 0 : progress / 100;
    update(["web_progress"]);
  }

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  @override
  void onClose() {
    super.onClose();
    // webViewController.clearCache();
    dragController.dispose();
    searchEditController.dispose();
    if (isRealTimePosition) {
      timer.cancel();
    }
  }
}
