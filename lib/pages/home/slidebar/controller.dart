part of 'index.dart';

class SlidebarController extends GetxController {
  SlidebarController();

  static List<Map<String, dynamic>> appletList = [
    {
      "name": "懂车帝",
      "icon": Icons.account_balance_wallet,
      "onTap": () => Get.toNamed(RouteNames.messageRoute),
    },
  ];

  static List<Map<String, dynamic>> commonList = [
    {
      "name": "我的钱包",
      "icon": Icons.account_balance_wallet,
      "onTap": () => Get.toNamed(RouteNames.messageRoute),
    },
    {
      "name": "优惠券",
      "icon": Icons.confirmation_number,
      "onTap": () => Get.toNamed(''),
    },
    {"name": "小程序", "icon": Icons.api, "onTap": () => Get.toNamed('')},
    {"name": "观看历史", "icon": Icons.schedule, "onTap": () => Get.toNamed('')},
    {"name": "内容偏好", "icon": Icons.assignment, "onTap": () => Get.toNamed('')},
    {
      "name": "离线模式",
      "icon": Icons.cloud_download,
      "onTap": () => Get.toNamed(''),
    },
    {"name": "稍后再看", "icon": Icons.timelapse, "onTap": () => Get.toNamed('')},
  ];

  static List<Map<String, dynamic>> lifeList = [
    {
      "name": "直播广场",
      "icon": Icons.videocam,
      "onTap": () => Get.toNamed(RouteNames.messageRoute),
    },
    {
      "name": "附近团购",
      "icon": Icons.restaurant_menu,
      "onTap": () => Get.toNamed(''),
    },
    {"name": "活动中心", "icon": Icons.flag, "onTap": () => Get.toNamed('')},
    {"name": "听抖音", "icon": Icons.headphones, "onTap": () => Get.toNamed('')},
    {"name": "放映厅", "icon": Icons.play_circle, "onTap": () => Get.toNamed('')},
    {"name": "K歌", "icon": Icons.mic, "onTap": () => Get.toNamed('')},
  ];

  _initData() {
    update(["slidebar"]);
  }

  void onTap() {}

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
