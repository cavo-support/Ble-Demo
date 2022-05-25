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

import com.wosmart.sdkdemo.common.BaseActivity;
import com.wosmart.sdkdemo.R;
import com.wosmart.ukprotocollibary.WristbandManager;
import com.wosmart.ukprotocollibary.WristbandManagerCallback;

public class CallActivity extends BaseActivity implements View.OnClickListener {
    private String tag = "CallActivity";
    private Toolbar toolbar;
    private EditText et_phone;
    private EditText et_name;
    private Button btn_in_call;
    private Button btn_off_call;

    private Handler handler;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_call);
        initView();
        initData();
        addListener();
    }

    private void initView() {
        toolbar = findViewById(R.id.toolbar);
        et_phone = findViewById(R.id.et_phone);
        et_name = findViewById(R.id.et_name);
        btn_in_call = findViewById(R.id.btn_in_call);
        btn_off_call = findViewById(R.id.btn_off_call);

    }

    private void initData() {
        handler = new MyHandler();
        WristbandManager.getInstance(this).registerCallback(new WristbandManagerCallback() {
            @Override
            public void onError(int error) {
                super.onError(error);
                Log.i(tag, getString(R.string.app_error));
            }

            @Override
            public void onEndCall() {
                super.onEndCall();
                Log.i(tag, getString(R.string.app_reject_call));
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
        btn_in_call.setOnClickListener(this);
        btn_off_call.setOnClickListener(this);
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.btn_in_call:
                String phoneNum = et_phone.getText().toString();
                String name = et_name.getText().toString();
                if (null != name && !name.isEmpty()) {
                    inCall(name);
                } else if (null != phoneNum && !phoneNum.isEmpty()) {
                    inCall(phoneNum);
                } else {
                    showToast(getString(R.string.app_call_hint));
                }
                break;
            case R.id.btn_off_call:
                offCall();
                break;
        }
    }

    public void inCall(final String content) {
        Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                if (WristbandManager.getInstance(CallActivity.this).sendCallNotifyInfo(content)) {
                    handler.sendEmptyMessage(0x01);
                } else {
                    handler.sendEmptyMessage(0x02);
                }
            }
        });
        thread.start();
    }

    private void offCall() {
        Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                if (WristbandManager.getInstance(CallActivity.this).sendCallRejectNotifyInfo()) {
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
