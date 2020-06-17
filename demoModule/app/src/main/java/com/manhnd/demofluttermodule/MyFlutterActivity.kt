package com.manhnd.demofluttermodule

import android.app.ProgressDialog
import android.content.Context
import android.content.Intent
import android.os.Handler
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.util.*


class MyFlutterActivity : FlutterActivity() {

    override fun onResume() {
        super.onResume()
        MethodChannel(
            flutterEngine?.dartExecutor?.binaryMessenger,
            BuildConfig.APPLICATION_ID
        )
            .invokeMethod("notifyNavToFlutter", intent.getStringExtra("screen"));
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, BuildConfig.APPLICATION_ID)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "exitFlutter" -> {
                        finish()
                    }
                    "getParam" -> {
                        result.success(intent.getStringExtra("param"))
                    }
                    "gotoSecondPage" -> {
                        gotoSecondActivity(call)
                    }
                    "myRandom" -> {
                        randomNumber(result)
                    }
                    else -> {
                        result.notImplemented();
                    }
                }
            }
    }

    private fun randomNumber(result: MethodChannel.Result) {
        loading = ProgressDialog(this)
        loading.show()
        Handler().postDelayed({
            loading.dismiss()
            val isRandomSuccess = Random().nextBoolean()
            val number = Math.random()
            if (isRandomSuccess) {
                result.success(number)
            } else {
                result.error("ERROR", "Random ra ket qua error", number)
            }
        }, 2000)
    }

    override fun provideFlutterEngine(context: Context): FlutterEngine? {
        return FlutterEngineCache.getInstance().get(FULL_SCREEN_ENGINE_ID)
    }

    private fun gotoSecondActivity(call: MethodCall?) {
        val intent = Intent(this, SecondActivity::class.java)
        call?.let {
            call.argument<Int>("id")?.let {
                intent.putExtra("id", it)
            }
            call.argument<String>("name")?.let {
                intent.putExtra("name", it)
            }
        }

        startActivity(intent)
    }

    private lateinit var loading: ProgressDialog

    companion object {
        private const val FULL_SCREEN_ENGINE_ID = "fullScreenEngineId"
    }
}