part of 'index.dart';

class InteractivePage extends GetView<InteractiveController> {
  const InteractivePage({super.key});

  // 主视图
  Widget _buildView(BuildContext context) {
    final theme = Context(context).theme;
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 45.w,
              height: 45.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 2.w, color: Colors.white),
              ),
              child: ClipOval(
                child: ImageWidget(
                  'https://p3-pc.douyinpic.com/img/aweme-avatar/tos-cn-avt-0015_f14282e10099a4b436a9ca62c0902595~c5_168x168.jpeg?from=2956013662',
                  width: 50.w,
                  height: 50.w,
                ),
              ),
            ),
            Positioned(
              bottom: -5,
              child: Container(
                width: 18.w,
                height: 18.w,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(9.r),
                ),
                child: Icon(Icons.add, size: 18.sp, color: Colors.white),
              ).onTap(() {}),
            ),
          ],
        ),
        Column(
          children: [
            Image.asset(AssetsImages.likeIcon, width: 60.w, height: 60.w),
            Text(
              '124.7万',
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
            ),
          ],
        ),
        Column(
          children: [
            Image.asset(AssetsImages.commentIcon, width: 60.w, height: 60.w),
            Text(
              '2.2万',
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
            ),
          ],
        ).onTap(() {
          buttonSheet<void>(
            const CommentPage(),
            title: Text(
              '2.2万条评论',
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
            ),
            height: .6,
            bottomSheetColor: theme.drawerBackgroundColor,
          );
        }),
        Column(
          children: [
            Image.asset(AssetsImages.starIcon, width: 60.w, height: 60.w),
            Text(
              '2.2万',
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
            ),
          ],
        ),
        Column(
          children: [
            Image.asset(AssetsImages.shareIcon, width: 60.w, height: 60.w),
            Text(
              '17.3',
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
            ),
          ],
        ).onTap(() {
          Get.bottomSheet(
            backgroundColor: theme.drawerBackgroundColor,
            isScrollControlled: true,
            const SharePage(),
          );
        }),
        SizedBox(height: 20.h),
        RotatingWidget(
          child: ImageWidget(
            'https://p3-pc.douyinpic.com/img/aweme-avatar/tos-cn-avt-0015_f14282e10099a4b436a9ca62c0902595~c5_168x168.jpeg?from=2956013662',
            width: 40.w,
            height: 40.w,
          ).clipRRect(all: 20.r),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InteractiveController>(
      init: InteractiveController(),
      id: "interactive",
      builder: (_) {
        return _buildView(context);
      },
    );
  }
}
