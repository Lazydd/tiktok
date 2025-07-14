import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tiktok/common/index.dart';

class CarouselWidget extends StatelessWidget {
  const CarouselWidget({
    super.key,
    this.onPageChanged,
    this.onTap,
    required this.items,
    this.currentIndex,
    this.height,
    this.indicatorColor,
    this.indicatorCircle,
    this.indicatorAlignment,
    this.indicatorLeft,
    this.indicatorRight,
    this.indicatorBottom,
  });

  /// 切换页码
  final Function(int, CarouselPageChangedReason)? onPageChanged;

  /// 点击
  final Function(int)? onTap;

  /// 数据列表
  final List items;

  /// 当前选中
  final int? currentIndex;

  /// 高度
  final double? height;

  /// 指示器 颜色
  final Color? indicatorColor;

  /// 指示器 是否圆形
  final bool? indicatorCircle;

  /// 指示器 对齐方式
  final MainAxisAlignment? indicatorAlignment;

  /// 指示器 位置
  final double? indicatorLeft, indicatorRight, indicatorBottom;

  Widget _buildView() {
    List<Widget> ws = [
      // 滚动视图
      CarouselSlider(
        options: CarouselOptions(
          scrollDirection: Axis.vertical,
          initialPage: currentIndex ?? 0,
          height: height,
          viewportFraction: 1,
          enlargeCenterPage: false,
          enableInfiniteScroll: false,
          onPageChanged: onPageChanged,
        ),
        items: [
          for (var i = 0; i < items.length; i++)
            Center(
              child: Image.asset(
                items[i].value,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
        ],
      ),
    ];

    return ws.toStack();
  }

  @override
  Widget build(BuildContext context) {
    return _buildView();
  }
}
