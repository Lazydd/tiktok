import 'package:chat_bottom_container/chat_bottom_container.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

enum PanelType {
  none,
  keyboard,
  emoji,
  tool,
}

class ChatButtomContainer extends StatefulWidget {
  const ChatButtomContainer(
    this.children, {
    super.key,
    this.safeAreaBottom,
    this.showAppBar = true,
    this.changeKeyboardPanelHeight,
    this.onControllerCreated,
  });

  final Widget children;
  final double? safeAreaBottom;

  final bool showAppBar;

  final ChatKeyboardChangeKeyboardPanelHeight? changeKeyboardPanelHeight;

  final Function(ChatBottomPanelContainerController)? onControllerCreated;

  @override
  State<ChatButtomContainer> createState() => _ChatButtomContainerState();
}

class _ChatButtomContainerState extends State<ChatButtomContainer>
    with RouteAware {
  Color panelBgColor = const Color(0xFFF5F5F5);

  final FocusNode inputFocusNode = FocusNode();

  final controller = ChatBottomPanelContainerController<PanelType>();

  PanelType currentPanelType = PanelType.none;

  bool readOnly = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();

    widget.onControllerCreated?.call(controller);
  }

  @override
  void dispose() {
    inputFocusNode.dispose();
    super.dispose();
  }

  @override
  void didPushNext() {
    super.didPushNext();
    hidePanel();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: _buildList()),
        _buildInputView(),
        _buildPanelContainer(),
      ],
    );
  }

  Widget _buildList() {
    Widget resultWidget = Listener(
      child: widget.children,
      onPointerDown: (event) {
        // Hide panel when touch ListView.
        hidePanel();
      },
    );
    return resultWidget;
  }

  Widget _buildPanelContainer() {
    return ChatBottomPanelContainer<PanelType>(
      controller: controller,
      inputFocusNode: inputFocusNode,
      otherPanelWidget: (type) {
        if (type == null) return const SizedBox.shrink();
        switch (type) {
          case PanelType.emoji:
            return _buildEmojiPickerPanel();
          case PanelType.tool:
            return _buildToolPanel();
          default:
            return const SizedBox.shrink();
        }
      },
      onPanelTypeChange: (panelType, data) {
        debugPrint('panelType: $panelType');
        switch (panelType) {
          case ChatBottomPanelType.none:
            currentPanelType = PanelType.none;
            break;
          case ChatBottomPanelType.keyboard:
            currentPanelType = PanelType.keyboard;
            break;
          case ChatBottomPanelType.other:
            if (data == null) return;
            switch (data) {
              case PanelType.emoji:
                currentPanelType = PanelType.emoji;
                break;
              case PanelType.tool:
                currentPanelType = PanelType.tool;
                break;
              default:
                currentPanelType = PanelType.none;
                break;
            }
            break;
        }
      },
      changeKeyboardPanelHeight: widget.changeKeyboardPanelHeight,
      panelBgColor: panelBgColor,
      safeAreaBottom: widget.safeAreaBottom,
    );
  }

  Widget _buildToolPanel() {
    return Container(
      height: 450,
      color: Colors.red[50],
      child: const Center(
        child: Text('Tool Panel'),
      ),
    );
  }

  Widget _buildEmojiPickerPanel() {
    // If the keyboard height has been recorded, priority is given to setting
    // the height to the keyboard height.
    double height = 256;
    final keyboardHeight = controller.keyboardHeight;
    if (keyboardHeight != 0) {
      if (widget.changeKeyboardPanelHeight != null) {
        height = widget.changeKeyboardPanelHeight!.call(keyboardHeight);
      } else {
        height = keyboardHeight;
      }
    }

    return EmojiPicker(
      config: Config(
        height: height,
        checkPlatformCompatibility: true,
        viewOrderConfig: const ViewOrderConfig(
          top: EmojiPickerItem.searchBar,
          middle: EmojiPickerItem.categoryBar,
          bottom: EmojiPickerItem.emojiView,
        ),
        emojiViewConfig: EmojiViewConfig(
          // Issue: https://github.com/flutter/flutter/issues/28894
          emojiSizeMax: 28 *
              (foundation.defaultTargetPlatform == TargetPlatform.iOS
                  ? 1.2
                  : 1.0),
          columns: 7,
          backgroundColor: Colors.white,
        ),
        skinToneConfig: const SkinToneConfig(
          indicatorColor: Colors.blue,
          dialogBackgroundColor: Colors.white,
        ),
        categoryViewConfig: const CategoryViewConfig(
          iconColor: Colors.grey,
          iconColorSelected: Colors.blue,
          backspaceColor: Colors.blue,
        ),
        bottomActionBarConfig: const BottomActionBarConfig(enabled: false),
      ),
    );
  }

  Widget _buildInputView() {
    return Theme(
      data: Theme.of(Get.context!).copyWith(
        iconTheme: IconThemeData(color: Colors.white, size: 30.sp),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(15.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Icon(Icons.volume_up),
                Expanded(
                  child: Listener(
                    onPointerUp: (event) {
                      inputChange();
                    },
                    child: TextField(
                      focusNode: inputFocusNode,
                      readOnly: readOnly,
                      showCursor: true,
                      // controller: controller._messageTextController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.r),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Colors.grey.shade600,
                        filled: true,
                        isDense: true,
                        hoverColor: Colors.transparent,
                        contentPadding: EdgeInsets.all(8.w),
                      ),
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.white,
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: 9,
                      minLines: 1,
                      cursorColor: const Color(0xFF07C160),
                      onChanged: (value) {},
                    ).marginSymmetric(horizontal: 15.w),
                  ),
                ),
                GestureDetector(
                  onTap: emojiChange,
                  child: const Icon(Icons.mood),
                ),
                SizedBox(width: 15.w),
                GestureDetector(
                  onTap: toolChange,
                  child: const Icon(Icons.add_circle),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void emojiChange() {
    updatePanelType(
      PanelType.emoji == currentPanelType
          ? PanelType.keyboard
          : PanelType.emoji,
    );
  }

  void toolChange() {
    updatePanelType(
      PanelType.tool == currentPanelType ? PanelType.keyboard : PanelType.tool,
    );
  }

  void inputChange() {
    if (readOnly) {
      updatePanelType(PanelType.keyboard);
    }
  }

  updatePanelType(PanelType type) async {
    final isSwitchToKeyboard = PanelType.keyboard == type;
    final isSwitchToEmojiPanel = PanelType.emoji == type;
    bool isUpdated = false;
    switch (type) {
      case PanelType.keyboard:
        updateInputView(isReadOnly: false);
        break;
      case PanelType.emoji:
        isUpdated = updateInputView(isReadOnly: true);
        break;
      default:
        break;
    }

    updatePanelTypeFunc() {
      controller.updatePanelType(
        isSwitchToKeyboard
            ? ChatBottomPanelType.keyboard
            : ChatBottomPanelType.other,
        data: type,
        forceHandleFocus: isSwitchToEmojiPanel
            ? ChatBottomHandleFocus.requestFocus
            : ChatBottomHandleFocus.none,
      );
    }

    if (isUpdated) {
      // Waiting for the input view to update.
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        updatePanelTypeFunc();
      });
    } else {
      updatePanelTypeFunc();
    }
  }

  hidePanel() {
    if (inputFocusNode.hasFocus) {
      inputFocusNode.unfocus();
    }
    updateInputView(isReadOnly: false);
    if (ChatBottomPanelType.none == controller.currentPanelType) return;
    controller.updatePanelType(ChatBottomPanelType.none);
  }

  bool updateInputView({
    required bool isReadOnly,
  }) {
    if (readOnly != isReadOnly) {
      readOnly = isReadOnly;
      // You can just refresh the input view.
      setState(() {});
      return true;
    }
    return false;
  }
}
