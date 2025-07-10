part of chat;

class ChatPage extends GetView<ChatController> {
  final String peerId;
  final String name;

  const ChatPage({super.key, required this.peerId, required this.name});

  // 主视图
  Widget _buildView(context) {
    return ChatButtomContainer(
      Chat(
        scrollController: controller._scrollController,
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
        disableImageGallery: true,
        customBottomWidget: const SizedBox(),
      ),
      scrollController: controller._scrollController,
      toolPanelBuild: _toolPanelBuild(),
      safeAreaBottom: 0,
      showAppBar: false,
      changeKeyboardPanelHeight: (keyboardHeight) => keyboardHeight,
      onControllerCreated: (buttonController) {
        controller.panelController = buttonController;
      },
      onSubmitted: (String text) {
        controller._handleSendPressed(types.PartialText(text: text));
      },
      onSendSounds: (sendContentType, string) {},
    );
  }

  Widget _toolPanelBuild() {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.all(20.w),
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: 8,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 20.w,
          crossAxisSpacing: 20.w,
        ),
        itemBuilder: (context, index) {
          var item = controller.list[index];
          return GestureDetector(
            onTap: item["ontap"],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(10.w),
                  margin: EdgeInsets.only(bottom: 10.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.w),
                    color: Colors.grey,
                  ),
                  child: Icon(item["icon"], color: Colors.white, size: 24.sp),
                ),
                Text(
                  item['name'],
                  style: TextStyle(color: Colors.white, fontSize: 12.sp),
                )
              ],
            ),
          );
        },
      ),
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
          width: 34.w,
          height: 34.w,
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
      init: ChatController(peerId),
      id: "chat",
      builder: (_) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(title: Text(name)),
          body: SafeArea(
            child: _buildView(context),
          ),
        );
      },
    );
  }
}
