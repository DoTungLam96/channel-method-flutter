import 'package:flutter/services.dart';
import 'package:flutter_channel_platform/platform/platform_interface_demo.dart';

class MethodChannelDemo extends PlatformDemoPlugin {
  final methodChannel = const MethodChannel('platform_native_demo');

  final _eventChannel = const EventChannel('eventChannelStream');

  @override
  Future<String> checkInforDevice() async {
    final result =
        await methodChannel.invokeMethod('checkInfoDevice', {'code': "0"});

    return '$result';
  }

  @override
  Stream<double> getSensorStream() {
    methodChannel.invokeListMethod('sensorEvent');
    return _eventChannel.receiveBroadcastStream().map<double>((event) {
      var a = event;
      return a;
    });
  }
}
