part of rtc;

class RtcPage extends GetView<RtcController> {
  const RtcPage({super.key});

  // 主视图
  Widget _buildView(context) {
    return Stack(
      children: [
        Center(
          child: _remoteVideo(),
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
              Offstage(
                offstage: true,
                child: RawMaterialButton(
                  onPressed: () {
                    Get.back();
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
              ),
            ],
          ),
        ),

        ///右上角本地预览
        Align(
          alignment: Alignment.topLeft,
          child: SizedBox(
            width: 100,
            height: 150,
            child: Center(
              child: controller._localUserJoined
                  ? AgoraVideoView(
                      controller: VideoViewController(
                        rtcEngine: controller._engine,
                        canvas: const VideoCanvas(uid: 0),
                      ),
                    )
                  : const CircularProgressIndicator(),
            ),
          ),
        ),
      ],
    );
  }

  ///主视图
  Widget _remoteVideo() {
    if (controller._remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: controller._engine,
          canvas: VideoCanvas(uid: controller._remoteUid),
          connection: const RtcConnection(channelId: RtcController.channel),
        ),
      );
    } else {
      return const Center(
        child: Text(
          '等待远程用户加入...',
          textAlign: TextAlign.center,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RtcController>(
      init: RtcController(),
      id: "rtc",
      builder: (_) {
        return Scaffold(
          body: _buildView(context),
        );
      },
    );
  }
}
