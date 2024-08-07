package platform.nativ.demo

import android.content.Context
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import org.json.JSONException
import org.json.JSONObject


class PlatformNativeDemo: FlutterPlugin, MethodCallHandler{

    private lateinit var channel: MethodChannel
    private lateinit var context: Context
    private lateinit var  readingStream : BarometerReadingStream;

    private lateinit var eventChannel: EventChannel



    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "platform_native_demo")
        channel.setMethodCallHandler(this)
        eventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "eventChannelStream")
        readingStream = BarometerReadingStream()
        eventChannel.setStreamHandler(readingStream)

        context = flutterPluginBinding.applicationContext
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }


    override fun onMethodCall(call: MethodCall, result: Result) {
        val arguments = call.arguments as? Map<String, Any>? ?: mapOf()

        when (call.method) {
            "checkInfoDevice" -> checkInfoDevice(result, arguments)
            "sensorEvent" -> sensorEvent(result, arguments)

            else -> result.notImplemented()
        }
    }

    fun sensorEvent(result: Result, args : Map<String, Any>?){
        readingStream.init(this.context);

        result.success(true)
        return
    }

    fun checkInfoDevice(result: Result, args : Map<String, Any>?) {

            try {
                val currentCode = args?.get("code") as String?


                assert(currentCode != null ) {
                    illegalArguments(result)
                    return
                }
                 

                if (currentCode == "0") {
                   val user = User("Lam Do", 1996);
  
                    result.success(user.toJSON())
                } else {
                    result.error("-1", "Error", null)
                }
            } catch (e: Exception) {
                result.error("99", e.message, e)
            }

    }
    private fun illegalArguments(result: Result) {
        result.error("999", "Illegal arguments", null)
    }





}

class User(val nickName: String, val id: Int){
    fun toJSON(): String {
        val jsonObject = JSONObject()
        return try {
            jsonObject.put("nickName", nickName)
            jsonObject.put("id", id)
            jsonObject.toString()
        } catch (e: JSONException) {
            // TODO Auto-generated catch block
            e.printStackTrace()
            ""
        }
    }
}