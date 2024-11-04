import 'package:agora_rtm/agora_rtm.dart';
import 'package:flutter/cupertino.dart';

class RTMClient {
  AgoraRtmClient? _client;
  String? _userId;
  Function(RtmMessage message, String peerId)? onMessage;

  Function(String message, String peerId)? onMessageError;
  // 初始化RTM客户端
  Future<void> init(String appId) async {
    _client = await AgoraRtmClient.createInstance(appId);

    // 设置回调
    _client?.onMessageReceived = (RtmMessage message, String peerId) {
      onMessage?.call(message, peerId);
    };

    _client?.onConnectionStateChanged2 =
        (RtmConnectionState state, RtmConnectionChangeReason reason) {
      debugPrint("连接状态改变: state = $state, reason = $reason");
    };
  }

  // 登录
  Future<void> login(String token, String userId) async {
    await _client?.login(token, userId);
    debugPrint('$userId登录成功');
    _userId = userId;
  }

  // 发送点对点消息
  Future<void> sendPeerMessage(String peerId, String message) async {
    try {
      await _client?.sendMessageToPeer2(peerId, RtmMessage.fromText(message));
    } catch (e) {
      onMessageError?.call(message, peerId);
    }
  }

  // 加入频道
  Future<AgoraRtmChannel?> joinChannel(String channelName) async {
    AgoraRtmChannel? channel = await _client?.createChannel(channelName);
    await channel?.join();

    // 设置频道消息回调
    channel?.onMessageReceived = (RtmMessage message, RtmChannelMember member) {
      debugPrint("收到频道消息: ${message.text} 从用户: ${member.userId}");
    };

    return channel;
  }

  // 登出
  Future<void> logout() async {
    await _client?.logout();
    _userId = null;
  }
}
