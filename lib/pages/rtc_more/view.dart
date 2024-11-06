part of rtc_more;

class RtcMorePage extends GetView<RtcMoreController> {
  String isDial = 'false';
  RtcMorePage({super.key, required this.isDial});

  // 主视图
  Widget _buildView(context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        AgoraVideoView(
          controller: VideoViewController(
            rtcEngine: controller._engine,
            canvas: const VideoCanvas(uid: 100),
          ),
        ),
        Positioned(
          bottom: 200.h,
          left: 0,
          right: 0,
          child: GetBuilder<RtcMoreController>(
            id: "time",
            builder: (_) {
              return controller.isDial == 'true'
                  ? Center(
                      child: Text(
                        DateFunc.formatTimestampToClock(controller._seconds),
                        style: TextStyle(color: Colors.white, fontSize: 18.sp),
                      ),
                    )
                  : const SizedBox();
            },
          ),
        ),
        Positioned(
          bottom: 40.h,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // RawMaterialButton(
              //   onPressed: () {},
              //   shape: const CircleBorder(),
              //   elevation: 2.0,
              //   fillColor: Colors.blueAccent,
              //   padding: const EdgeInsets.all(12.0),
              //   child: const Icon(
              //     Icons.mic,
              //     color: Colors.white,
              //     size: 20.0,
              //   ),
              // ),
              RawMaterialButton(
                onPressed: () {
                  Get.back();
                },
                shape: const CircleBorder(),
                fillColor: Colors.redAccent,
                padding: EdgeInsets.all(20.w),
                child: const Icon(
                  CupertinoIcons.phone_down,
                  color: Colors.white,
                  size: 35.0,
                ),
              ),
              if (controller.isDial == 'false')
                RawMaterialButton(
                  onPressed: () {
                    controller._start();
                  },
                  shape: const CircleBorder(),
                  fillColor: Colors.greenAccent,
                  padding: EdgeInsets.all(20.w),
                  child: const Icon(
                    CupertinoIcons.phone,
                    color: Colors.white,
                    size: 35.0,
                  ),
                ),
            ],
          ),
        ),
        Align(alignment: Alignment.topLeft, child: _remoteVideo(controller)),
      ],
    );
  }

  ///主视图
  Widget _remoteVideo(RtcMoreController controller) {
    return FutureBuilder<bool?>(
        future: controller.initStatus,
        builder: (context, snap) {
          if (snap.data != true) {
            return Center(
              child: Text(
                controller.isDial == 'true' ? '正在等待对方接受邀请' : '邀请你进行视频聊天',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 18.sp),
              ),
            );
          }
          return GridView.builder(
            itemCount: controller._remoteUid.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 1,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (BuildContext context, index) {
              return AgoraVideoView(
                controller: VideoViewController.remote(
                  rtcEngine: controller._engine,
                  canvas: VideoCanvas(
                    uid: controller._remoteUid.elementAt(index),
                  ),
                  connection:
                      const RtcConnection(channelId: RtcMoreController.channel),
                ),
              );
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RtcMoreController>(
      init: RtcMoreController(isDial: isDial),
      id: "rtc_more",
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text("rtc_more")),
          body: SafeArea(
            child: _buildView(context),
          ),
        );
      },
    );
  }
}
