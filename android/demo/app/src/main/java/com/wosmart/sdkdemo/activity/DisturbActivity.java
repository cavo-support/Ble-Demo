package com.wosmart.sdkdemo.activity;

import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.RadioGroup;

import androidx.annotation.Nullable;
import androidx.appcompat.widget.Toolbar;

import com.wosmart.sdkdemo.common.BaseActivity;
import com.wosmart.sdkdemo.R;
import com.wosmart.ukprotocollibary.WristbandManager;
import com.wosmart.ukprotocollibary.WristbandManagerCallback;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerDisturbPacket;

public class DisturbActivity extends BaseActivity implements View.OnClickListener {

    private String tag = "DisturbActivity";

    private Toolbar toolbar;

    private Button btn_read;

    private RadioGroup rg_status;

    private EditText et_start_hour;

    private EditText et_start_minute;

    private EditText et_end_hour;

    private EditText et_end_minute;

    private Button btn_set;

    private Handler handler;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_disturb);
        initView();
        initData();
        addListener();
    }

    private void initView() {
        toolbar = findViewById(R.id.toolbar);
        rg_status = findViewById(R.id.rg_status);
        et_start_hour = findViewById(R.id.et_start_hour);
        et_start_minute = findViewById(R.id.et_start_minute);
        et_end_hour = findViewById(R.id.et_end_hour);
        et_end_minute = findViewById(R.id.et_end_minute);
        btn_read = findViewById(R.id.btn_read);
        btn_set = findViewById(R.id.btn_set);
    }

    private void initData() {
        handler = new MyHandler();
        WristbandManager.getInstance(this).registerCallback(new WristbandManagerCallback() {

            @Override
            public void onDisturb(ApplicationLayerDisturbPacket packet) {
                super.onDisturb(packet);
                Log.i(tag, "disturb = " + packet.toString());
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
        btn_set.setOnClickListener(this);
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.btn_read:
                readDisturb();
                break;
            case R.id.btn_set:
                int checkID = rg_status.getCheckedRadioButtonId();
                boolean flag;
                if (checkID == R.id.rb_open) {
                    flag = true;
                } else {
                    flag = false;
                }
                String startHourStr = et_start_hour.getText().toString();
                String startMinuteStr = et_start_minute.getText().toString();
                String endHourStr = et_end_hour.getText().toString();
                String endMinuteStr = et_end_minute.getText().toString();
                if (null != startHourStr && !startHourStr.isEmpty()) {
                    int startHour = Integer.parseInt(startHourStr);
                    if (null != startMinuteStr && !startMinuteStr.isEmpty()) {
                        int startMinute = Integer.parseInt(startMinuteStr);
                        if (null != endHourStr && !endHourStr.isEmpty()) {
                            int endHour = Integer.parseInt(endHourStr);
                            if (null != endMinuteStr && !endMinuteStr.isEmpty()) {
                                int endMinute = Integer.parseInt(endMinuteStr);
                                ApplicationLayerDisturbPacket disturbData = new ApplicationLayerDisturbPacket();
                                disturbData.setOpen(flag);
                                disturbData.setStartHour(startHour);
                                disturbData.setStartMinute(startMinute);
                                disturbData.setEndHour(endHour);
                                disturbData.setEndMinute(endMinute);
                                setDisturb(disturbData);
                            } else {
                                showToast(getString(R.string.app_disturb_hint_end_minute));
                            }
                        } else {
                            showToast(getString(R.string.app_disturb_hint_end_hour));
                        }
                    } else {
                        showToast(getString(R.string.app_disturb_hint_start_minute));
                    }
                } else {
                    showToast(getString(R.string.app_disturb_hint_start_hour));
                }
                break;
        }
    }

    private void readDisturb() {
        Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                if (WristbandManager.getInstance(DisturbActivity.this).sendDisturbSettingReq()) {
                    handler.sendEmptyMessage(0x01);
                } else {
                    handler.sendEmptyMessage(0x02);
                }
            }
        });
        thread.start();
    }

    private void setDisturb(final ApplicationLayerDisturbPacket disturbPacket) {
        Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                if (WristbandManager.getInstance(DisturbActivity.this).settingDisturb(disturbPacket)) {
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
