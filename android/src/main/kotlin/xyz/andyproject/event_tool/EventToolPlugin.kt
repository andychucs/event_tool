package xyz.andyproject.event_tool

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import android.content.Context
import android.provider.CalendarContract
import android.content.Intent
import java.lang.NullPointerException


class EventToolPlugin(private val mRegistrar: Registrar) : MethodCallHandler {
    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), "event_tool")
            channel.setMethodCallHandler(EventToolPlugin(registrar))
        }
    }

    private val activeContext: Context
        get() = if (mRegistrar.activity() != null) mRegistrar.activity() else mRegistrar.context()


    override fun onMethodCall(call: MethodCall, result: Result) {
        if (call.method == "getPlatformVersion") {
            result.success("Android ${android.os.Build.VERSION.RELEASE}")
        } else {
            result.notImplemented()
        }
        if (call.method == "event_tool") {
            val title = call.argument<Any>("title") as String
            val notes = call.argument<Any>("notes") as String
            val location = call.argument<Any>("location") as String
            val start = call.argument<Any>("startDate") as Long
            val end = call.argument<Any>("endDate") as Long
            val allDay = call.argument<Any>("allDay") as Boolean
//            val alarmBefore = call.argument<Any>("alarmBefore") as? String
            try {
                insert(title, notes, location, start, end, allDay)
                result.success(true)
            } catch (e: NullPointerException) {
                result.error("Exception occurred in Android code", e.message, false)
            }
        } else {
            result.notImplemented()
        }
    }

    private fun insert(title: String, notes: String, loc: String, start: Long, end: Long, allDay: Boolean) {
        val context = activeContext
        val intent = Intent(Intent.ACTION_INSERT)
                .setData(CalendarContract.Events.CONTENT_URI)
                .putExtra(CalendarContract.Events.TITLE, title)
                .putExtra(CalendarContract.Events.DESCRIPTION, notes)
                .putExtra(CalendarContract.Events.EVENT_LOCATION, loc)
                .putExtra(CalendarContract.EXTRA_EVENT_BEGIN_TIME, start)
                .putExtra(CalendarContract.EXTRA_EVENT_END_TIME, end)
                .putExtra(CalendarContract.EXTRA_EVENT_ALL_DAY, allDay)
//                .putExtra(CalendarContract.Reminders.MINUTES, alarmBefore)
        context.startActivity(intent)
    }

}

