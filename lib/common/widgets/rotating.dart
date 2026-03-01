import 'package:flutter/material.dart';

class RotatingWidget extends StatefulWidget {
  final Widget child;
  final Duration? duration; // 旋转一圈的时间
  final bool isPlaying; // 控制动画是否播放

  const RotatingWidget({
    super.key,
    required this.child,
    this.duration = const Duration(seconds: 5),
    this.isPlaying = true, // 默认自动播放
  });

  @override
  RotatingWidgetState createState() => RotatingWidgetState();
}

class RotatingWidgetState extends State<RotatingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    if (widget.isPlaying) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant RotatingWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPlaying != oldWidget.isPlaying) {
      if (widget.isPlaying) {
        _controller.repeat(); // 继续旋转
      } else {
        _controller.stop(); // 暂停旋转
      }
    }
    if (widget.duration != oldWidget.duration) {
      _controller.duration = widget.duration;
      if (widget.isPlaying) {
        _controller.repeat();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(turns: _controller, child: widget.child);
  }
}
