package com.example.method_chennel

import LogicImpl
import android.os.Handler
import android.os.Looper
import android.widget.Toast
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


class MainActivity : FlutterActivity() {
    private val CHANNEL = "samples.flutter.dev/battery"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            // This method is invoked on the main thread.
            // TODO
            val logicImpl: LogicImpl = LogicImpl()

            if (call.method == "getBatteryLevel") {
                val batteryLevel = logicImpl.getBatteryLevel(context)

                if (batteryLevel != -1) {
                    result.success(batteryLevel)
                } else {
                    result.error("UNAVAILABLE", "Battery level not available.", null)
                }
            } else if (call.method == "getSummation") {
                val val1: Int? = call.argument("val1")
                val val2: Int? = call.argument("val2")
                val sum = logicImpl.getSummation(val1, val2)
                result.success(sum)
//                result.success(val1)
            } else if (call.method == "getRepeat") {
                startRepeating(result)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun startRepeating(result:MethodChannel.Result) {
        //mToastRunnable.run()
        Handler().postDelayed({
            Toast.makeText(applicationContext, "Hello Javatpoint", Toast.LENGTH_LONG).show()
            result.success("Success")
        },1000)
    }

    fun stopRepeating() {

        mHandeler.removeCallbacks(mToastRunnable)
    }
    private val mHandeler:Handler = Handler()

    private val mToastRunnable: Runnable = Runnable() {

        mHandeler.postDelayed({
            Toast.makeText(applicationContext, "Hello Javatpoint", Toast.LENGTH_LONG)
        },1000)


    }
}