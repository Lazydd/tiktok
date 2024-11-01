part of rtc;

class RtcController extends GetxController {
  RtcController();

  static const appId = "177dbcefe8c841809a986d42dce3c01b";
  static const token =
      "007eJxTYNgnFXRqcrVen73M+dfc7K/cdr7iaTr03t2sgVu9vTLNw1GBwdDcPCUpOTUt1SLZwsTQwsAy0dLCLMXEKCU51TjZwDDpiZNyekMgI0PkFWlGRgYIBPE5GQyNjCGIgQEAc1Id6g==";
  static const channel = "123123123";

  int? _remoteUid;
  bool _localUserJoined = false;
  late RtcEngine _engine;

  Future<void> initAgora() async {
    // retrieve permissions
    await [Permission.microphone, Permission.camera].request();

    //create the engine
    _engine = createAgoraRtcEngine();
    await _engine.initialize(const RtcEngineContext(
      appId: appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    _engine.registerEventHandler(
      RtcEngineEventHandler(
        // 加入频道成功
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("local user ${connection.localUid} joined");
          _localUserJoined = true;
          update(["rtc"]);
        },
        // 有用户加入
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("remote user $remoteUid joined");
          _remoteUid = remoteUid;
          update(["rtc"]);
        },
        // 有用户离线
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          debugPrint("remote user $remoteUid left channel");
          _remoteUid = null;
        },
        // 离开频道
        onLeaveChannel: (RtcConnection connection, RtcStats stats) {
          _localUserJoined = false;
          _remoteUid = null;
          update(["rtc"]);
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

    await _engine.joinChannel(
      token: token,
      channelId: channel,
      uid: 0,
      options: const ChannelMediaOptions(),
    );
  }

  Future<void> _dispose() async {
    await _engine.leaveChannel();
    await _engine.release();
  }

  void _inviteUser() {
    // _engine.inviteUserToChannel('user_id', 'channel_name', null, 0);
  }

  _initData() {
    initAgora();
    update(["rtc"]);
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
