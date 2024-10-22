part of chat;

class ChatController extends GetxController {
  ChatController();
  _initData() {
    const other = types.User(
      id: 'otheruser',
      firstName: "テスト",
      lastName: "太郎",
      imageUrl:
          "https://pbs.twimg.com/profile_images/1335856760972689408/Zeyo7jdq_bigger.jpg",
    );
    final textMessage = types.TextMessage(
      author: other,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: 'a13d1sfa31df32s1d3324f',
      text:
          'helloworldhelloworldhelloworldhelloworldhelloworldhelloworldhelloworldhelloworldhelloworldhelloworldhelloworldhelloworldhelloworldhelloworldhelloworldhelloworldhelloworldhelloworldhelloworldhelloworldhelloworldhelloworldhelloworldhelloworldhelloworldhelloworldhelloworldhelloworldhelloworldhelloworldhelloworld',
    );
    _addMessage(textMessage);
    _handleEndReached();
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
  }

  List<Map<String, dynamic>> get list => [
        {
          "icon": Icons.image,
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
          "icon": Icons.photo_camera,
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
        {"icon": Icons.location_on, "name": "位置"},
        {"icon": Icons.mic, "name": "语音输入"},
        {"icon": Icons.search, "name": "收藏"},
        {"icon": Icons.person, "name": "个人名片"},
        {"icon": Icons.folder_open, "name": "文件"},
        {"icon": Icons.music_note, "name": "音乐"},
      ];

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
