package com.wosmart.sdkdemo.activity;

import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.text.TextUtils;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

import androidx.annotation.Nullable;
import androidx.appcompat.widget.Toolbar;

import com.wosmart.sdkdemo.R;
import com.wosmart.sdkdemo.common.BaseActivity;
import com.wosmart.ukprotocollibary.WristbandManager;
import com.wosmart.ukprotocollibary.WristbandManagerCallback;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerCustomNotifyPacket;
import com.wosmart.ukprotocollibary.model.enums.DeviceFunctionStatus;
import com.wosmart.ukprotocollibary.util.SDKLogger;

public class CustomNotifyActivity extends BaseActivity implements View.OnClickListener {

    private String tag = "CustomNotifyActivity";

    private Toolbar toolbar;

    private EditText contentEdit;
    private Button openBtn;
    private Button sendBtn;
    private TextView statusTv;

    private Handler handler;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_custom_notify);
        initView();
        initData();
        addListener();
        SDKLogger.setIsOpenLog(true);

        new Thread(new Runnable() {
            @Override
            public void run() {
                WristbandManager.getInstance(CustomNotifyActivity.this).reqCustomNotify();
            }
        }).start();
    }

    private void initView() {
        toolbar = findViewById(R.id.toolbar);
        contentEdit = findViewById(R.id.edit_content);
        openBtn = findViewById(R.id.btn_open);
        sendBtn = findViewById(R.id.btn_send);
        statusTv = findViewById(R.id.tv_switch_status);
    }

    private void initData() {
        handler = new MyHandler();

        WristbandManager.getInstance().registerCallback(new WristbandManagerCallback() {

            @Override
            public void onCustomNotify(ApplicationLayerCustomNotifyPacket packet) {
                super.onCustomNotify(packet);

                statusTv.setText(DeviceFunctionStatus.SUPPORT_OPEN == packet.getBus() ? getString(R.string.app_open) : getString(R.string.app_close));
                openBtn.setText(DeviceFunctionStatus.SUPPORT_OPEN == packet.getBus() ? getString(R.string.app_close_notify_switch) : getString(R.string.app_open_notify_switch));
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
        sendBtn.setOnClickListener(this);
        openBtn.setOnClickListener(this);
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.btn_send:
                sendCustomNotify();
                break;
            case R.id.btn_open:
                openNotifySwitch();
                break;
        }
    }

    private void sendCustomNotify() {
        Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                String content = contentEdit.getText().toString();
                if (!TextUtils.isEmpty(content)) {
                    WristbandManager.getInstance(CustomNotifyActivity.this).sendCustomNotify(content);
                }
            }
        });
        thread.start();
    }

    private void openNotifySwitch() {
        final boolean isOpen = TextUtils.equals(statusTv.getText().toString(), getString(R.string.app_open));

        Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                ApplicationLayerCustomNotifyPacket packet = new ApplicationLayerCustomNotifyPacket();
                packet.setBus(isOpen ? DeviceFunctionStatus.SUPPORT_CLOSE : DeviceFunctionStatus.SUPPORT_OPEN);
                WristbandManager.getInstance(CustomNotifyActivity.this).setCustomNotify(packet);

                Message message = new Message();
                message.what = 0x99;
                message.obj = !isOpen;
                handler.sendMessage(message);
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
                case 0x99:
                    boolean isOpen = (boolean) msg.obj;
                    statusTv.setText(isOpen ? getString(R.string.app_open) : getString(R.string.app_close));
                    openBtn.setText(isOpen ? getString(R.string.app_close_notify_switch) : getString(R.string.app_open_notify_switch));
                    break;
            }
        }
    }
}
