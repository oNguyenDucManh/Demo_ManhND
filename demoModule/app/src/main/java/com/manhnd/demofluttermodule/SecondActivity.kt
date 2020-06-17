package com.manhnd.demofluttermodule

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import kotlinx.android.synthetic.main.activity_second.*

class SecondActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_second)
        val id = intent.getIntExtra("id", 0)
        val name = intent.getStringExtra("name");
        tvResult.text = "${id}\n${name}"
    }
}
