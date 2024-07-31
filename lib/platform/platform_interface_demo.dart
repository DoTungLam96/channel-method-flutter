import 'package:flutter_channel_platform/model/user.dart';
import 'package:flutter_channel_platform/platform/method_channel_demo.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract class PlatformDemoPlugin extends PlatformInterface {
  /// Constructs
  PlatformDemoPlugin() : super(token: _token);

  static final Object _token = Object();

  static PlatformDemoPlugin _instance = MethodChannelDemo();

  static PlatformDemoPlugin get instance => _instance;

  static set instance(PlatformDemoPlugin instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<User?> checkInforDevice();

  Stream<double> getSensorStream();

  


}
