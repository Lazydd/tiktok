part of 'index.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const _ShopViewGetX();
  }
}

class _ShopViewGetX extends GetView<ShopController> {
  const _ShopViewGetX();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShopController>(
      init: ShopController(),
      id: "shop",
      builder: (_) {
        return SmartRefresher(
          controller: controller.refreshController,
          // 刷新控制器
          enablePullDown: true,
          // 启用加载
          enablePullUp: true,
          // 启用上拉加载
          onRefresh: controller.onRefresh,
          // 下拉刷新回调
          onLoading: controller.onLoading,
          child: MasonryGridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 6.sp,
            crossAxisSpacing: 6.sp,
            padding: EdgeInsets.all(6.sp),
            itemCount: controller.list.length,
            itemBuilder: (context, index) {
              return Container(
                height: (index % 5 + 1) * 100,
                // color: AppColors.randomColor,
                child:
                    Stack(
                      children: [
                        Hero(
                          tag: controller.list[index]['avatar'],
                          child: ImageWidget(controller.list[index]['avatar']),
                        ),
                        Text(
                          controller.list[index]['content'],
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ).onTap(() {
                      Navigator.push(
                        Get.context!,
                        MaterialPageRoute(
                          builder: (context) => PhotoPreview(
                            galleryItems: controller.list
                                .map((v) => v['avatar'])
                                .toList(),
                            defaultImageIndex: index,
                            slider: false,
                            closePhotoView: () => Get.back(),
                          ),
                        ),
                      );
                    }),
              );
            },
          ),
        );
      },
    );
  }
}
