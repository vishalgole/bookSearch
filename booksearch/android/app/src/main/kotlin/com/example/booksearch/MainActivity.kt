package com.example.booksearch

import android.content.Context
import android.content.pm.PackageManager
import android.hardware.camera2.CameraDevice
import android.hardware.camera2.CameraManager
import android.os.BatteryManager
import android.os.Build
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.lang.reflect.Method

class MainActivity : FlutterActivity(){
    private val infoChannel = "com.example.device/info"
    private val sensorChannel = "com.example.device/sensor"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine){
        super.configureFlutterEngine(flutterEngine);

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, infoChannel).setMethodCallHandler{
            call, result -> when (call.method){
                "getBatteryLevel" -> {
                    try {
                        val bm = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
                        val level = bm.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
                        result.success(level)
                    } catch (e: Exception){
                        result.error("BATTERY_ERR", e.message,null)
                    }
                }

                "getDeviceName" -> {
                    val name = "${Build.MANUFACTURER} ${Build.MODEL}"
                    result.success(name)
                }

                "getDeviceOSVersion" -> {
                    val os = "Android ${Build.VERSION.RELEASE}"
                    result.success(os)
                }
            else -> result.notImplemented()
            }
        }

       MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "sensorChannel").setMethodCallHandler { call, result ->
    when (call.method) {
        "isFlashAvailable" -> {
            val cm = getSystemService(Context.CAMERA_SERVICE) as CameraManager
            val hasFlash = packageManager.hasSystemFeature(PackageManager.FEATURE_CAMERA_FLASH)
            result.success(hasFlash)
        }
        "toggleFlash" -> {
            val enable = call.arguments as Boolean
            try {
                val cm = getSystemService(Context.CAMERA_SERVICE) as CameraManager
                val cameraId = cm.cameraIdList.first()
                cm.setTorchMode(cameraId, enable)
                result.success(enable)
            } catch (e: Exception) {
                result.error("TORCH_ERROR", e.message, null)
            }
        }
        else -> result.notImplemented()
    }
}
    }
}
