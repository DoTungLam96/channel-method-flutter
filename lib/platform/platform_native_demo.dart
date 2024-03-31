import 'package:flutter_channel_platform/platform/platform_interface_demo.dart';

class PlatformNativeDemo {
  Future<String> checkInforDevice() {
    return PlatformDemoPlugin.instance.checkInforDevice();
  }
}
