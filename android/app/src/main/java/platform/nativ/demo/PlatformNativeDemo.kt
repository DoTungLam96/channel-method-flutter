package platform.nativ.demo
import android.content.Context
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
class PlatformNativeDemo: FlutterPlugin, MethodCallHandler {

    private lateinit var channel: MethodChannel
    private lateinit var context: Context
    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "platform_native_demo")
        channel.setMethodCallHandler(this)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }


    override fun onMethodCall(call: MethodCall, result: Result) {
        val arguments = call.arguments as? Map<String, Any>? ?: mapOf()

        when (call.method) {
            "checkInfoDevice" -> checkInfoDevice(result, arguments)

            else -> result.notImplemented()
        }
    }

    fun checkInfoDevice(result: Result, args : Map<String, Any>?) {

            try {
                val currentCode = args?.get("code") as String?


                assert(currentCode != null ) {
                    illegalArguments(result)
                    return
                }


                if (currentCode == "0") {
                    result.success("Success roi nhe !")
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