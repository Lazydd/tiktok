import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

/// 视频手势封装
/// 单击：暂停
/// 双击：点赞，双击后再次单击也是增加点赞爱心
class TikTokVideoGesture extends StatefulWidget {
  const TikTokVideoGesture({
    Key? key,
    required this.child,
    this.onAddFavorite,
    this.onSingleTap,
  }) : super(key: key);

  final Function? onAddFavorite;
  final Function? onSingleTap;
  final Widget child;

  @override
  TikTokVideoGestureState createState() => TikTokVideoGestureState();
}

class TikTokVideoGestureState extends State<TikTokVideoGesture> {
  final GlobalKey _key = GlobalKey();

  // 内部转换坐标点
  Offset _p(Offset p) {
    RenderBox getBox = _key.currentContext!.findRenderObject() as RenderBox;
    return getBox.globalToLocal(p);
  }

  List<Offset> icons = [];

  bool canAddFavorite = false;
  bool justAddFavorite = false;
  Timer? timer;

  @override
  Widget build(BuildContext context) {
    var iconStack = Stack(
      children: icons
          .map<Widget>(
            (p) => TikTokFavoriteAnimationIcon(
              position: p,
              onAnimationComplete: () {
                icons.remove(p);
              },
            ),
          )
          .toList(),
    );
    return GestureDetector(
      key: _key,
      onTapDown: (detail) {
        setState(() {
          if (canAddFavorite) {
            icons.add(_p(detail.globalPosition));
            widget.onAddFavorite?.call();
            justAddFavorite = true;
          } else {
            justAddFavorite = false;
          }
        });
      },
      onTapUp: (detail) {
        timer?.cancel();
        var delay = canAddFavorite ? 600 : 300;
        timer = Timer(Duration(milliseconds: delay), () {
          canAddFavorite = false;
          timer = null;
          if (!justAddFavorite) {
            widget.onSingleTap?.call();
          }
        });
        canAddFavorite = true;
      },
      onTapCancel: () {},
      child: Stack(
        children: <Widget>[
          widget.child,
          iconStack,
        ],
      ),
    );
  }
}

class TikTokFavoriteAnimationIcon extends StatefulWidget {
  final Offset? position;
  final double size;
  final Function? onAnimationComplete;

  const TikTokFavoriteAnimationIcon({
    Key? key,
    this.onAnimationComplete,
    this.position,
    this.size = 100,
  }) : super(key: key);

  @override
  TikTokFavoriteAnimationIconState createState() =>
      TikTokFavoriteAnimationIconState();
}

class TikTokFavoriteAnimationIconState
    extends State<TikTokFavoriteAnimationIcon> with TickerProviderStateMixin {
  AnimationController? _animationController;

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _animationController = AnimationController(
      lowerBound: 0,
      upperBound: 1,
      duration: const Duration(milliseconds: 1600),
      vsync: this,
    );

    _animationController!.addListener(() {
      setState(() {});
    });
    startAnimation();
    super.initState();
  }

  startAnimation() async {
    await _animationController!.forward();
    widget.onAnimationComplete?.call();
  }

  double rotate = pi / 10.0 * (2 * Random().nextDouble() - 1);

  double? get value => _animationController?.value;

  double appearDuration = 0.1;
  double dismissDuration = 0.8;

  double get opa {
    if (value! < appearDuration) {
      return 0.99 / appearDuration * value!;
    }
    if (value! < dismissDuration) {
      return 0.99;
    }
    var res = 0.99 - (value! - dismissDuration) / (1 - dismissDuration);
    return res < 0 ? 0 : res;
  }

  double get scale {
    if (value! < appearDuration) {
      return 1 + appearDuration - value!;
    }
    if (value! < dismissDuration) {
      return 1;
    }
    return (value! - dismissDuration) / (1 - dismissDuration) + 1;
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Icon(
      Icons.favorite,
      size: widget.size,
      color: Colors.redAccent,
    );
    content = ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (Rect bounds) => RadialGradient(
        center: Alignment.topLeft.add(const Alignment(0.66, 0.66)),
        colors: const [
          Color(0xffEF6F6F),
          Color(0xffF03E3E),
        ],
      ).createShader(bounds),
      child: content,
    );
    Widget body = Transform.rotate(
      angle: rotate,
      child: Opacity(
        opacity: opa,
        child: Transform.scale(
          alignment: Alignment.bottomCenter,
          scale: scale,
          child: content,
        ),
      ),
    );
    return widget.position == null
        ? Container()
        : Positioned(
            left: widget.position!.dx - widget.size / 2,
            top: widget.position!.dy - widget.size / 2,
            child: body,
          );
  }
}
