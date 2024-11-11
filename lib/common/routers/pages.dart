part of routers;

abstract class RoutePages {
  static final RouteObserver<Route> observer = RouteObservers();
  static List<String> history = [];

  static final List<GetPage> pages = [
    // 页面跳转方式
    GetPage(
      name: RouteNames.mainRoute,
      page: () => const MainPage(),
      customTransition: RouteTransition(),
      // binding: MainBinding(),
    ),
    GetPage(
      name: RouteNames.loginRoute,
      page: () => const LoginPage(),
    ),

    /// 系统
    GetPage(
      name: RouteNames.homeRoute,
      page: () => const HomePage(),
      customTransition: RouteTransition(),
      // binding: MainBinding(),
    ),
    GetPage(
      name: RouteNames.repairRoute,
      page: () => const FriendPage(),
      // customTransition: RouteTransition(),
      // binding: MainBinding(),
    ),
    GetPage(
      name: RouteNames.messageRoute,
      page: () => const MessagePage(),
      // customTransition: RouteTransition(),
      // binding: MainBinding(),
    ),
    GetPage(
      name: RouteNames.mineRoute,
      page: () => const MinePage(),
      // customTransition: RouteTransition(),
      // binding: MainBinding(),
    ),
    GetPage(
      name: RouteNames.editRoute,
      page: () => const EditPage(),
      // customTransition: RouteTransition(),
      // binding: MainBinding(),
    ),
    GetPage(
      name: RouteNames.editUserInfoRoute,
      page: () => EditUserInfoPage(
        type: Get.parameters["type"]!,
        value: Get.parameters["value"]!,
      ),
      // customTransition: RouteTransition(),
      // binding: MainBinding(),
    ),
    GetPage(
      name: RouteNames.addfriendRoute,
      page: () => const AddfriendPage(),
      // customTransition: RouteTransition(),
      // binding: MainBinding(),
    ),
    GetPage(
      name: RouteNames.publishRoute,
      page: () => const PublishPage(),
      // customTransition: RouteTransition(),
      // binding: MainBinding(),
    ),

    GetPage(
      name: RouteNames.systemConfigRoute,
      page: () => const SystemConfigPage(),
    ),
    GetPage(
      name: RouteNames.appUpdateRoute,
      page: () => const AppUpdatePage(),
    ),
    GetPage(
      name: RouteNames.scanCodeRoute,
      page: () => const ScanCodePage(),
    ),
    GetPage(
      name: RouteNames.chatRoute,
      page: () => ChatPage(peerId: Get.parameters['peerId']!),
    ),
    GetPage(
      name: RouteNames.rtcRoute,
      page: () => RtcPage(
        isDial: Get.parameters['isDial'].toString(),
      ),
    ),
    GetPage(
      name: RouteNames.rtcMoreRoute,
      page: () => RtcMorePage(
        isDial: Get.parameters['isDial'].toString(),
      ),
    ),
    GetPage(
      name: RouteNames.mapRoute,
      page: () => MapPage(
        isOnlyRead: Get.parameters["isOnlyRead"].toString() == "true",
        receiveLocation: Get.parameters["receiveLocation"].toString(),
        receiveName: Get.parameters["receiveName"].toString(),
        isNearBy: Get.parameters["isNearBy"].toString() == "true",
        isSearch: Get.parameters["isSearch"].toString() == "true",
        isRealTimePosition:
            Get.parameters["isRealTimePosition"].toString() == "true",
      ),
    ),
  ];
}
