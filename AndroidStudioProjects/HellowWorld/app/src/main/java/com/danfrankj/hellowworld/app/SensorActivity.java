package com.danfrankj.hellowworld.app;

import android.app.Activity;
import android.content.Context;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.os.Bundle;
import android.widget.TextView;
import android.util.FloatMath;

/**
 * Created by dfrank on 7/1/14.
 */
public class SensorActivity extends Activity implements SensorEventListener {

    private SensorManager mSensorManager;
    private Sensor mAccel;

    @Override
    public final void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        mSensorManager = (SensorManager) getSystemService(Context.SENSOR_SERVICE);
        mAccel= mSensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER);
    }

    @Override
    public final void onAccuracyChanged(Sensor sensor, int accuracy) {
        // Do something here if sensor accuracy changes.
    }

    @Override
    public final void onSensorChanged(SensorEvent event) {
        // The light sensor returns a single value.
        // Many sensors return 3 values, one for each axis.
        float x = event.values[0];
        float y = event.values[1];
        float z = event.values[2];
        float mag = FloatMath.sqrt(FloatMath.pow(x, 2f) + FloatMath.pow(y, 2f) + FloatMath.pow(z, 2f));
        String toDisplay = String.valueOf(x) + "," + String.valueOf(y) + "," + String.valueOf(z);
        // Do something with this sensor value.
        toDisplay = toDisplay + "\n" + String.valueOf(mag);
        TextView myTextView = (TextView) findViewById(R.id.sensorTextView);
        myTextView.setText(String.valueOf(toDisplay));
    }

    @Override
    protected void onResume() {
        super.onResume();
        mSensorManager.registerListener(this, mAccel, SensorManager.SENSOR_DELAY_NORMAL);
    }

    @Override
    protected void onPause() {
        super.onPause();
        mSensorManager.unregisterListener(this);
    }

}
