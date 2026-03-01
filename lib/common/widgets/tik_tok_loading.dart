import 'package:flutter/material.dart';
import 'package:tiktok/common/values/images.dart';

class TikTokLoading extends StatefulWidget {
  final double? scale;
  const TikTokLoading({super.key, this.scale = 0.7});

  @override
  TikTokLoadingState createState() => TikTokLoadingState();
}

class TikTokLoadingState extends State<TikTokLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final int frameCount = 60; // 总帧数
  final double frameHeight = 48; // 每帧高度

  @override
  void initState() {
    super.initState();
    // 创建动画控制器（1秒循环）
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: widget.scale,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          // 关键修正：使用离散帧计算，不重置位置
          final frameIndex =
              (_controller.value * frameCount).floor() % frameCount;
          // 计算垂直偏移量（负值向上移动）
          final offsetY = -frameIndex * frameHeight;

          return SizedBox(
            width: frameHeight,
            height: frameHeight,
            child: ClipRect(
              // 使用ClipRect确保只显示当前帧
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  // 固定位置的雪碧图
                  // https://p-pc-weboff.byteimg.com/tos-cn-i-9r5gewecjs/a795fb49bcbcf8cb1c762a69d57aee48.png
                  Positioned(
                    top: offsetY,
                    child: Image.asset(
                      AssetsImages.loading,
                      width: frameHeight,
                      height: frameHeight * frameCount,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
