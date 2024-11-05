part of message;

class MessagePage extends GetView<MessageController> {
  const MessagePage({Key? key}) : super(key: key);

  // 主视图
  Widget _buildView(BuildContext context) {
    return ListView(children: [
      SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.18.h,
        child: ListView.builder(
          itemExtent: 90.w,
          itemCount: controller.topList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int i) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 70.w,
                  height: 70.w,
                  margin: EdgeInsets.only(bottom: 6.h),
                  alignment: Alignment.center,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: const Color(0xff333333),
                    borderRadius: BorderRadius.circular(35.r),
                  ),
                  child: ImageWidget(
                    controller.topList[i]['avatar'],
                  ),
                ),
                Text(
                  controller.topList[i]['name'],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ).width(70.w)
              ],
            );
          },
        ),
      ),
      _messageList(context)
    ]);
  }

  doNothing(BuildContext context, item) {
    controller.deleteMessage(item);
  }

  Widget _messageList(BuildContext context) {
    List<Widget> list = [];
    for (int i = 0; i < controller.messageList.length; i++) {
      var item = controller.messageList[i];
      list.add(
        Slidable(
          key: ValueKey(i),
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            extentRatio: 0.3,
            children: [
              CustomSlidableAction(
                onPressed: (BuildContext context) {
                  doNothing(context, item);
                },
                autoClose: true,
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.delete, size: 16.sp),
                    Text('删除', style: TextStyle(fontSize: 12.sp)),
                  ],
                ),
              ),
            ],
          ),
          child: Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageWidget(
                  item['avatar'],
                  width: 55.w,
                  height: 55.w,
                ).clipRRect(all: 27.5.r),
                SizedBox(width: 15.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['name'],
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
                      ),
                      Text.rich(TextSpan(
                        children: [
                          TextSpan(
                            text: item['content'],
                            style: TextStyle(
                              color: const Color(0xffbababb),
                              fontSize: 14.sp,
                            ),
                          ),
                          if (item['date'] != null) ...[
                            TextSpan(
                              text: '   ·  ',
                              style: TextStyle(
                                color: const Color(0xffbababb),
                                fontSize: 14.sp,
                              ),
                            ),
                            TextSpan(
                              text: item['date'],
                              style: TextStyle(
                                color: const Color(0xffbababb),
                                fontSize: 14.sp,
                              ),
                            ),
                          ]
                        ],
                      ))
                    ],
                  ),
                ),
                BuildConditional(item['noRead'])
              ],
            ).paddingSymmetric(horizontal: 20.w, vertical: 10.h),
          ),
        ).onTap(() {
          controller._messageDetail(item);
        }),
      );
    }
    return list.toColumn();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MessageController>(
      init: MessageController(),
      id: "message",
      builder: (_) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            leading: Builder(
              builder: (context) => IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: Icon(Icons.sort, size: 24.sp),
              ),
            ),
            title: IconButton(
              onPressed: () {},
              icon: Icon(Icons.photo_camera, size: 24.sp),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.search, size: 24.sp),
              )
            ],
          ),
          body: SafeArea(child: _buildView(context)),
        );
      },
    );
  }
}
