package com.example.toikhoe;  

import io.flutter.app.FlutterApplication
import io.flutter.plugin.common.PluginRegistry
import com.zing.zalo.zalosdk.oauth.ZaloSDKApplication

class ToiKhoe : FlutterApplication(), PluginRegistry.PluginRegistrantCallback {
    override fun onCreate() {
        super.onCreate()
        ZaloSDKApplication.wrap(this)
    }
    override fun registerWith(registry: PluginRegistry) {}
}