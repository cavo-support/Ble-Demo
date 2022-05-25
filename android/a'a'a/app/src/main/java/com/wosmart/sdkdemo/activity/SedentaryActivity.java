package com.wosmart.sdkdemo.activity;

import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.support.annotation.Nullable;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.RadioGroup;

import com.wosmart.sdkdemo.common.BaseActivity;
import com.wosmart.sdkdemo.R;
import com.wosmart.ukprotocollibary.WristbandManager;
import com.wosmart.ukprotocollibary.WristbandManagerCallback;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerSitPacket;

public class SedentaryActivity extends BaseActivity implements View.OnClickListener {

    private Toolbar toolbar;
    private Button btn_read;
    private RadioGroup rg_status;
    private EditText et_max;
    private EditText et_interval;
    private EditText et_start_minute;
    private EditText et_end_minute;
    private Button btn_set_sedentary;

    private Handler handler;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_sedentary);
        initView();
        initData();
        addListener();
    }

    private void initView() {
        toolbar = findViewById(R.id.toolbar);
        btn_read = findViewById(R.id.btn_read);
        rg_status = findViewById(R.id.rg_status);
        et_max = findViewById(R.id.et_max);
        et_interval = findViewById(R.id.et_interval);
        et_start_minute = findViewById(R.id.et_start_minute);
        et_end_minute = findViewById(R.id.et_end_minute);
        btn_set_sedentary = findViewById(R.id.btn_set_sedentary);
    }

    private void initData() {
        handler = new MyHandler();
        WristbandManager.getInstance(this).registerCallback(new WristbandManagerCallback() {

            @Override
            public void onLongSitSettingReceive(ApplicationLayerSitPacket packet) {
                super.onLongSitSettingReceive(packet);
                showToast("Sedentary :" + packet.toString());
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
        btn_read.setOnClickListener(this);
        btn_set_sedentary.setOnClickListener(this);
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.btn_read:
                readSedentary();
                break;
            case R.id.btn_set_sedentary:
                String maxStr = et_max.getText().toString();
                String startMinuteStr = et_start_minute.getText().toString();
                String endMinuteStr = et_end_minute.getText().toString();
                String intervalStr = et_interval.getText().toString();
                if (null != maxStr) {
                    if (null != startMinuteStr) {
                        if (null != endMinuteStr) {
                            if (null != intervalStr) {
                                int max = Integer.parseInt(maxStr);
                                int interval = Integer.parseInt(intervalStr);
                                int startMinute = Integer.parseInt(startMinuteStr);
                                int endMinute = Integer.parseInt(endMinuteStr);
                                boolean openFlag = false;
                                if (rg_status.getCheckedRadioButtonId() == R.id.rb_open) {
                                    openFlag = true;
                                }
                                ApplicationLayerSitPacket sedentary = new ApplicationLayerSitPacket();
                                sedentary.setmEnable(openFlag);
                                sedentary.setmThreshold(max);
                                sedentary.setmNotifyTime(interval);
                                sedentary.setmStartNotifyTime(startMinute);
                                sedentary.setmStopNotifyTime(endMinute);
                                sedentary.setmDayFlags(ApplicationLayerSitPacket.REPETITION_ALL);

                                setSedentary(sedentary);
                            } else {
                                showToast(getString(R.string.app_sedentary_hint_interval));
                            }
                        } else {
                            showToast(getString(R.string.app_sedentary_hint_end));
                        }
                    } else {
                        showToast(getString(R.string.app_sedentary_hint_start));
                    }
                } else {
                    showToast(getString(R.string.app_sedentary_hint_max_value));
                }
                break;
        }
    }

    private void readSedentary() {
        Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                if (WristbandManager.getInstance(SedentaryActivity.this).sendLongSitRequest()) {
                    handler.sendEmptyMessage(0x01);
                } else {
                    handler.sendEmptyMessage(0x02);
                }
            }
        });
        thread.start();
    }

    private void setSedentary(final ApplicationLayerSitPacket packet) {
        Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                if (WristbandManager.getInstance(SedentaryActivity.this).setLongSit(packet)) {
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
