import 'dart:async';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tiktok/common/index.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;
  final Widget? pauseIcon;

  const VideoPlayerWidget({required this.videoUrl, super.key, this.pauseIcon});

  @override
  State<VideoPlayerWidget> createState() => VideoPlayerWidgetState();
}

class VideoPlayerWidgetState extends State<VideoPlayerWidget>
    with AutomaticKeepAliveClientMixin {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    initializePlayer();
    timer = Timer(Duration.zero, () {});
  }

  late bool isInitialized = false;
  double sliderValue = 0.0;

  Future<void> initializePlayer() async {
    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoUrl),
    );
    _videoPlayerController.addListener(() {
      setState(() {
        sliderValue =
            _videoPlayerController.value.position.inSeconds.toDouble();
      });
    });
    await _videoPlayerController.initialize();
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoInitialize: true, //自动初始化
      autoPlay: true,
      looping: true,
      showControlsOnInitialize: false, //初始化时加载控件如暂停全屏icon
      aspectRatio: _videoPlayerController.value.aspectRatio,
      // allowMuting: false, // 允许静音
      // allowFullScreen: true, // 允许全屏
      showControls: false, // 显示控件
      errorBuilder: (context, errorMessage) {
        return const Center(
          child: Text("初始化视频失败", style: TextStyle(color: Colors.white)),
        );
      },
    );
    isInitialized = _videoPlayerController.value.isInitialized;
    if (isInitialized) {
      _videoPlayerController.play();
    }
    setState(() {});
  }

  RxBool sliderBar = false.obs;
  RxBool playing = true.obs;

  void onTap() {
    if (playing.value) {
      _videoPlayerController.pause();
    } else {
      _videoPlayerController.play();
    }
    if (sliderBar.value) {
      timer.cancel();
      timer = Timer(const Duration(seconds: 2), () {
        sliderBar.value = false;
      });
    } else {
      sliderBar.value = true;
    }
    playing.value = !playing.value;
  }

  Future<void> play() async {
    playing.value = true;
    await _videoPlayerController.play();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return isInitialized
        ? Stack(
            children: [
              AbsorbPointer(child: Chewie(controller: _chewieController)),
              TikTokVideoGesture(
                onSingleTap: onTap,
                onAddFavorite: () {},
                child: Container(
                  color: Colors.transparent,
                  height: double.infinity,
                  width: double.infinity,
                ),
              ),
              Positioned(
                bottom: -18.h,
                left: 0,
                width: MediaQuery.of(context).size.width,
                child: AnimatedOpacity(
                  duration: const Duration(seconds: 2),
                  curve: Curves.easeOutExpo,
                  opacity: sliderBar.value ? 1.0 : 0.0,
                  child: _slider(_videoPlayerController.value),
                ),
              ),
              if (!playing.value)
                Center(
                  child: widget.pauseIcon ??
                      IconWidget.svg(
                        AssetsSvgs.pauseSvg,
                        color: const Color.fromRGBO(255, 255, 255, .3),
                        size: 60.sp,
                      ),
                )
            ],
          )
        : const Center(child: CircularProgressIndicator(color: Colors.white));
  }

  late Timer timer;
  Widget _slider(playInfos) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackHeight: 4.h,
        thumbColor: Colors.white,
        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 4.h),
        activeTrackColor: Colors.white,
        inactiveTrackColor: const Color.fromARGB(132, 189, 189, 189),
        overlayColor: Colors.transparent,
        trackShape: CustomTrackShape(),
      ),
      child: Slider.adaptive(
        value: sliderValue,
        max: playInfos.duration.inSeconds.toDouble(),
        min: 0,
        onChanged: (value) {
          setState(() {
            timer.cancel();
            sliderBar.value = true;
            _videoPlayerController.seekTo(Duration(seconds: value.toInt()));
          });
        },
        onChangeEnd: (value) {
          if (!playing.value) play();
          timer = Timer(const Duration(seconds: 2), () {
            sliderBar.value = false;
          });
        },
      ),
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    timer.cancel();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => false;
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    Offset? secondaryOffset,
    bool isDiscrete = false,
    bool isEnabled = false,
    double additionalActiveTrackHeight = 0,
  }) {
    super.paint(
      context,
      offset,
      parentBox: parentBox,
      sliderTheme: sliderTheme,
      enableAnimation: enableAnimation,
      textDirection: textDirection,
      thumbCenter: thumbCenter,
      secondaryOffset: secondaryOffset,
      isDiscrete: isDiscrete,
      isEnabled: isEnabled,
      additionalActiveTrackHeight: 0,
    );
  }

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight ?? 2.h;
    // final double trackLeft = offset.dx;
    final double trackLeft = 10.w;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width - trackLeft * 2;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
