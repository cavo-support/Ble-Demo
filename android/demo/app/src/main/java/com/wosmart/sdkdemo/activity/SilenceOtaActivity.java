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

import com.wosmart.sdkdemo.R;
import com.wosmart.sdkdemo.common.BaseActivity;
import com.wosmart.ukprotocollibary.WristbandManager;
import com.wosmart.ukprotocollibary.WristbandManagerCallback;


public class SilenceOtaActivity extends BaseActivity implements View.OnClickListener {

    private String tag = "SilenceOtaActivity";

    private Toolbar toolbar;

    private Button btn_check_status;

    private EditText et_mode;

    private Button btn_set_mode;

    private Button btn_read_mode;

    private Handler handler;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_silence_ota);
        initView();
        initData();
        addListener();
    }

    private void initView() {
        toolbar = findViewById(R.id.toolbar);
        btn_check_status = findViewById(R.id.btn_check_status);
        et_mode = findViewById(R.id.et_mode);
        btn_set_mode = findViewById(R.id.btn_set_mode);
        btn_read_mode = findViewById(R.id.btn_read_mode);
    }

    private void initData() {
        handler = new MyHandler();

        WristbandManager.getInstance(this).registerCallback(new WristbandManagerCallback() {
            @Override
            public void onSilenceOtaStatus(int status) {
                super.onSilenceOtaStatus(status);
                Log.i(tag, "onSilenceOtaStatus : " + status);
            }

            @Override
            public void onSilenceUpgradeModel(int model) {
                super.onSilenceUpgradeModel(model);
                Log.i(tag, "onSilenceUpgradeModel : " + model);

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
        btn_check_status.setOnClickListener(this);
        btn_set_mode.setOnClickListener(this);
        btn_read_mode.setOnClickListener(this);
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.btn_check_status:
                checkStatus();
                break;
            case R.id.btn_set_mode:
                String modeStr = et_mode.getText().toString();
                if (null != modeStr && !modeStr.isEmpty()) {
                    int mode = Integer.parseInt(modeStr);
                    setMode(mode);
                } else {
                    showToast(getString(R.string.app_silence_mode));
                }
                break;
            case R.id.btn_read_mode:
                readMode();
                break;
        }
    }

    private void checkStatus() {
        Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                if (WristbandManager.getInstance(SilenceOtaActivity.this).sendRequestSilenceOtaStatus()) {
                    handler.sendEmptyMessage(0x01);
                } else {
                    handler.sendEmptyMessage(0x02);
                }
            }
        });
        thread.start();
    }

    private void setMode(final int mode) {
        Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                if (WristbandManager.getInstance(SilenceOtaActivity.this).sendEnterSilenceModel(mode)) {
                    handler.sendEmptyMessage(0x01);
                } else {
                    handler.sendEmptyMessage(0x02);
                }
            }
        });
        thread.start();
    }

    private void readMode() {
        Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                if (WristbandManager.getInstance(SilenceOtaActivity.this).sendRequestSilenceModel()) {
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
