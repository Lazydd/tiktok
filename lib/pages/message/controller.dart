part of 'index.dart';

class MessageController extends GetxController {
  MessageController();

  List<Map<String, dynamic>> topList = [
    {"name": "何以为家", "avatar": '${Constants.imagesUrl}/assets/0-DZZhXKhG.png'},
    {
      "name": "浅唱↘我们的歌",
      "avatar": '${Constants.imagesUrl}/assets/19-o5iDqnlP.png',
    },
    {
      "name": "‘心’之天空",
      "avatar": '${Constants.imagesUrl}/assets/25-BpMlL2TV.png',
    },
    {
      "name": "◇、_保持微笑ゞ",
      "avatar": '${Constants.imagesUrl}/assets/18-B1BHsmp3.png',
    },
    {
      "name": "好◇°我会Yi直在●",
      "avatar": '${Constants.imagesUrl}/assets/26-D4xua0cq.png',
    },
    {"name": "甫韦茹", "avatar": '${Constants.imagesUrl}/assets/4-Bth7xBtO.png'},
    {"name": "幸福泡泡", "avatar": '${Constants.imagesUrl}/assets/12-rrjFLbXW.png'},
    {"name": "蔡傲安", "avatar": '${Constants.imagesUrl}/assets/3-CI9vl2P3.png'},
    {
      "name": "心若向阳无谓伤悲",
      "avatar": '${Constants.imagesUrl}/assets/16-P9UU56wt.png',
    },
    {
      "name": "A倒影着稚嫩的少年",
      "avatar": '${Constants.imagesUrl}/assets/10-Blhm8lgt.png',
    },
    {
      "name": "℉阳光下的小情绪",
      "avatar": '${Constants.imagesUrl}/assets/14-B48u_Fz3.png',
    },
    {
      "name": "思念一直在",
      "avatar": '${Constants.imagesUrl}/assets/11-Ckfe3bFJ.png',
    },
    {"name": "阎韶丽", "avatar": '${Constants.imagesUrl}/assets/9-D9sQQ2wH.png'},
    {"name": "马佳婉清", "avatar": '${Constants.imagesUrl}/assets/5-DWyY12-8.png'},
    {"name": "买易槐", "avatar": '${Constants.imagesUrl}/assets/8-iptKbolh.png'},
    {"name": "章昊苍", "avatar": '${Constants.imagesUrl}/assets/7-D4XYyVtS.png'},
    {
      "name": "状态设置",
      "avatar": '${Constants.imagesUrl}/assets/setting-BQOxwgbp.png',
    },
  ];

  List<Map<String, dynamic>> messageList = [
    {
      "name": "新朋友",
      "avatar": '${Constants.imagesUrl}/assets/msg-icon1-DJyp8a5e.png',
      "content": 'xxx关注了你',
      "noRead": false,
      "type": 1,
      "sys": false,
    },
    {
      "name": "互动消息",
      "avatar": '${Constants.imagesUrl}/assets/msg-icon2-Bn3qfJvM.png',
      "content": 'xxx近期访问过你的主页',
      "noRead": false,
      "type": 2,
      "sys": false,
    },
    {
      "name": "杨老虎🐯（单人）",
      "avatar": '${Constants.imagesUrl}/assets/2-BN5PI5K_.png',
      "content": '哈哈哈哈哈哈',
      "date": "09-13",
      "noRead": 2,
      "type": 3,
      "id": '0',
      "sys": false,
    },
    {
      "name": "杨老虎🐯（多人）",
      "avatar": '${Constants.imagesUrl}/assets/2-BN5PI5K_.png',
      "content": '哈哈哈哈哈哈',
      "date": "09-13",
      "noRead": 2,
      "type": 3,
      "id": '2',
      "sys": false,
    },
    {
      "name": "抖音小助手",
      "avatar": '${Constants.imagesUrl}/assets/msg-icon5-CT2-p36i.webp',
      "content": "#今天谁请客呢",
      "date": "星期四",
      "noRead": true,
      "type": 1,
      "sys": false,
    },
    {
      "name": "系统通知",
      "avatar": '${Constants.imagesUrl}/assets/msg-icon4-vDykjBaw.png',
      "content": "协议修订通知",
      "date": "08-31",
      "noRead": true,
      "type": 1,
      "sys": false,
    },
    {
      "name": "求更新",
      "avatar": AssetsImages.msgIcon6,
      "content": "你收到过1次求更新",
      "date": "08-31",
      "noRead": true,
      "type": 1,
      "sys": true,
    },
    {
      "name": "任务通知",
      "avatar": AssetsImages.msgIcon7,
      "content": "发作品得流量",
      "date": "05-26",
      "noRead": true,
      "type": 1,
      "sys": true,
    },
    {
      "name": "直播通知",
      "avatar": AssetsImages.msgIcon8,
      "content": "举报结果通知",
      "date": "05-26",
      "noRead": true,
      "type": 1,
      "sys": true,
    },
    {
      "name": "钱包通知",
      "avatar": AssetsImages.msgIcon9,
      "content": "卡券发放提醒",
      "date": "05-26",
      "noRead": true,
      "type": 1,
      "sys": true,
    },
  ];

  void _messageDetail(dynamic item) {
    if (item['type'] == 3) {
      Get.toNamed(
        RouteNames.chatRoute,
        parameters: {"peerId": item['id'], "name": item['name']},
      );
    }
  }

  void _initData() {
    update(["message"]);
  }

  void onTap() {}

  void deleteMessage(dynamic item) {
    messageList.remove(item);
    update(["message"]);
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

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
