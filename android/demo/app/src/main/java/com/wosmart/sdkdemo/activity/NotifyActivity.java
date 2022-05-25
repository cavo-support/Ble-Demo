package com.wosmart.sdkdemo.activity;

import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.support.annotation.Nullable;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;

import com.wosmart.sdkdemo.common.BaseActivity;
import com.wosmart.sdkdemo.R;
import com.wosmart.ukprotocollibary.WristbandManager;
import com.wosmart.ukprotocollibary.model.enums.NotifyType;

public class NotifyActivity extends BaseActivity implements View.OnClickListener {

    private Toolbar toolbar;
    private EditText et_type;
    private EditText et_content;
    private Button btn_sync_notify;

    private Handler handler;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.acvity_notify);
        initView();
        initData();
        addListener();
    }

    void initView() {
        toolbar = findViewById(R.id.toolbar);
        et_type = findViewById(R.id.et_type);
        et_content = findViewById(R.id.et_content);
        btn_sync_notify = findViewById(R.id.btn_sync_notify);
    }

    void initData() {
        handler = new MyHandler();
    }

    void addListener() {
        toolbar.setNavigationOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                finish();
            }
        });
        btn_sync_notify.setOnClickListener(this);
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.btn_sync_notify:
                String typeStr = et_type.getText().toString();
                String content = et_content.getText().toString();

                if (null != typeStr && !typeStr.isEmpty()) {
                    if (null != content && !content.isEmpty()) {
                        int type = Integer.parseInt(typeStr);
                        NotifyType notifyType;
                        switch (type) {
                            case 0:
                                notifyType = NotifyType.QQ;
                                break;
                            case 1:
                                notifyType = NotifyType.WECHAT;
                                break;
                            case 2:
                                notifyType = NotifyType.SMS;
                                break;
                            case 3:
                                notifyType = NotifyType.LINE;
                                break;
                            case 4:
                                notifyType = NotifyType.TWITTER;
                                break;
                            case 5:
                                notifyType = NotifyType.FACEBOOK;
                                break;
                            case 6:
                                notifyType = NotifyType.MESSENGER;
                                break;
                            case 7:
                                notifyType = NotifyType.WHATSAPP;
                                break;
                            case 8:
                                notifyType = NotifyType.LINKEDIN;
                                break;
                            case 9:
                                notifyType = NotifyType.INSTAGRAM;
                                break;
                            case 10:
                                notifyType = NotifyType.SKYPE;
                                break;
                            case 11:
                                notifyType = NotifyType.VIBER;
                                break;
                            case 12:
                                notifyType = NotifyType.KAKAOTALK;
                                break;
                            case 13:
                                notifyType = NotifyType.VKONTAKTE;
                                break;
                            default:
                                notifyType = NotifyType.SMS;
                                break;
                        }
                        send_notify(notifyType, content);
                    } else {
                        showToast(getString(R.string.app_notify_hint_content));
                    }
                } else {
                    showToast(getString(R.string.app_notify_hint_type));
                }
                break;
        }
    }

    private void send_notify(final NotifyType type, final String content) {
        Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                if (WristbandManager.getInstance(NotifyActivity.this).sendOtherNotifyInfo(type, content)) {
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
