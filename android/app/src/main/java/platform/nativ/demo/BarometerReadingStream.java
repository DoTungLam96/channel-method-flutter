package platform.nativ.demo;

import android.annotation.TargetApi;
import android.content.Context;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.os.Build;

import io.flutter.plugin.common.EventChannel;

public class BarometerReadingStream implements SensorEventListener, EventChannel.StreamHandler {
    private SensorManager sensorManager;
    private  Sensor barometer;
    private float latestReading = 0;

    private   EventChannel.EventSink sink;
    public void init(Context context){
        sensorManager = (SensorManager) context.getSystemService(Context.SENSOR_SERVICE);
        barometer = sensorManager.getDefaultSensor(Sensor.TYPE_PRESSURE);
        sensorManager.registerListener(this, barometer, SensorManager.SENSOR_DELAY_NORMAL);
    }
    @Override
    public void onSensorChanged(SensorEvent sensorEvent) {
        latestReading = sensorEvent.values[0];
        sink.success(latestReading);
    }

    @Override
    public void onAccuracyChanged(Sensor sensor, int i) {

    }


    @Override
    public void onListen(Object o, EventChannel.EventSink eventSink) {
        sink = eventSink;
    }

    @Override
    public void onCancel(Object o) {
        sink  = null;
    }
}