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
              // key: Key(p.toString()),
              position: p,
              onAnimationComplete: () {
                icons.remove(p);
              },
            ),
          )
          .toList(),
    );
    try {
      return GestureDetector(
        onTapDown: (detail) {
          var box = context.findRenderObject() as RenderBox;
          var pos = box.globalToLocal(detail.globalPosition);
          setState(() {
            if (canAddFavorite) {
              icons.add(pos);
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
    } catch (e) {
      return Container();
    }
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
      lowerBound: 0.75,
      upperBound: 1,
      duration: const Duration(milliseconds: 1500),
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

  double appearDuration = 0.8;
  double dismissDuration = 0.95;

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
    const k = 400;
    if (value! < appearDuration) {
      var temp1 = k * (value! - 0.775) * (value! - 0.8) + 1;
      return temp1;
    }
    if (value! < dismissDuration) {
      return 1;
    }
    const axis = 1.05;
    var k1 = axis - dismissDuration;
    return -(k1) / (value! - axis);
  }

  double get top {
    if (value! < dismissDuration) {
      return (sqrt(dismissDuration)) * 150 +
          (pow(dismissDuration, 3)) * 100 -
          50;
    }
    return (sqrt(value!)) * 150 + (value! * value! * value!) * 100 - 50;
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
        colors: [
          Colors.pink.shade200,
          const Color(0xffE91E63),
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
