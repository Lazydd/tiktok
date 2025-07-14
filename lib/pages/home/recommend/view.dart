part of 'index.dart';

class RecommendPage extends StatefulWidget {
  const RecommendPage({super.key});

  @override
  State<RecommendPage> createState() => RecommendPageState();
}

class RecommendPageState extends State<RecommendPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const _RecommendViewGetX();
  }

  play() {
    Get.find<RecommendController>().currentVideoKey?.currentState?.play();
  }

  pause() {
    Get.find<RecommendController>().currentVideoKey?.currentState?.pause();
  }
}

class _RecommendViewGetX extends GetView<RecommendController> {
  const _RecommendViewGetX({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RecommendController>(
      init: RecommendController(),
      id: "recommend",
      builder: (_) {
        return PageView.builder(
          scrollDirection: Axis.vertical,
          controller: controller.pageController,
          itemCount: controller.list.length,
          onPageChanged: controller.pageChange,
          itemBuilder: (context, index) => GetBuilder<RecommendController>(
              id: "video",
              builder: (_) {
                if (!controller.videoKeys.containsKey(index)) {
                  controller.videoKeys[index] =
                      GlobalKey<VideoPlayerWidgetState>();
                }
                return Stack(
                  children: [
                    VideoPlayerWidget(
                      key: controller.videoKeys[index],
                      videoUrl: controller.list[index],
                      loading: const TikTokLoading(),
                    ),
                    Positioned(
                      right: 5.w,
                      bottom: 15.h,
                      child: const InteractivePage(),
                    ),
                    _desc(context)
                  ],
                );
              }),
        );
      },
    );
  }
}

Widget _desc(context) {
  return Positioned(
    left: 10.w,
    bottom: 10.h,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('@小橙子', style: TextStyle(color: Colors.white, fontSize: 18.sp)),
        SizedBox(height: 10.h),
        SizedBox(
          width: MediaQuery.of(context).size.width - 75.w,
          child: Text(
            '仿不来观音就仿个敦煌飞天吧~#有何不敢见观音 #敦煌壁画仿妆绝了',
            style: TextStyle(color: Colors.white, fontSize: 16.sp),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );
}
