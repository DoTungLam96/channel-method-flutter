import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_channel_platform/model/user.dart';
import 'package:flutter_channel_platform/platform/platform_interface_demo.dart';

class MethodChannelDemo extends PlatformDemoPlugin {
  final methodChannel = const MethodChannel('platform_native_demo');

  final _eventChannel = const EventChannel('eventChannelStream');

  @override
  Future<User?> checkInforDevice() async {
    try {
      final result =
          await methodChannel.invokeMethod('checkInfoDevice', {'code': "0"});
      final user = User.fromJson(jsonDecode(result));

      return user;
    } catch (_) {
      return null;
    }
  }

  @override
  Stream<double> getSensorStream() {
    methodChannel.invokeListMethod('sensorEvent');
    return _eventChannel.receiveBroadcastStream().map<double>((event) {
      return event;
    });
  }
}
