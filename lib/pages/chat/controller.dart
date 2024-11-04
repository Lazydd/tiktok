part of chat;

class ChatController extends GetxController {
  final String peerId;
  ChatController(this.peerId);

  final AutoScrollController _scrollController = AutoScrollController();
  late ChatBottomPanelContainerController panelController;

  _initData() {
    final textMessage = types.TextMessage(
      author: _user2,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: 'a13d1sfa31df32s1d3324f',
      text:
          'helloworldhelloworldhelloworldhelloworldhelloworldhelloworldhelloworldhelloworldhelloworldhelloworldhelloworldhelloworldhelloworldhelloworldhelloworldhelloworldhelloworldhelloworldhelloworldhelloworldhelloworldhelloworldhelloworldhelloworldhelloworldhelloworldhelloworldhelloworldhelloworldhelloworldhelloworld',
    );
    _addMessage(textMessage);
    _handleEndReached();
    // _connectMQTT();
    _initRTM();
    update(["chat"]);
  }

  int _page = 1311;
  bool _isLastPage = false;
  List<types.Message> _messages = [];

  Future<void> _handleEndReached() async {
    // final uri = Uri.parse(
    //   'https://api.instantwebtools.net/v1/passenger?page=$_page&size=20',
    // );
    var response = await HttpRequestService.to.get(
      '/v1/passenger',
      params: {'page': _page, 'size': 20},
    );
    final Map<String, dynamic> json = response.data;
    if (_page >= json['totalPages'] - 1) {
      _isLastPage = true;
    }
    final data = json['data'] as List<dynamic>;

    final messages = data
        .map(
          (e) => types.TextMessage(
            author: _user,
            id: e['_id'] as String,
            text: e['name'] as String,
          ),
        )
        .toList();

    _messages = [..._messages, ...messages];
    _page = _page + 1;
    update(["chat"]);
  }

  final _user = const types.User(
    id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
  );

  final _user2 = const types.User(
    id: 'otheruser',
    firstName: "テスト",
    lastName: "太郎",
    imageUrl:
        "https://pbs.twimg.com/profile_images/1335856760972689408/Zeyo7jdq_bigger.jpg",
  );

  void _addMessage(types.Message message) {
    _messages.insert(0, message);
    update(['chat']);
  }

  Map<String, types.Status> aaa = {
    '0': types.Status.delivered,
    '1': types.Status.error,
    '2': types.Status.seen,
    '3': types.Status.sending,
    '4': types.Status.sent,
  };

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: message.text,
      status: types.Status.delivered,
    );
    _addMessage(textMessage);

    // manager.publish(message.text);
    rtmClient.sendPeerMessage(peerId, message.text);
  }

  List<Map<String, dynamic>> get list => [
        {
          "icon": CupertinoIcons.photo,
          "name": "照片",
          "ontap": () async {
            dynamic fileObj = await Access.showPhotoLibrary(Get.context!);
            File? file = await UtilsFunc.compressImage(fileObj["file"]);
            final bytes = await file!.readAsBytes();
            final image = await decodeImageFromList(bytes);
            final message = types.ImageMessage(
              author: const types.User(
                id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
              ),
              createdAt: DateTime.now().millisecondsSinceEpoch,
              height: image.height.toDouble(),
              width: image.width.toDouble(),
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              name: 'result.name',
              size: bytes.length,
              uri:
                  'https://via.placeholder.com/1001x100.png/ffffff/6f61e8?text=I+love+Flyer+Chat+:)',
            );
            _addMessage(message);
          }
        },
        {
          "icon": CupertinoIcons.photo_camera,
          "name": "拍摄",
          "ontap": () async {
            dynamic fileObj = await Access.showTakePhoto(Get.context!);
            File? file = await UtilsFunc.compressImage(
              fileObj["file"],
              rotate: fileObj["rotate"],
            );
            final bytes = await file!.readAsBytes();
            final image = await decodeImageFromList(bytes);
            final message = types.ImageMessage(
              author: const types.User(
                id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
              ),
              createdAt: DateTime.now().millisecondsSinceEpoch,
              height: image.height.toDouble(),
              width: image.width.toDouble(),
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              name: 'result.name',
              size: bytes.length,
              uri:
                  'https://via.placeholder.com/1001x100.png/ffffff/6f61e8?text=I+love+Flyer+Chat+:)',
            );
            _addMessage(message);
          }
        },
        {
          "icon": CupertinoIcons.videocam_fill,
          "name": "视频通话",
          "ontap": () {
            showCupertinoModalPopup(
              context: Get.context!,
              builder: (BuildContext context) => CupertinoActionSheet(
                actions: [
                  CupertinoActionSheetAction(
                    onPressed: () {
                      Get.back();
                      panelController.updatePanelType(ChatBottomPanelType.none);
                      Get.toNamed(
                        RouteNames.rtcRoute,
                        parameters: {"isDial": "true"},
                      );
                    },
                    child: const Text('视频通话'),
                  ),
                  CupertinoActionSheetAction(
                    onPressed: () {
                      Get.back();
                      panelController.updatePanelType(ChatBottomPanelType.none);
                      Get.toNamed(
                        RouteNames.rtcRoute,
                        parameters: {"isDial": "true"},
                      );
                    },
                    child: const Text('语音通话'),
                  ),
                ],
                cancelButton: CupertinoActionSheetAction(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text('取消'),
                ),
              ),
            );
          }
        },
        {
          "icon": CupertinoIcons.location_solid,
          "name": "位置",
          "ontap": () {
            Get.toNamed(RouteNames.mapRoute);
          }
        },
        {"icon": CupertinoIcons.mic, "name": "语音输入"},
        {"icon": CupertinoIcons.cube_fill, "name": "收藏"},
        {"icon": CupertinoIcons.person, "name": "个人名片"},
        {"icon": CupertinoIcons.folder, "name": "文件"},
        {"icon": CupertinoIcons.music_note_2, "name": "音乐"},
      ];

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  ///消息订阅主题
  String topic = 'text';
  late MQTTManager manager;
  MQTTAppState currentAppState = Provider.of<MQTTAppState>(Get.context!);
  _connectMQTT() {
    manager = MQTTManager(
      server: "10.100.23.159",
      topic: topic,
      identifier: '123',
      currentState: currentAppState,
      onMessage: (topic, message) {
        final textMessage = types.TextMessage(
          author: _user2,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          text: message,
        );
        _addMessage(textMessage);
        update(["chat"]);
      },
    );
    manager.initializeMQTTClient();
    manager.connect('user', '123456');
  }

  late RTMClient rtmClient;

  _initRTM() async {
    rtmClient = RTMClient();
    rtmClient.onMessage = (message, peerId) {
      final textMessage = types.TextMessage(
        author: _user2,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: message.text,
      );
      if (json.decode(message.text)["type"] == 'video') {
        Get.toNamed(
          RouteNames.rtcRoute,
          parameters: {"isDial": "false"},
        );
      } else {
        _addMessage(textMessage);
        update(["chat"]);
      }
    };

    ///消息发送失败执行
    rtmClient.onMessageError = (message, peerId) {};

    await rtmClient.init('177dbcefe8c841809a986d42dce3c01b');

    // 登录
    await rtmClient.login(
        '007eJxTYMi4ovdkgvv6pp1Bd86WF2x8e+bERt1TXOcmzfzOtssg70+pAoOhuXlKUnJqWqpFsoWJoYWBZaKlhVmKiVFKcqpxsoFh0gEbjfSGQEYGzrQCFkYGJgZGIATxGRmMAJX5IEc=',
        '2');
    // // 加入频道
    // final channel = await rtmClient.joinChannel('频道名');

    // // 发送频道消息
    // await channel?.sendMessage(AgoraRtmMessage.fromText('大家好!'));
  }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  @override
  void onClose() {
    manager.unsubscribe(topic);
    manager.disconnect();
    super.onClose();
  }
}
