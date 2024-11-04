import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

part 'state.dart';

class MQTTManager {
  // Private instance of client
  final MQTTAppState currentState;
  late MqttServerClient client;
  final String identifier;
  final String server;
  final int port;
  final String topic;
  final MqttQos qos;
  final void Function(String topic, String message) onMessage;

  // 构造函数
  MQTTManager({
    required this.server,
    required this.topic,
    required this.currentState,
    required this.identifier,
    required this.onMessage,
    this.port = 1883,
    this.qos = MqttQos.atLeastOnce,
  });

  void initializeMQTTClient() {
    client = MqttServerClient.withPort(server, identifier, port);

    /// 设置协议
    client.setProtocolV311();
    client.keepAlivePeriod = 20;

    ///设置连接超时时间
    client.connectTimeoutPeriod = 200000;
    // _client.useWebSocket = true;
    // _client.autoReconnect = true;
    client.secure = false;
    client.logging(on: true);

    ///断开连接回调
    client.onDisconnected = onDisconnected;

    /// 连接成功回调
    client.onConnected = onConnected;

    ///订阅成功的回调函数
    client.onSubscribed = onSubscribed;

    /// 订阅失败的回调函数
    client.onSubscribeFail = onSubscribeFail;

    /// 取消订阅的回调函数
    client.onUnsubscribed = (topic) => onUnsubscribed(topic);

    final MqttConnectMessage connMess = MqttConnectMessage()
        .authenticateAs('username', 'password')
        .withClientIdentifier(identifier)
        .withWillTopic('willtopic')
        .withWillMessage('My Will message')
        .startClean()
        .withWillQos(qos);
    debugPrint('MQTT 服务器连接中...');
    client.connectionMessage = connMess;
  }

  // Connect to the server
  void connect(String username, String password) async {
    // assert(client != null);
    try {
      debugPrint('MQTT 服务器连接中...');
      currentState.setAppConnectionState(MQTTAppConnectionState.connecting);
      await client.connect(username, password);
    } on Exception catch (e) {
      debugPrint('MQTT 服务器报错 - $e');
      disconnect();
    }
  }

  void disconnect() {
    debugPrint('已断开连接');
    client.disconnect();
  }

  void unsubscribe(String topic) {
    debugPrint('已取消订阅： $topic');
    client.unsubscribe(topic);
  }

  ///暂时来区分是否是自己发布的消息
  String tempMessage = '';

  void publish(String message) {
    final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
    tempMessage = message;
    builder.addUTF8String(message);
    client.publishMessage(topic, qos, builder.payload!, retain: true);
  }

  /// The subscribed callback
  void onSubscribed(String topic) {
    debugPrint('正在订阅主题： $topic');
  }

  /// The unsolicited disconnect callback
  void onDisconnected() {
    currentState.setAppConnectionState(MQTTAppConnectionState.disconnected);
    debugPrint("已断开mqtt服务 $server");
  }

  ///取消订阅
  onUnsubscribed(String? topic) {
    debugPrint("已取消订阅 $topic");
  }

  onSubscribeFail(String topic) {
    debugPrint("订阅失败 $topic");
  }

  /// 连接成功回调
  void onConnected() {
    currentState.setAppConnectionState(MQTTAppConnectionState.connected);
    debugPrint('MQTT 服务器连接成功！');
    client.subscribe(topic, qos);
    client.updates?.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage recMess = c[0].payload as MqttPublishMessage;
      String message = const Utf8Decoder().convert(recMess.payload.message);
      currentState.setReceivedText(message);
      if (tempMessage != message) onMessage(topic, message);
      debugPrint('订阅主题是：<${c[0].topic}>,消息是： <-- $message -->');
    });
  }
}
