package com.example.flutter_channel_platform

import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import platform.nativ.demo.PlatformNativeDemo

class MainActivity: FlutterFragmentActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        flutterEngine.plugins.add(PlatformNativeDemo())
        GeneratedPluginRegistrant.registerWith(flutterEngine)
    }
}