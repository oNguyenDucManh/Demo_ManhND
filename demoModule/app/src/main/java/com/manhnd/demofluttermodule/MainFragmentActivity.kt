package com.manhnd.demofluttermodule

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.dart.DartExecutor
import kotlinx.android.synthetic.main.activity_main_fragment.*

class MainFragmentActivity : AppCompatActivity() {

    private var flutterEngine: FlutterEngine? = null
    private var routerName: String? = null
    private val PARTIAL_SCREEN_ENGINE_ID = "partialScreenEngineId"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main_fragment)
        routerName = intent.getStringExtra("routerName")
        setUpFlutter()
    }

    private fun setUpFlutter() {
        if (flutterEngine == null) {
            flutterEngine = FlutterEngine(this)
            flutterEngine!!.dartExecutor.executeDartEntrypoint(DartExecutor.DartEntrypoint.createDefault())
            flutter_view.attachToFlutterEngine(flutterEngine!!)
        }
    }

    override fun onResume() {
        super.onResume()
        flutterEngine!!.lifecycleChannel.appIsResumed()
    }

    override fun onPause() {
        super.onPause()
        flutterEngine!!.lifecycleChannel.appIsInactive()
    }

    override fun onStop() {
        super.onStop()
        flutterEngine!!.lifecycleChannel.appIsPaused()
    }

    override fun onDestroy() {
        flutter_view!!.detachFromFlutterEngine()
        super.onDestroy()
    }
}
