package com.projectxpolaris.youplus

import android.content.Context
import android.content.Intent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class AuthPlugin : FlutterPlugin, MethodChannel.MethodCallHandler, ActivityAware {
    private var methodChannel: MethodChannel? = null
    private var context: Context? = null
    private var activity: FlutterActivity? = null
    private var binaryMessenger: BinaryMessenger? = null
    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        context = binding.applicationContext
        methodChannel = MethodChannel(binding.binaryMessenger, AuthPlugin.CHANNEL_NAME)
        methodChannel?.setMethodCallHandler(this)
        binaryMessenger = binding.binaryMessenger
    }


    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        methodChannel?.setMethodCallHandler(null)
        methodChannel = null

    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            METHOD_IS_AUTH_MODE -> isAuthMode(call, result)
            METHOD_AUTH_APP -> authApp(call, result)
        }
    }

    fun isAuthMode(call: MethodCall, result: MethodChannel.Result) {
        result.success(AppConfig.authMode)
    }

    fun authApp(call: MethodCall, result: MethodChannel.Result) {
        activity?.apply {
            val intent = Intent()
            intent.putExtra("USERNAME", call.argument<String>("username"))
            intent.putExtra("TOKEN", call.argument<String>("token"))
            activity.setResult(1, intent)
            finish()
        }
//        val intent = Intent()
//        intent.action = AppConfig.authCallback
//        intent.putExtra("USERNAME", call.argument<String>("username"))
//        intent.putExtra("TOKEN", call.argument<String>("token"))
//        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
//        context!!.startActivity(intent)
    }


    companion object {
        const val CHANNEL_NAME = "authplugin"
        const val METHOD_IS_AUTH_MODE = "isAuthMode"
        const val METHOD_AUTH_APP = "authApp"
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity as FlutterActivity
    }

    override fun onDetachedFromActivityForConfigChanges() {
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    }

    override fun onDetachedFromActivity() {
    }
}