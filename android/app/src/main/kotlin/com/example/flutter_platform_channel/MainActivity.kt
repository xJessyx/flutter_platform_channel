package com.example.flutter_platform_channel

import android.os.Bundle
import android.os.PersistableBundle
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.myApp/myChannel"
    private var methodChannel: MethodChannel? = null
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        methodChannel =
            MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
        Log.d("MainActivity", "Sending message to Flutter: hello flutter i from android");
        methodChannel?.invokeMethod("sendMessageFromAndroid", "hello flutter i from android")
        Log.d("MainActivity", "Message sent to Flutter")

    }

}
