part of 'index.dart';

class MapPage extends GetView<MapController> {
  /// 是否只读
  final bool isOnlyRead;

  /// 接收的经纬度
  final String receiveLocation;

  /// 接收的地名
  final String receiveName;

  /// 是否查询附近的点位数据
  final bool isNearBy;

  /// 是否需要搜索功能
  final bool isSearch;

  /// 是否需要实时定位
  final bool isRealTimePosition;
  const MapPage({
    super.key,
    this.isOnlyRead = false,
    this.receiveLocation = "",
    this.receiveName = "",
    this.isNearBy = false,
    this.isSearch = false,
    this.isRealTimePosition = false,
  });

  // 主视图
  Widget _buildView() {
    return Stack(
      alignment: Alignment.center,
      children: [
        GetBuilder<MapController>(
          id: "web_progress",
          builder: (_) {
            return Visibility(
              visible:
                  !(controller.progressValue == 0 ||
                      controller.progressValue == 1),
              child: CircularProgressIndicator(
                value: controller.progressValue,
                backgroundColor: Colors.grey[200],
                valueColor: const AlwaysStoppedAnimation(Colors.orange),
                color: Colors.white,
              ),
            );
          },
        ),
        GetBuilder<MapController>(
          id: "embed_web",
          builder: (MapController mapController) {
            return InAppWebView(
              initialSettings: InAppWebViewSettings(
                transparentBackground: true,
                cacheEnabled: false,
              ),
              initialUrlRequest: URLRequest(
                url: WebUri(mapController.innerUrl),
              ),
              // 创建控制并回调返回该控制器
              onWebViewCreated: (InAppWebViewController controller) {
                // mapController.webViewController = controller;
                // controller.addJavaScriptHandler(
                //     handlerName: 'onReceiveLocationHandler',
                //     callback: (args) {
                //       if (!isOnlyRead) {
                //         // console.warning("JavaScript主动传的方法:${args[0]}");
                //         if (args.isNotEmpty && mapController.isSuccessLocalLocation) {
                //           mapController.isReLocation = false;
                //           mapController.update(["site_web_title", "location_icon"]);
                //         }
                //       }
                //     });
                // controller.addJavaScriptHandler(
                //     handlerName: 'onInitHandler',
                //     callback: (args) {
                //       // if (mapController.isOnlyRead && mapController.receiveLocation.isNotEmpty) {
                //       //   mapController.requestReceiveLocation();
                //       // } else {
                //       //   mapController.requestCurrentLocation();
                //       // }
                //       if (!mapController.isOnlyRead && mapController.receiveLocation.isEmpty) {
                //         mapController.requestCurrentLocation();
                //       } else {
                //         mapController.requestReceiveLocation();
                //       }
                //     });
              },
              // 当 WebView 开始加载某个 URL 时触发该事件
              onLoadStart: (InAppWebViewController controller, Uri? uri) {
                mapController.innerUrl = uri.toString();
              },
              // 当 WebView 完成一个 URL 的加载时触发该事件
              onLoadStop: (InAppWebViewController controller, Uri? uri) async {
                mapController.innerUrl = uri.toString();
              },
              // 当 WebView 的主页收到 HTTP 错误时触发该事件
              onReceivedHttpError:
                  (
                    InAppWebViewController controller,
                    WebResourceRequest webResourceRequest,
                    WebResourceResponse webResourceResponse,
                  ) {
                    mapController.onWebLoadHttpError(
                      controller,
                      webResourceRequest,
                      webResourceResponse,
                    );
                  },
              // 当 WebView收到一条 JavaScript 控制台消息（如 console.log 、 console.error ）时触发该事件
              onConsoleMessage:
                  (
                    InAppWebViewController controller,
                    ConsoleMessage consoleMessage,
                  ) {
                    // console.error("consoleMessage:$consoleMessage");
                  },
              onProgressChanged: (InAppWebViewController c, int progress) {
                controller.onWebProgressChanged(c, progress);
              },
            ).height(ScreenFunc.screenHeight - mapController.locationBottom);
          },
        ),
        Positioned(
          top: ScreenFunc.statusBar + 20.w,
          left: 20.w,
          child:
              GetBuilder<MapController>(
                id: "location_submit",
                builder: (_) => Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 5.w,
                    horizontal: 15.w,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red.shade600,
                    borderRadius: BorderRadius.circular(3.r),
                  ),
                  child: const Text(
                    "取消",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ).onTap(() {
                if (isRealTimePosition) {
                  Get.back(result: controller.realDistance);
                } else {
                  Get.back();
                }
              }),
        ),
        if (!controller.isOnlyRead)
          Positioned(
            top: ScreenFunc.statusBar + 20.w,
            right: 20.w,
            child: GetBuilder<MapController>(
              id: "location_submit",
              builder: (_) =>
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 5.w,
                      horizontal: 15.w,
                    ),
                    decoration: BoxDecoration(
                      color: controller.isDone
                          ? AppColors.primary
                          : Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(3.r),
                    ),
                    child: Text(
                      "确定",
                      style: TextStyle(
                        color: controller.isDone
                            ? Colors.white
                            : Colors.grey.shade200,
                      ),
                    ),
                  ).onTap(() async {
                    if (controller.isDone) {
                      Map<String, dynamic> params = {
                        "location": controller.currentLocation.join(","),
                        "address": controller.locationName,
                      };
                      if (isNearBy) {
                        params["dataPoiModel"] = jsonEncode(
                          controller.currentDataPoi!.toJson(),
                        );
                      }
                      Get.back(result: jsonEncode(params));
                    }
                  }),
            ),
          ),
        if (controller.isRealTimePosition && Constants.jwStorageDebug)
          Positioned(
            top: ScreenFunc.statusBar + 20.w,
            right: 20.w,
            child: GetBuilder<MapController>(
              id: "location_collection",
              builder: (_) => Container(
                padding: EdgeInsets.symmetric(vertical: 5.w, horizontal: 15.w),
                decoration: BoxDecoration(
                  color: controller.isCollection ? Colors.grey : Colors.green,
                  borderRadius: BorderRadius.circular(3.r),
                ),
                child: Text(
                  controller.isCollection == false
                      ? "开始采集"
                      : "${controller.collectionTime}s",
                  style: const TextStyle(color: Colors.white),
                ),
              ).onTap(() => controller.onCollectionTap()),
            ),
          ),
      ],
    );
  }

  /// 顶部定位图标
  Widget _buildLocationIcon() {
    return GetBuilder<MapController>(
      id: "location_icon_postion",
      builder: (controller) => Positioned(
        bottom: controller.locationBottom + 20,
        left: 20,
        child:
            SizedBox(
              width: 40.w,
              height: 40.w,
              child: Padding(
                padding: EdgeInsets.only(
                  top: 8.w,
                  right: 8.w,
                  bottom: 10.w,
                  left: 10.w,
                ),
                child: GetBuilder<MapController>(
                  id: "location_icon",
                  builder: (_) => controller.isReLocation
                      ? Transform.rotate(
                          angle: 45 * pi / 180,
                          child: IconWidget.svg(
                            AssetsSvgs.relocateFillSvg,
                            color: AppColors.primary,
                          ),
                        )
                      : Transform.rotate(
                          angle: 45 * pi / 180,
                          child: IconWidget.svg(
                            AssetsSvgs.relocateSvg,
                            color: Colors.grey,
                          ),
                        ),
                ),
              ),
            ).card().onTap(() {
              controller.requestCurrentLocation();
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MapController>(
      init: MapController(
        isOnlyRead,
        receiveLocation,
        receiveName,
        isNearBy,
        isSearch,
        isRealTimePosition,
      ),
      id: "site_web",
      builder: (_) {
        return PopScope(
          onPopInvokedWithResult: (bool didPop, dynamic result) async {
            //此方法会导致iOS的右滑手势失效
            return;
          },
          child: CustomScaffold(
            body: Stack(
              children: <Widget>[
                // 主要内容
                _buildView(),
                if (!controller.isOnlyRead) _buildLocationIcon(),
                // 可拖拽的底部面板
                GetBuilder<MapController>(
                  id: "map_bottom",
                  builder: (_) => DraggableScrollableSheet(
                    initialChildSize: isOnlyRead ? 0.15 : 0.4,
                    minChildSize: isOnlyRead ? 0.15 : 0.4,
                    maxChildSize: isOnlyRead ? 0.15 : 0.7,
                    controller: controller.dragController,
                    builder: (context, scrollController) {
                      List<Widget> ws = [];
                      if (controller.isNear) {
                        for (
                          int i = 0;
                          i < controller.dataPoiList.length;
                          i++
                        ) {
                          var poi = controller.dataPoiList[i];
                          ws.add(
                            CustomCell(
                              title: Text(
                                poi.areaName ?? "",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.sp,
                                ),
                              ),
                              subtitle: Text(
                                "${poi.distance!.toStringAsFixed(1)}m | ${poi.eventTypeCodeName}",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.grey,
                                ),
                              ),
                              showCellDivider: true,
                              trailing: controller.poiId == poi.pointId
                                  ? Icon(Icons.done, color: AppColors.primary)
                                  : const SizedBox(),
                              showArrow: false,
                              onTap: () {
                                controller.onLocationDataPoiClickHandle(poi);
                              },
                            ),
                          );
                        }
                        if (controller.isLoading) {
                          ws.add(
                            Text(
                              '点位数据加载中，请稍后...',
                              style: TextStyle(
                                fontSize: 20.sp,
                                color: Colors.grey,
                              ),
                            ).paddingTop(0.1 * ScreenFunc.screenHeight),
                          );
                        } else {
                          if (controller.dataPoiList.isEmpty) {
                            ws.add(
                              Text(
                                "暂无点位数据",
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  color: Colors.grey,
                                ),
                              ).paddingTop(0.1 * ScreenFunc.screenHeight),
                            );
                          }
                        }
                      } else {
                        for (int i = 0; i < controller.mapPoiList.length; i++) {
                          var poi = controller.mapPoiList[i];
                          ws.add(
                            CustomCell(
                              title: Text(
                                poi.name ?? "",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.sp,
                                ),
                              ),
                              subtitle: Text(
                                "${Location.formatDistance(double.parse(poi.distance ?? '0'))} | ${poi.address}",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.grey,
                                ),
                              ),
                              showCellDivider: true,
                              trailing: controller.poiId == poi.id
                                  ? Icon(Icons.done, color: AppColors.primary)
                                  : const SizedBox(),
                              showArrow: false,
                              onTap: () {
                                controller.onLocationMapPoiClickHandle(poi);
                              },
                            ),
                          );
                        }
                        if (controller.isLoading) {
                          ws.add(
                            Text(
                              '地图附近数据加载中，请稍后...',
                              style: TextStyle(
                                fontSize: 20.sp,
                                color: Colors.grey,
                              ),
                            ).paddingTop(0.1 * ScreenFunc.screenHeight),
                          );
                        } else {
                          if (controller.mapPoiList.isEmpty) {
                            ws.add(
                              Text(
                                "暂无附近地图数据",
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  color: Colors.grey,
                                ),
                              ).paddingTop(0.1 * ScreenFunc.screenHeight),
                            );
                          }
                        }
                      }
                      return Stack(
                        children: [
                          Container(
                            color: Colors.white,
                            padding: const EdgeInsets.only(top: 80),
                            child: SmartRefresher(
                              controller: controller.refreshController, // 刷新控制器
                              enablePullDown: false, // 启用加载
                              enablePullUp: true, // 启用上拉加载
                              onLoading: controller.onLoading, // 上拉加载回调
                              child: CustomScrollView(
                                slivers: [
                                  SliverToBoxAdapter(
                                    child: Column(children: ws)
                                        .paddingHorizontal(AppSpace.page)
                                        .paddingBottom(ScreenFunc.bottomBar),
                                  ),
                                ],
                              ),
                            ).borderRadius(topLeft: 10.r),
                          ),
                          SingleChildScrollView(
                            physics: const ClampingScrollPhysics(),
                            controller: scrollController,
                            child: SizedBox(
                              height: 80,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20,
                                    child: Center(
                                      child: Container(
                                        width: 30.0,
                                        height: 5.0,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            50.0,
                                          ),
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: GetBuilder<MapController>(
                                      id: "site_web_title",
                                      builder: (_) => isSearch
                                          ? InputWidget.textBorder(
                                              controller: controller
                                                  .searchEditController,
                                              hintText: "请搜索地点",
                                              autofocus: false,
                                              borderRadius: 10.w,
                                              textInputAction:
                                                  TextInputAction.search,
                                              icon: IconWidget.svg(
                                                AssetsSvgs.searchSvg,
                                                color: AppColors.info,
                                                size: 20,
                                              ),
                                              suffixIcon: <Widget>[
                                                if (controller
                                                    .searchKeyWord
                                                    .isNotEmpty)
                                                  Icon(
                                                        Icons.close,
                                                        color: AppColors.info,
                                                      )
                                                      .paddingRight(10.w)
                                                      .onTap(
                                                        () => controller
                                                            .onClearTextFieldHandle(),
                                                      ),
                                                Container(
                                                  color: AppColors.info,
                                                  width: 0.5.w,
                                                  height: AppSpace.page,
                                                ).paddingRight(0.w),
                                                Text(
                                                      "搜索",
                                                      style: TextStyle(
                                                        color: Colors.blue,
                                                        fontSize: 16.sp,
                                                      ),
                                                    )
                                                    .paddingHorizontal(15.w)
                                                    .paddingVertical(10.w)
                                                    .onTap(() {
                                                      FocusScope.of(
                                                        Get.context!,
                                                      ).requestFocus(
                                                        FocusNode(),
                                                      ); //收起键盘
                                                      controller.onSubmitSearch(
                                                        controller
                                                            .searchEditController
                                                            .text,
                                                      );
                                                    }),
                                              ].toRow(mainAxisSize: MainAxisSize.min),
                                              onSubmitted: (String value) {
                                                controller.onSubmitSearch(
                                                  value,
                                                );
                                              },
                                              onChanged: (String value) {
                                                controller.onChangeValueHandle(
                                                  value,
                                                );
                                              },
                                            )
                                          : Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                if (controller.titleStatus ==
                                                    TitleStatusEnum.success)
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              controller
                                                                  .locationName,
                                                              softWrap: false,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                fontSize: 20.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            Text(
                                                              controller
                                                                  .currentTitle,
                                                              softWrap: false,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                fontSize: 15.sp,
                                                                color: AppColors
                                                                    .primary,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      if (isRealTimePosition)
                                                        Row(
                                                          children: [
                                                            Text(
                                                              controller
                                                                  .realDistance,
                                                              style: TextStyle(
                                                                color: AppColors
                                                                    .primary,
                                                                fontSize: 18.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            Icon(
                                                              Icons.copy_all,
                                                              color: AppColors
                                                                  .primary,
                                                            ),
                                                          ],
                                                        ).onTap(
                                                          () => controller
                                                              .onDistanceToast(),
                                                        ),
                                                    ],
                                                  ),
                                                if (controller.titleStatus !=
                                                    TitleStatusEnum.success)
                                                  Text.rich(
                                                    textAlign: TextAlign.center,
                                                    TextSpan(
                                                      children: [
                                                        if (controller
                                                                .titleStatus ==
                                                            TitleStatusEnum
                                                                .loading)
                                                          WidgetSpan(
                                                            child: SizedBox(
                                                              width: 20,
                                                              height: 20,
                                                              child: CircularProgressIndicator(
                                                                strokeWidth: 2,
                                                                color: AppColors
                                                                    .primary,
                                                              ),
                                                            ).paddingRight(10.w),
                                                          ),
                                                        if (controller
                                                                .titleStatus ==
                                                            TitleStatusEnum
                                                                .error)
                                                          WidgetSpan(
                                                            child: const Icon(
                                                              Icons
                                                                  .error_outline_rounded,
                                                              color: Colors.red,
                                                            ).paddingRight(10.w),
                                                          ),
                                                        TextSpan(
                                                          text: controller
                                                              .currentTitle,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 17.sp,
                                                            color: AppColors
                                                                .primary,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                              ],
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                            ).paddingHorizontal(AppSpace.page),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
