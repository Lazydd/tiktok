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
        type: Get.parameters["type"],
        value: Get.parameters["value"],
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
  ];
}
