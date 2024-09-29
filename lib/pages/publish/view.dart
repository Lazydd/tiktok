part of publish;

class PublishPage extends GetView<PublishController> {
  const PublishPage({super.key});

  // 主视图
  Widget _buildView() {
    return CameraAwesomeBuilder.awesome(
      saveConfig: SaveConfig.photoAndVideo(
        initialCaptureMode: CaptureMode.video,
        videoPathBuilder: (sensors) async {
          final Directory extDir = await getTemporaryDirectory();
          final testDir = await Directory('${extDir.path}/camerawesome')
              .create(recursive: true);
          if (sensors.length == 1) {
            final String filePath =
                '${testDir.path}/${DateTime.now().millisecondsSinceEpoch}.mp4';
            return SingleCaptureRequest(filePath, sensors.first);
          } else {
            return MultipleCaptureRequest(
              {
                for (final sensor in sensors)
                  sensor:
                      '${testDir.path}/${sensor.position == SensorPosition.front ? 'front_' : "back_"}${DateTime.now().millisecondsSinceEpoch}.mp4',
              },
            );
          }
        },
        videoOptions: VideoOptions(
          enableAudio: true,
          ios: CupertinoVideoOptions(fps: 10),
          android: AndroidVideoOptions(
            bitrate: 6000000,
            fallbackStrategy: QualityFallbackStrategy.lower,
          ),
        ),
      ),
      onMediaTap: (mediaCapture) {
        // OpenFile.open(mediaCapture.filePath);
        // print('Tap on ${mediaCapture.filePath}');
        // Get.back();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PublishController>(
      init: PublishController(),
      id: "publish",
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text("publish")),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}
