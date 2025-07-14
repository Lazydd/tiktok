import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';
import 'package:tiktok/common/index.dart';
import 'package:photo_view/photo_view_gallery.dart';

typedef PageChanged = void Function(int index);

class PhotoPreview extends StatefulWidget {
  /// 图片列表
  final List galleryItems;

  /// 默认第几张图片
  final int defaultImageIndex;

  /// 切换图片回调
  final PageChanged? pageChanged;

  /// 图片查看方向
  final Axis direction;

  /// 背景设计
  final BoxDecoration? decoration;

  ///指示器
  final bool slider;

  /// 关闭photo_view
  final Function()? closePhotoView;

  const PhotoPreview({
    super.key,
    required this.galleryItems,
    this.defaultImageIndex = 0,
    this.pageChanged,
    this.direction = Axis.horizontal,
    this.decoration,
    this.slider = true,
    this.closePhotoView,
  });

  @override
  State<PhotoPreview> createState() => _PhotoPreviewState();
}

class _PhotoPreviewState extends State<PhotoPreview> {
  late int selectedIndex;
  late bool _isShowNavBar = true;
  @override
  void initState() {
    super.initState();
    selectedIndex = widget.defaultImageIndex + 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _isShowNavBar
          ? AppBar(
              backgroundColor: Colors.black.withValues(alpha: 0.6),
              elevation: 0,
              centerTitle: true,
              title: Text(
                "$selectedIndex / ${widget.galleryItems.length}",
                style: const TextStyle(color: Colors.white),
              ),
              leading: Icon(
                Icons.close,
                color: Colors.white,
                size: 24.sp,
              ).onTap(() => widget.closePhotoView!()).paddingLeft(20.w),
              actions: [
                Icon(Icons.download, color: Colors.white, size: 24.sp)
                    .onTap(() {
                      // file 与 network 的图片下载方式不一样
                      if (UtilsFunc.isNetImage(
                        widget.galleryItems[selectedIndex - 1],
                      )) {
                        Access.saveNetWorkImage(
                          context,
                          widget.galleryItems[selectedIndex - 1],
                        );
                      } else {
                        File file = widget.galleryItems[selectedIndex - 1];
                        Access.saveAssetsImg(context, file.path);
                      }
                    })
                    .paddingRight(20.w),
              ],
            )
          : null,
      extendBodyBehindAppBar: true,
      body: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            child: PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: (BuildContext context, int index) {
                // file 与 network 的图片展示方式不同
                return UtilsFunc.isNetImage(widget.galleryItems[index])
                    ? PhotoViewGalleryPageOptions(
                        imageProvider: NetworkImage(
                          UtilsFunc.imgUrlSplice(widget.galleryItems[index]),
                        ),
                        heroAttributes: PhotoViewHeroAttributes(
                          tag: widget.galleryItems[index],
                        ),
                      )
                    : PhotoViewGalleryPageOptions(
                        imageProvider: FileImage(widget.galleryItems[index]),
                        heroAttributes: PhotoViewHeroAttributes(
                          tag: widget.galleryItems[index],
                        ),
                      );
              },
              scrollDirection: widget.direction,
              itemCount: widget.galleryItems.length,
              loadingBuilder: (context, event) => const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
              backgroundDecoration:
                  widget.decoration ??
                  const BoxDecoration(color: Color.fromRGBO(0, 0, 0, 1)),
              pageController: PageController(
                initialPage: widget.defaultImageIndex,
              ),
              onPageChanged: (index) => setState(() {
                selectedIndex = index + 1;
                if (widget.pageChanged != null) {
                  widget.pageChanged!(index);
                }
              }),
            ),
          ).onTap(() {
            setState(() {
              _isShowNavBar = !_isShowNavBar;
            });
          }),
          // 指示器
          widget.slider
              ? Positioned(
                  bottom: 20,
                  child: SliderIndicatorWidget(
                    color: Colors.white,
                    currentIndex: selectedIndex - 1,
                    length: widget.galleryItems.length,
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
