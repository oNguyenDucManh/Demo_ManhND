package com.manhnd.demofluttermodule

import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.plugin.common.MethodChannel
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : AppCompatActivity() {
    private var flutterEngine: FlutterEngine? = null
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        setUpFlutter()
        gotoActivity.setOnClickListener {
            val intent = Intent(this, MyFlutterActivity::class.java)
            intent.putExtra("screen", "HomePage")
            startActivity(intent)
        }

        gotoActivityHomePage.setOnClickListener {
            val intent = Intent(this, MyFlutterActivity::class.java)
            intent.putExtra("param", "123")
            intent.putExtra("screen", "DetailPage")
            startActivity(intent)
        }
        gotoActivityFragment.setOnClickListener {
            val intent = Intent(this, MainFragmentActivity::class.java)
            startActivity(intent)
        }

        gotoFragmentHomePage.setOnClickListener {
            val intent = Intent(this, MainFragmentActivity::class.java)
            intent.putExtra("routerName", "HomePage");
            startActivity(intent)
        }
    }

    private fun setUpFlutter() {
        if (flutterEngine == null) {
            flutterEngine =
                FlutterEngineCache.getInstance().get(MyApplication.PARTIAL_SCREEN_ENGINE_ID)
            flutterEngine!!
                .dartExecutor
                .executeDartEntrypoint(
                    DartExecutor.DartEntrypoint.createDefault()
                )
            MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, BuildConfig.APPLICATION_ID)
                .invokeMethod("notifyNavToFlutter", "DEFAULT")

            MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, BuildConfig.APPLICATION_ID)
                .setMethodCallHandler { call, result ->
                    run {
                        when (call.method) {
                            "exitFlutter" -> finish()
                            else -> result.notImplemented()
                        }
                    }
                }
        }
    }
}
