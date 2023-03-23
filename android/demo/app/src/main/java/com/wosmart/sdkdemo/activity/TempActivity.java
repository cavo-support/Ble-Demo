package com.wosmart.sdkdemo.activity;

import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import androidx.annotation.Nullable;
import androidx.appcompat.widget.Toolbar;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.Switch;

import com.wosmart.sdkdemo.R;
import com.wosmart.sdkdemo.common.BaseActivity;
import com.wosmart.ukprotocollibary.WristbandManager;
import com.wosmart.ukprotocollibary.WristbandManagerCallback;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerBpItemPacket;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerBpPacket;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerHrpItemPacket;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerHrpPacket;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerTemperatureControlPacket;

import java.util.logging.Logger;


/**
 * 开始测试温度前 请先调用检查温度方法
 * <p>
 * 检查温度回调
 * 0 温度检测关闭
 * 1 温度检测开始
 * 2 设备未开启心率检测，（温度依赖于心率）
 * 3 设备心率检测已开启，可以开始温度测量
 * <p>
 *
 * Before starting to test the temperature, please call the check temperature method
 * Check temperature callback
 * 0 Temperature detection is off
 * 1 Start of temperature detection
 * 2 Heart rate detection is not enabled on the device (temperature depends on heart rate)
 * 3 The device heart rate detection is turned on, you can start temperature measurement
 */
public class TempActivity extends BaseActivity implements View.OnClickListener {

    private String tag = "TempActivity";

    private Toolbar toolbar;

    private Button btn_check_test_status;

    private Button btn_start_measure;

    private Button btn_stop_measure;

    private Button btn_read_temp_setting;

    private Switch sw_show_temp;

    private Switch sw_temp_adjust;

    private Switch sw_temp_unit;

    private Button btn_set_temp_setting;

    private Handler handler;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_temp);
        initView();
        initData();
        addListener();
    }

    private void initView() {
        toolbar = findViewById(R.id.toolbar);
        btn_check_test_status = findViewById(R.id.btn_check_test_status);
        btn_start_measure = findViewById(R.id.btn_start_measure);
        btn_stop_measure = findViewById(R.id.btn_stop_measure);
        btn_read_temp_setting = findViewById(R.id.btn_read_temp_setting);
        sw_show_temp = findViewById(R.id.sw_show_temp);
        sw_temp_adjust = findViewById(R.id.sw_temp_adjust);
        sw_temp_unit = findViewById(R.id.sw_temp_unit);
        btn_set_temp_setting = findViewById(R.id.btn_set_temp_setting);
    }

    private void initData() {
        handler = new MyHandler();
        WristbandManager.getInstance(this).registerCallback(new WristbandManagerCallback() {

            //此方法需要读取设备支持功能后才会回调
            @Override
            public void onTemperatureData(ApplicationLayerHrpPacket packet) {
                super.onTemperatureData(packet);
                for (ApplicationLayerHrpItemPacket item : packet.getHrpItems()) {
                    Log.i(tag, "temp origin value :" + item.getTempOriginValue() + " temperature adjust value : " + item.getTemperature() + " is wear :" + item.isWearStatus() + " is adjust : " + item.isAdjustStatus() + "is animation :" + item.isAnimationStatus());
                }
            }

            @Override
            public void onTemperatureMeasureSetting(ApplicationLayerTemperatureControlPacket packet) {
                super.onTemperatureMeasureSetting(packet);
                Log.i(tag, "temp setting : show = " + packet.isShow() + " adjust = " + packet.isAdjust() + " celsius unit = " + packet.isCelsiusUnit());
            }

            @Override
            public void onTemperatureMeasureStatus(int status) {
                super.onTemperatureMeasureStatus(status);
                Log.i(tag, "temp status :" + status);
            }
        });
    }

    private void addListener() {
        toolbar.setNavigationOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                finish();
            }
        });
        btn_check_test_status.setOnClickListener(this);
        btn_start_measure.setOnClickListener(this);
        btn_stop_measure.setOnClickListener(this);
        btn_read_temp_setting.setOnClickListener(this);
        btn_set_temp_setting.setOnClickListener(this);
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.btn_check_test_status:
                checkTempStatus();
                break;
            case R.id.btn_start_measure:
                startMeasure();
                break;
            case R.id.btn_stop_measure:
                stopMeasure();
                break;
            case R.id.btn_read_temp_setting:
                readTempSetting();
                break;
            case R.id.btn_set_temp_setting:
                boolean show = sw_show_temp.isChecked();
                boolean adjust = sw_temp_adjust.isChecked();
                boolean unit = sw_temp_unit.isChecked();

                ApplicationLayerTemperatureControlPacket packet = new ApplicationLayerTemperatureControlPacket();
                packet.setShow(show);
                packet.setAdjust(adjust);
                packet.setCelsiusUnit(unit);
                setTempSetting(packet);
                break;
        }
    }

    private void checkTempStatus() {
        Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                if (WristbandManager.getInstance(TempActivity.this).checkTemperatureStatus()) {
                    handler.sendEmptyMessage(0x01);
                } else {
                    handler.sendEmptyMessage(0x02);
                }
            }
        });
        thread.start();
    }

    private void startMeasure() {
        Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                if (WristbandManager.getInstance(TempActivity.this).setTemperatureStatus(true)) {
                    handler.sendEmptyMessage(0x01);
                } else {
                    handler.sendEmptyMessage(0x02);
                }
            }
        });
        thread.start();
    }

    private void stopMeasure() {
        Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                if (WristbandManager.getInstance(TempActivity.this).setTemperatureStatus(false)) {
                    handler.sendEmptyMessage(0x01);
                } else {
                    handler.sendEmptyMessage(0x02);
                }
            }
        });
        thread.start();
    }

    private void readTempSetting() {
        Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                if (WristbandManager.getInstance(TempActivity.this).requestTemperatureSetting()) {
                    handler.sendEmptyMessage(0x01);
                } else {
                    handler.sendEmptyMessage(0x02);
                }
            }
        });
        thread.start();
    }

    private void setTempSetting(final ApplicationLayerTemperatureControlPacket packet) {
        Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                if (WristbandManager.getInstance(TempActivity.this).setTemperatureControl(packet)) {
                    handler.sendEmptyMessage(0x01);
                } else {
                    handler.sendEmptyMessage(0x02);
                }
            }
        });
        thread.start();
    }

    private class MyHandler extends Handler {
        @Override
        public void handleMessage(Message msg) {
            super.handleMessage(msg);
            switch (msg.what) {
                case 0x01:
                    showToast(getString(R.string.app_success));
                    break;
                case 0x02:
                    showToast(getString(R.string.app_fail));
                    break;
            }
        }
    }
}
