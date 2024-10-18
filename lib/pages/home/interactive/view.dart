part of interactive;

class InteractivePage extends GetView<InteractiveController> {
  const InteractivePage({super.key});

  // 主视图
  Widget _buildView(controller) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 45.w,
              height: 45.w,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                border: Border.all(width: 2.w, color: Colors.red),
                borderRadius: BorderRadius.circular(22.5.r),
              ),
              child: const ImageWidget(
                  'https://p3-pc.douyinpic.com/img/aweme-avatar/tos-cn-avt-0015_f14282e10099a4b436a9ca62c0902595~c5_168x168.jpeg?from=2956013662'),
            ),
            Positioned(
              bottom: -5,
              child: Container(
                width: 18.w,
                height: 18.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(9.r),
                ),
                child: Icon(
                  Icons.add,
                  size: 18.sp,
                  color: Colors.red,
                ),
              ).onTap(() {}),
            )
          ],
        ),
        SizedBox(height: 20.h),
        LikeButton(
          size: 40.sp,
          onTap: (bool isLiked) async {
            if (!isLiked) Vibration.vibrate();
            return !isLiked;
          },
          countPostion: CountPostion.bottom,
          likeBuilder: (bool isLiked) {
            return Icon(
              Icons.favorite,
              color: isLiked ? Colors.pinkAccent : Colors.white,
              size: 40.sp,
            );
          },
          likeCount: 1247000,
          likeCountAnimationType: LikeCountAnimationType.none,
          countBuilder: (int? count, bool isLiked, String text) {
            final color = isLiked ? Colors.pinkAccent : Colors.white;
            Widget result = Text(
              '124.7万',
              style: TextStyle(color: color, fontSize: 14.sp),
            );
            return result;
          },
        ),
        SizedBox(height: 20.h),
        Column(
          children: [
            Icon(
              Icons.chat,
              color: Colors.white,
              size: 40.sp,
            ),
            Text(
              '2.2万',
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
            )
          ],
        ).onTap(() {
          buttonSheet<void>(
            const CommentPage(),
            title: Text(
              '2.2万条评论',
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
            ),
            height: .6,
          );
        }),
        SizedBox(height: 20.h),
        LikeButton(
          size: 40.sp,
          circleColor: const CircleColor(
            start: Color(0xffcebc20),
            end: Color(0xffafac0c),
          ),
          bubblesColor: const BubblesColor(
            dotPrimaryColor: Color(0xff33b5e5),
            dotSecondaryColor: Color(0xff0099cc),
          ),
          onTap: (bool isLiked) async {
            if (!isLiked) Vibration.vibrate();
            return !isLiked;
          },
          countPostion: CountPostion.bottom,
          likeBuilder: (bool isLiked) {
            return Icon(
              Icons.star,
              color: isLiked ? Colors.yellow : Colors.white,
              size: 40.sp,
            );
          },
          likeCount: 1247000,
          likeCountAnimationType: LikeCountAnimationType.none,
          countBuilder: (int? count, bool isLiked, String text) {
            final color = isLiked ? Colors.yellow : Colors.white;
            Widget result = Text(
              '2.2万',
              style: TextStyle(color: color, fontSize: 14.sp),
            );
            return result;
          },
        ),
        SizedBox(height: 20.h),
        Column(
          children: [
            Icon(
              Icons.ios_share,
              color: Colors.white,
              size: 40.sp,
            ),
            Text(
              '17.3',
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
            )
          ],
        ).onTap(() {
          Get.bottomSheet(
            backgroundColor: Colors.black,
            isScrollControlled: true,
            const SharePage(),
          );
        }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InteractiveController>(
      init: InteractiveController(),
      id: "interactive",
      builder: (_) {
        return _buildView(_);
      },
    );
  }
}
