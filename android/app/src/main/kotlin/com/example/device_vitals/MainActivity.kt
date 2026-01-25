package com.example.device_vitals
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.app.ActivityManager


class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.device_vitals/device-info"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "getDeviceVitals" -> {
                    result.success(getAllDeviceVitals())
                }

                else -> result.notImplemented()
            }
        }
    }

    private fun getAllDeviceVitals(): Map<String, Any> {
        val vitals = mutableMapOf<String, Any>()

        // B A T T E R Y
        val batteryLevel = getBatteryLevel()
        vitals["batteryLevel"] = if (batteryLevel != -1) batteryLevel else "unknown"
        vitals["isCharging"] = isCharging()

        // M E M O R Y
        val memInfo = getMemoryInfo()
        vitals["usedMemoryGB"] = memInfo["used"] ?: 0.0
        vitals["totalMemoryGB"] = memInfo["total"] ?: 0.0

        // T E M P E R A T U R E
        vitals["temperatureC"] = getApproximateTemperature()

        return vitals
    }

    private fun getBatteryLevel(): Int {
        val batteryManager =
            getSystemService(BATTERY_SERVICE) as BatteryManager
        return batteryManager.getIntProperty(
            BatteryManager.BATTERY_PROPERTY_CAPACITY
        )
    }

    private fun isCharging(): Boolean {
        val intent = ContextWrapper(applicationContext).registerReceiver(
            null,
            IntentFilter(Intent.ACTION_BATTERY_CHANGED)
        )
        val status = intent?.getIntExtra(BatteryManager.EXTRA_STATUS, -1) ?: -1
        return status == BatteryManager.BATTERY_STATUS_CHARGING ||
                status == BatteryManager.BATTERY_STATUS_FULL
    }

    private fun getMemoryInfo(): Map<String, Double> {
        val memoryInfo = ActivityManager.MemoryInfo()
        val activityManager = getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
        activityManager.getMemoryInfo(memoryInfo)

        val totalGB = memoryInfo.totalMem / (1024.0 * 1024.0 * 1024.0)
        val availGB = memoryInfo.availMem / (1024.0 * 1024.0 * 1024.0)
        val usedGB = totalGB - availGB

        return mapOf("used" to usedGB, "total" to totalGB)
    }

    private fun getApproximateTemperature(): Double {
        val intent = registerReceiver(
            null,
            IntentFilter(Intent.ACTION_BATTERY_CHANGED)
        )
        val temp = intent?.getIntExtra(
            BatteryManager.EXTRA_TEMPERATURE,
            -1
        ) ?: -1
        return if (temp > 0) temp / 10.0 else -1.0
    }
}