part of 'index.dart';

class SharePage extends GetView<ShareController> {
  const SharePage({super.key});

  // 主视图
  Widget _buildView(BuildContext context) {
    final theme = Context(context).theme;
    return SizedBox(
      height: 320.h,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '分享给朋友',
                style: TextStyle(color: theme.textColor, fontSize: 14.sp),
              ),
              Container(
                alignment: Alignment.center,
                width: 20.w,
                height: 20.w,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(58, 58, 70, 0.4),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 14.sp,
                ),
              ).onTap(Get.back)
            ],
          ).paddingSymmetric(horizontal: 20.w, vertical: 10.h),
          Expanded(
            child: ListView.builder(
              itemExtent: 80.w,
              itemCount: ShareController.topList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int i) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ShareController.topList[i]['type'] != null
                        ? Container(
                            width: 58.w,
                            height: 58.w,
                            alignment: Alignment.center,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              color:
                                  ShareController.topList[i]['type'] == 'wechat'
                                      ? const Color(0xff07C160)
                                      : theme.shareIconColor,
                              borderRadius: BorderRadius.circular(29.r),
                            ),
                            child: Icon(
                              ShareController.topList[i]['icon'],
                              color:
                                  ShareController.topList[i]['type'] == 'wechat'
                                      ? const Color(0xffffffff)
                                      : theme.shareFontColor,
                              size: 40.sp,
                            ),
                          )
                        : ImageWidget(
                            ShareController.topList[i]['icon'],
                            width: 58.w,
                            height: 58.w,
                          ).clipRRect(all: 29.r),
                    SizedBox(height: 8.h),
                    Text(
                      ShareController.topList[i]['name'],
                      style: TextStyle(
                        color: theme.shareFontColor,
                        fontSize: 10.sp,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemExtent: 80.w,
              itemCount: ShareController.bottomList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int i) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 58.w,
                      height: 58.w,
                      margin: EdgeInsets.only(bottom: 8.h),
                      alignment: Alignment.center,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: theme.shareIconColor,
                        borderRadius: BorderRadius.circular(29.r),
                      ),
                      child: Icon(
                        ShareController.bottomList[i]['icon'],
                        color: theme.shareFontColor,
                        size: 40.sp,
                      ),
                    ),
                    Text(
                      ShareController.bottomList[i]['name'],
                      style: TextStyle(
                        color: theme.shareFontColor,
                        fontSize: 10.sp,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShareController>(
      init: ShareController(),
      id: "share",
      builder: (_) {
        return SafeArea(
          child: _buildView(context),
        );
      },
    );
  }
}
