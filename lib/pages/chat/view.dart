part of chat;

class ChatPage extends GetView<ChatController> {
  ChatPage({super.key});

  late ChatBottomPanelContainerController panelController;

  // 主视图
  Widget _buildView(context) {
    return ChatButtomContainer(
      Chat(
        messages: controller._messages,
        onSendPressed: controller._handleSendPressed,
        user: controller._user,
        onEndReached: controller._handleEndReached,
        isLastPage: controller._isLastPage,
        showUserAvatars: true,
        bubbleBuilder: _bubbleBuilder,
        // showUserNames: true,
        theme: DefaultChatTheme(
          primaryColor: const Color(0xff4874e6),
          backgroundColor: const Color(0xff151515),
          messageBorderRadius: 10.w,
          messageInsetsHorizontal: 10.w,
          messageInsetsVertical: 10.w,
          secondaryColor: const Color(0xff3b3b43),
        ),
        textMessageBuilder: _textMessageBuilder,
        avatarBuilder: _avatarBuilder,
        customBottomWidget: const SizedBox(),
      ),
      // Container(
      //   color: Colors.red,
      // ),
      safeAreaBottom: 0,
      showAppBar: false,
      changeKeyboardPanelHeight: (keyboardHeight) => keyboardHeight,
      onControllerCreated: (buttonController) {
        panelController = buttonController;
      },
    );
  }

  Widget _textMessageBuilder(
    types.TextMessage textMessage, {
    required int messageWidth,
    required bool showName,
  }) {
    return Text(
      textMessage.text,
      style: TextStyle(
        color: Colors.white,
        fontSize: Theme.of(Get.context!).textTheme.bodyMedium!.fontSize?.sp,
      ),
    );
  }

  Widget _avatarBuilder(types.User user) {
    return Padding(
      padding: EdgeInsets.only(right: 8.w),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(36.r),
        child: ImageWidget(
          user.imageUrl ?? '',
          width: 36.w,
          height: 36.w,
        ),
      ),
    );
  }

  Widget _bubbleBuilder(
    Widget child, {
    required types.Message message,
    required bool nextMessageInGroup,
  }) {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: message.author.id == controller._user.id
            ? const Color(0xff4874e6)
            : const Color(0xff3b3b43),
        borderRadius: BorderRadius.circular(10.w),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
      init: ChatController(),
      id: "chat",
      builder: (_) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(title: const Text("chat")),
          body: SafeArea(
            child: _buildView(context),
          ),
        );
      },
    );
  }
}
