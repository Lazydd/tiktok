import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fps_monitor/widget/custom_widget_inspector.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'global.dart';
import 'common/index.dart';

void main() async {
  // 这个表示先就行原生端（ios android）插件注册，然后再处理后续操作，这样能保证代码运行正确。【注：不加这个强制横/竖屏会报错】
  WidgetsFlutterBinding.ensureInitialized();

  final MQTTAppState mqttAppState = MQTTAppState();

  Global.init().then((_) {
    Future.wait([]).whenComplete(() {
      runApp(MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: mqttAppState,
          ),
          ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ],
        child: Consumer2<MQTTAppState, ThemeProvider>(
          builder: (context, mqttAppState, theme, child) {
            return MyApp(
              themeProvider: theme.ensureInitialized(),
            );
          },
        ),
      ));
    });
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, this.themeProvider});

  final ThemeProvider? themeProvider;

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // GlobalKey<NavigatorState> globalKey = GlobalKey();
    // WidgetsBinding.instance.addPostFrameCallback((t) {
    //   overlayState = globalKey.currentState!.overlay!;
    // });
    return ScreenUtilInit(
      designSize: const Size(414, 896), // 设计稿中设备的尺寸(单位随意,建议dp,但在使用过程中必须保持一致)
      splitScreenMode: false, // 支持分屏尺寸
      minTextAdapt: false, // 是否根据宽度/高度中的最小值适配文字
      builder: (context, child) {
        return RefreshConfiguration(
          headerBuilder: () => ClassicHeader(
            refreshingIcon: const CupertinoActivityIndicator(),
            idleIcon: Icon(
              Icons.arrow_downward,
              color: Colors.grey,
              size: 22.sp,
            ),
            releaseIcon: Icon(Icons.refresh, color: Colors.grey, size: 22.sp),
            completeIcon: Icon(Icons.done, color: Colors.green, size: 22.sp),
            failedIcon: Icon(Icons.close, color: Colors.red, size: 22.sp),
            refreshingText: "正在刷新，请稍后...",
            completeText: "刷新成功",
            idleText: "下拉刷新",
            releaseText: "释放开始刷新",
            failedText: "刷新失败，请刷新重试",
            textStyle: TextStyle(color: Colors.grey, fontSize: 16.sp),
          ),
          footerBuilder: () => ClassicFooter(
            noDataText: "没有更多数据",
            loadingText: "正在加载...",
            idleText: "上拉加载更多",
            failedText: "加载失败，请加载重试",
            canLoadingText: "加载更多",
            textStyle: TextStyle(color: Colors.grey, fontSize: 16.sp),
          ),
          // 当列表不满一页时,是否隐藏刷新尾部
          hideFooterWhenNotFull: true,
          // 触发刷新的距离
          headerTriggerDistance: 60.h,
          // 最大的拖动距离
          maxOverScrollExtent: 100.h,
          // 触发加载的距离
          footerTriggerDistance: 150.h,
          child: GetMaterialApp(
            title: 'Tiktok',
            // showPerformanceOverlay: true,
            // navigatorKey: globalKey,

            theme: widget.themeProvider?.light?.data,
            darkTheme: widget.themeProvider?.dark?.data,
            themeMode: widget.themeProvider!.mode,
            debugShowCheckedModeBanner: false,
            initialRoute: UserFunc.jumpRouteName(false), //false 不走权限，true走权限
            getPages: RoutePages.pages,
            navigatorObservers: [RoutePages.observer],
            builder: (context, child) {
              child = EasyLoading.init()(context, child); // EasyLoading 初始化
              return MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: const TextScaler.linear(1.0)),
                child: child,
              );
            },
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget.themeProvider?.dispose();
  }
}
