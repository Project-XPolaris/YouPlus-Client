package com.projectxpolaris.youplus
import android.graphics.Color
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        window.decorView.apply {
            javaClass.declaredFields
                    .firstOrNull { it.name == "mSemiTransparentBarColor" }
                    ?.apply { isAccessible = true }
                    ?.setInt(this, Color.TRANSPARENT)
        }
        flutterEngine?.plugins?.apply {
            add(AuthPlugin())
        }
        if (intent.action == "com.projectxpolaris.AUTH_LOGIN") {
            AppConfig.authMode = true
            AppConfig.authCallback = intent.getStringExtra("CALLBACK") ?: ""
        }
    }
}
