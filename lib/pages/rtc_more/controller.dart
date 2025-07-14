part of 'index.dart';

class RtcMoreController extends GetxController {
  String isDial = 'false';
  int _seconds = 0;
  Timer? _timer;
  bool _isRunning = false;

  RtcMoreController({required this.isDial});

  static const appId = "177dbcefe8c841809a986d42dce3c01b";
  static const token =
      "007eJxTYJiyql8vuEgqu3Jhxedt1awWk9Kiyv+n/5x6g8GQYd4ZBwEFBkNz85Sk5NS0VItkCxNDCwPLREsLsxQTo5TkVONkA8OkQB7t9IZARgaGl2UMjFAI4rMxGBoZAxEDAwAyVB1J";
  static const channel = "123123";

  late final Future<bool?> initStatus;

  final Set<int> _remoteUid = {};
  bool _localUserJoined = false;
  late RtcEngine _engine;

  Future<bool> initAgora() async {
    // retrieve permissions
    await [Permission.microphone, Permission.camera].request();

    //create the engine
    _engine = createAgoraRtcEngine();
    await _engine.initialize(const RtcEngineContext(
      appId: appId,
      //直播用channelProfileLiveBroadcasting
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    _engine.registerEventHandler(
      RtcEngineEventHandler(
        // 加入频道成功
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("加入频道成功：$channel");
          _localUserJoined = true;
          update(["rtc_more"]);
        },
        // 有用户加入
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("用户： $remoteUid 加入");
          _remoteUid.add(remoteUid);
          startTimer();
          update(["rtc_more"]);
        },
        // 有用户离线
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          debugPrint("用户： $remoteUid 离线");
          _remoteUid.removeWhere((v) => v == remoteUid);
        },
        // 离开频道
        onLeaveChannel: (RtcConnection connection, RtcStats stats) {
          _localUserJoined = false;
          _remoteUid.clear();
          _dispose();
          update(["rtc_more"]);
        },
        // token在30秒内过期触发
        onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
          debugPrint(
              '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
        },
      ),
    );

    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _engine.enableVideo();
    await _engine.setVideoEncoderConfiguration(
      const VideoEncoderConfiguration(
        dimensions: VideoDimensions(width: 640, height: 360),
        frameRate: 15,
      ),
    );
    await _engine.startPreview();
    if (isDial == 'true') {
      await _start();
    }
    return true;
  }

  Future<void> _dispose() async {
    _timer?.cancel();
    await _engine.leaveChannel();
    await _engine.release();
  }

  Future<bool> _start() async {
    await _engine.joinChannel(
      token: token,
      channelId: channel,
      uid: 100,
      options: const ChannelMediaOptions(
        channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
      ),
    );
    isDial = 'true';
    update(["rtc_more"]);
    return true;
  }

  _initData() {
    initStatus = initAgora();
    update(["rtc_more"]);
  }

  void startTimer() {
    if (!_isRunning) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _seconds++;
        update(['time']);
      });
      _isRunning = true;
    }
  }

  void onTap() {}

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  @override
  void onClose() {
    _dispose();
    super.onClose();
  }
}
