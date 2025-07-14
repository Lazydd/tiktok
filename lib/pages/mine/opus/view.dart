part of 'index.dart';

class OpusPage extends StatefulWidget {
  final int type;
  const OpusPage(this.type, {super.key});

  @override
  State<OpusPage> createState() => _OpusPageState();
}

class _OpusPageState extends State<OpusPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _MainViewGetX(widget.type);
  }

  @override
  bool get wantKeepAlive => true;
}

class _MainViewGetX extends GetView<OpusController> {
  final int type;
  const _MainViewGetX(this.type);

  // 主视图
  Widget _buildView(OpusController controller) {
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
      child: GridView.builder(
        itemCount: controller.list.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 1,
          crossAxisSpacing: 1,
          childAspectRatio: 0.7,
        ),
        // addAutomaticKeepAlives: false,
        padding: EdgeInsets.all(0.5.r),
        itemBuilder: (BuildContext context, index) {
          Map item = controller.list[index];
          return Stack(
            alignment: Alignment.bottomLeft,
            fit: StackFit.expand,
            children: [
              Hero(
                tag:
                    '${Constants.imagesUrl}/images/${item['video']['cover']['url_list'][0]}',
                child: ImageWidget(
                  '${Constants.imagesUrl}/images/${item['video']['cover']['url_list'][0]}',
                ),
              ),
              if (type == 1 && index <= 2)
                Positioned(
                  top: 7.h,
                  left: 7.w,
                  child: const TagWidget(
                    '置顶',
                    color: Colors.black,
                    backgroundColor: Colors.amber,
                  ),
                ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Icon(Icons.favorite, color: Colors.white, size: 24.sp),
                  Text(
                    Unit.formatNumber(item['statistics']['digg_count']),
                    style: TextStyle(color: Colors.white, fontSize: 16.sp),
                  ),
                ],
              ).marginOnly(left: 5.w, bottom: 2.h),
            ],
          ).onTap(() {
            Navigator.push(
              Get.context!,
              MaterialPageRoute(
                builder: (context) => PhotoPreview(
                  galleryItems: controller.list2,
                  defaultImageIndex: index,
                  slider: false,
                  closePhotoView: () => Get.back(),
                ),
              ),
            );
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OpusController>(
      init: OpusController(type),
      id: "opus",
      tag: type.toString(),
      builder: (OpusController controller) {
        return _buildView(controller);
      },
    );
  }
}
