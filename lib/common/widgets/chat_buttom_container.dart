import 'dart:math';
import 'dart:ui' as ui;

import 'package:chat_bottom_container/chat_bottom_container.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:tiktok/common/index.dart';
import 'package:tiktok/common/widgets/data.dart';
import 'package:tiktok/common/widgets/recorder.dart';
import 'package:tiktok/common/widgets/sounds_message/sounds_button.dart';
import 'wave.dart';

part 'recording_status_mask.dart';
part 'canvas.dart';

enum PanelType { none, keyboard, emoji, tool }

class ChatButtomContainer extends StatefulWidget {
  const ChatButtomContainer(
    this.children, {
    super.key,
    this.toolPanelBuild,
    this.onSubmitted,
    this.safeAreaBottom,
    this.showAppBar = true,
    this.changeKeyboardPanelHeight,
    this.scrollController,
    this.onSendSounds,
    this.onControllerCreated,
  });

  final Widget children;

  final Widget? toolPanelBuild;

  final double? safeAreaBottom;

  final bool showAppBar;

  final void Function(String text)? onSubmitted;

  final ChatKeyboardChangeKeyboardPanelHeight? changeKeyboardPanelHeight;

  final AutoScrollController? scrollController;

  final void Function(SendContentType, String)? onSendSounds;

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
    _messageTextController.dispose();
    super.dispose();
  }

  @override
  void didPushNext() {
    super.didPushNext();
    hidePanel();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Context(context).theme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: _buildList()),
        _buildInputView(theme),
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
            return widget.toolPanelBuild != null
                ? widget.toolPanelBuild!
                : _buildToolPanel();
          default:
            return const SizedBox.shrink();
        }
      },
      onPanelTypeChange: (panelType, data) {
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
    return const SizedBox();
  }

  final TextEditingController _messageTextController = TextEditingController();

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
      onEmojiSelected: (Category? category, Emoji emoji) {
        _messageTextController.text += emoji.emoji;
      },
      onBackspacePressed: () {
        _messageTextController.text = _messageTextController.text.characters
            .skipLast(1)
            .toString();
      },
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
          emojiSizeMax:
              28 *
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

  RxBool talk = false.obs;

  void talkChange() {
    talk.value = !talk.value;
    if (talk.value) {
      _messageTextController.text = '按住 说话';
    } else {
      _messageTextController.clear();
    }
  }

  final _padding = ValueNotifier(EdgeInsets.zero);

  Widget _buildInputView(AppTheme theme) {
    return Theme(
      data: Theme.of(Get.context!).copyWith(
        iconTheme: IconThemeData(color: theme.iconColor, size: 30.sp),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15.w),
            color: theme.themeColor,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: talkChange,
                  child: Obx(
                    () => talk.value
                        ? const Icon(Icons.keyboard)
                        : const Icon(Icons.volume_up),
                  ),
                ),
                Expanded(
                  child: Listener(
                    onPointerUp: (event) {
                      if (talk.value) return;
                      inputChange();
                    },
                    child: Obx(
                      () => SoundsMessageButton(
                        TextField(
                          focusNode: inputFocusNode,
                          readOnly: readOnly,
                          showCursor: true,
                          enabled: !talk.value,
                          textAlign: talk.value
                              ? TextAlign.center
                              : TextAlign.start,
                          controller: _messageTextController,
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
                            fontWeight: talk.value
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: Colors.white,
                          ),
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.send,
                          maxLines: 9,
                          minLines: 1,
                          cursorColor: const Color(0xFF07C160),
                          onSubmitted: (String text) {
                            if (widget.onSubmitted == null) {
                              return;
                            }
                            try {
                              if (text.isNotEmpty) {
                                widget.onSubmitted!(text);
                              } else {
                                inputFocusNode.requestFocus();
                                return;
                              }
                            } on PlatformException catch (e) {
                              Loading.error(e.message);
                              return;
                            }
                            _messageTextController.clear();
                            inputFocusNode.requestFocus();
                          },
                          onChanged: (value) {},
                        ).marginSymmetric(horizontal: 15.w),
                        onChanged: (status) {
                          debugPrint(status.toString());
                          // 120 是遮罩层的视图高度
                          _padding.value = EdgeInsets.symmetric(
                            vertical: status == SoundsMessageStatus.none
                                ? 0
                                : (120 + 60 - (30 + 44) / 2) / 2 + 15,
                          );
                          widget.scrollController?.animateTo(
                            0,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeOut,
                          );
                        },
                        onSendSounds: widget.onSendSounds,
                      ),
                    ),
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
                ),
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

  bool updateInputView({required bool isReadOnly}) {
    if (readOnly != isReadOnly) {
      readOnly = isReadOnly;
      // You can just refresh the input view.
      setState(() {});
      return true;
    }
    return false;
  }
}
