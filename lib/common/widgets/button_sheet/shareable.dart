import 'package:flutter/material.dart';
import 'package:tiktok/common/theme/index.dart';
import 'package:tiktok/common/widgets/button_sheet/base_bottom_sheet.dart';

class Shareable extends BaseBottomSheet {
  Shareable({
    required super.context,
    super.title,
    super.radius,
    super.backgroundColor,
    super.isDismissible,
  }) : super(widget: _ShareableWidget());
}

typedef Shared = ({String label, Icon icon});

class _ShareableWidget<T> extends BottomSheetWidget<Shareable> {
  /// 自定义图标
  static const icons = <Shared>[
    (
      label: "转发给朋友",
      icon: Icon(
        Icons.forward,
        size: 18,
      )
    ),
    (label: "分享到朋友圈", icon: Icon(Icons.add_box, size: 18)),
    (label: "收藏", icon: Icon(Icons.collections, size: 18)),
    (label: "转发给朋友", icon: Icon(Icons.forward, size: 18)),
    (label: "转发给朋友", icon: Icon(Icons.forward, size: 18)),
    (label: "转发给朋友", icon: Icon(Icons.forward, size: 18)),
    (label: "转发给朋友", icon: Icon(Icons.forward, size: 18)),
  ];

  /// 自定义图标
  static const icons2 = <Shared>[
    (label: "点赞", icon: Icon(Icons.favorite, size: 18)),
    (label: "关注", icon: Icon(Icons.star, size: 18)),
    (label: "转发", icon: Icon(Icons.forward, size: 18)),
  ];

  /// 重写头部分享提示
  @override
  Widget header(BuildContext context) {
    return Padding(
      padding: parent.padding,
      child: Row(
        children: <Widget>[
          const SizedBox(
            width: 32,
            height: 32,
            child: CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage("assets/avatar.png"),
            ),
          ),
          const SizedBox(width: 5),
          Flexible(
            fit: FlexFit.loose,
            child: Text(
              parent.title!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              strutStyle: AppTheme.structStyle,
              style: const TextStyle(fontSize: 14, color: Colors.black),
            ),
          ),
          const Icon(Icons.arrow_right, size: 14),
        ],
      ),
    );
  }

  /// 实现分享列表的构建
  @override
  Widget body(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height / 2,
      ),
      padding: EdgeInsets.all(parent.spacing),
      decoration: BoxDecoration(border: Border(top: border)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: AppTheme.physics,
              child: Row(children: buildIcons(icons)),
            ),
          ),
          SizedBox(height: parent.spacing),
          SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: AppTheme.physics,
              child: Row(children: buildIcons(icons2)),
            ),
          )
        ],
      ),
    );
  }

  /// 重写底部内容
  @override
  Widget footer(BuildContext context) {
    return GestureDetector(
      onTap: parent.confirm,
      child: Container(
        padding: EdgeInsets.all(parent.spacing),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.black12, width: 0.2)),
        ),
        child: const DefaultTextStyle(
          style: TextStyle(fontSize: 16, color: Colors.black),
          child: Text("取消"),
        ),
      ),
    );
  }

  List<Widget> buildIcons(List<Shared> items) {
    return List.generate(items.length * 2 - 1, (index) {
      if ((index + 1) % 2 == 0) {
        return const SizedBox(width: 10);
      }
      final shared = items[(index ~/ 2)];
      return GestureDetector(
        onTap: () => {
          print('1111')
        },
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: shared.icon,
          ),
          const SizedBox(height: 5),
          Text(shared.label, style: const TextStyle(fontSize: 10)),
        ]),
      );
    });
  }
}
