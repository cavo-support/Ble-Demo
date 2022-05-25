package com.wosmart.sdkdemo.activity;

import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.support.annotation.Nullable;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.RadioGroup;

import com.wosmart.sdkdemo.common.BaseActivity;
import com.wosmart.sdkdemo.R;
import com.wosmart.ukprotocollibary.WristbandManager;
import com.wosmart.ukprotocollibary.WristbandManagerCallback;

/**
 * 设置心率检测开关和间隔的时候，请确认已经执行了登录和请求设备支持功能，否则无法接收到心率数据
 * <p>
 * When setting the heart rate detection switch and interval, please confirm that has requested login and read device support function, otherwise the heart rate data cannot be received
 */
public class HrDetectActivity extends BaseActivity implements View.OnClickListener {
    private String tag = "HrDetectActivity";

    private Toolbar toolbar;

    private Button btn_read;

    private RadioGroup rg_detect_status;

    private EditText et_interval;

    private Button btn_set;

    private Handler handler;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_rate_detect);
        initView();
        initData();
        addListener();
    }

    private void initView() {
        toolbar = findViewById(R.id.toolbar);
        btn_read = findViewById(R.id.btn_read);
        rg_detect_status = findViewById(R.id.rg_detect_status);
        et_interval = findViewById(R.id.et_interval);
        btn_set = findViewById(R.id.btn_set);
    }

    private void initData() {
        handler = new MyHandler();
        WristbandManager.getInstance(this).registerCallback(new WristbandManagerCallback() {
            @Override
            public void onHrpContinueParamRsp(boolean enable, int interval) {
                super.onHrpContinueParamRsp(enable, interval);
                Log.i(tag, "enable : " + enable + "interval : " + interval);
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
                readHrDetect();
                break;
            case R.id.btn_set:
                boolean flag = rg_detect_status.getCheckedRadioButtonId() == R.id.rb_detect_open;
                String intervalStr = et_interval.getText().toString();
                if (null != intervalStr && !intervalStr.isEmpty()) {
                    int interval = Integer.parseInt(intervalStr);
                    setHrDetect(flag, interval);
                } else {
                    showToast(getString(R.string.app_hr_detect_hint));
                }
                break;
        }
    }

    private void readHrDetect() {
        Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                if (WristbandManager.getInstance(HrDetectActivity.this).sendContinueHrpParamRequest()) {
                    handler.sendEmptyMessage(0x01);
                } else {
                    handler.sendEmptyMessage(0x02);
                }
            }
        });
        thread.start();
    }

    private void setHrDetect(final boolean flag, final int interval) {
        Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                if (WristbandManager.getInstance(HrDetectActivity.this).setContinueHrp(flag, interval)) {
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
