package com.example.device_vitals
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build
import android.os.PowerManager
import android.app.ActivityManager
import androidx.annotation.RequiresApi
import kotlin.math.roundToInt

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
        vitals["batteryLevel"] = if (batteryLevel != -1) batteryLevel else 0
        vitals["isCharging"] = isCharging()
        vitals["memoryUsagePercentage"] = getMemoryUsagePercentage()
        vitals["thermalStatus"] = getThermalStatus()

        return vitals
    }

    private fun getBatteryLevel(): Int {
        return try {
            val batteryManager = getSystemService(BATTERY_SERVICE) as BatteryManager
            batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } catch (e: Exception) {
            -1
        }
    }

    private fun isCharging(): Boolean {
        return try {
            val intent = ContextWrapper(applicationContext).registerReceiver(
                null,
                IntentFilter(Intent.ACTION_BATTERY_CHANGED)
            )
            val status = intent?.getIntExtra(BatteryManager.EXTRA_STATUS, -1) ?: -1
            status == BatteryManager.BATTERY_STATUS_CHARGING ||
                    status == BatteryManager.BATTERY_STATUS_FULL
        } catch (e: Exception) {
            false
        }
    }

    // M E M O R Y
    private fun getMemoryUsagePercentage(): Double {
        return try {
            val memoryInfo = ActivityManager.MemoryInfo()
            val activityManager = getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
            activityManager.getMemoryInfo(memoryInfo)

            val totalMem = memoryInfo.totalMem.toDouble()
            val availMem = memoryInfo.availMem.toDouble()
            val usedMem = totalMem - availMem

            val percentage = (usedMem / totalMem) * 100.0
            (percentage * 100.0).roundToInt() / 100.0
        } catch (e: Exception) {
            0.0
        }
    }

    // T H E R M A L
    private fun getThermalStatus(): Int {
        return try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                getThermalStatusApi29()
            } else {
                0
            }
        } catch (e: Exception) {
            0
        }
    }

    @RequiresApi(Build.VERSION_CODES.Q)
    private fun getThermalStatusApi29(): Int {
        val powerManager = getSystemService(POWER_SERVICE) as PowerManager
        return when (powerManager.currentThermalStatus) {
            PowerManager.THERMAL_STATUS_NONE -> 0
            PowerManager.THERMAL_STATUS_LIGHT -> 1
            PowerManager.THERMAL_STATUS_MODERATE -> 2
            PowerManager.THERMAL_STATUS_SEVERE -> 3
            PowerManager.THERMAL_STATUS_CRITICAL -> 3
            PowerManager.THERMAL_STATUS_EMERGENCY -> 3
            PowerManager.THERMAL_STATUS_SHUTDOWN -> 3
            else -> 0
        }
    }
}