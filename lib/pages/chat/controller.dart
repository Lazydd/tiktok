part of chat;

class ChatController extends GetxController {
  ChatController();

  final TextEditingController _messageTextController =
      TextEditingController(text: '啊啊啊aa');

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
          '啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊',
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
      id: 'a13d1sfa31df32s1d3f',
      text: message.text,
      status: types.Status.delivered,
    );
    _addMessage(textMessage);
  }

  bool _emojiShowing = true;

  void _changeEmojiShowing() {
    _emojiShowing = _emojiShowing;
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
