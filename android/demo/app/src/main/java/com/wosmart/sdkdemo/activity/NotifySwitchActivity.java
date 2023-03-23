package com.wosmart.sdkdemo.activity;

import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import androidx.annotation.Nullable;
import androidx.appcompat.widget.Toolbar;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.CompoundButton;
import android.widget.Switch;

import com.wosmart.sdkdemo.common.BaseActivity;
import com.wosmart.sdkdemo.R;
import com.wosmart.ukprotocollibary.WristbandManager;
import com.wosmart.ukprotocollibary.WristbandManagerCallback;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerNotifyPacket;
import com.wosmart.ukprotocollibary.model.enums.NotifyType;

public class NotifySwitchActivity extends BaseActivity implements View.OnClickListener {
    private String tag = "NotifySwitchActivity";

    private Toolbar toolbar;

    private Button btn_read;

    private Switch sw_call;

    private Switch sw_QQ;

    private Switch sw_we_chat;

    private Switch sw_sms;

    private Switch sw_line;

    private Switch sw_twitter;

    private Switch sw_facebook;

    private Switch sw_messenger;

    private Switch sw_whatsApp;

    private Switch sw_linked_in;

    private Switch sw_instagram;

    private Switch sw_skype;

    private Switch sw_viber;

    private Switch sw_kakaotalk;

    private Switch sw_vkontakte;

    private Handler handler;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_notify_switch);
        initView();
        initData();
        addListener();
    }

    private void initView() {
        toolbar = findViewById(R.id.toolbar);
        btn_read = findViewById(R.id.btn_read);
        sw_call = findViewById(R.id.sw_call);
        sw_sms = findViewById(R.id.sw_sms);
        sw_we_chat = findViewById(R.id.sw_we_chat);
        sw_QQ = findViewById(R.id.sw_QQ);
        sw_messenger = findViewById(R.id.sw_messenger);
        sw_facebook = findViewById(R.id.sw_facebook);
        sw_twitter = findViewById(R.id.sw_twitter);
        sw_viber = findViewById(R.id.sw_viber);
        sw_linked_in = findViewById(R.id.sw_linked_in);
        sw_whatsApp = findViewById(R.id.sw_whatsApp);
        sw_line = findViewById(R.id.sw_line);
        sw_instagram = findViewById(R.id.sw_instagram);
        sw_kakaotalk = findViewById(R.id.sw_kakaotalk);
        sw_skype = findViewById(R.id.sw_skype);
        sw_vkontakte = findViewById(R.id.sw_vkontakte);
    }

    private void initData() {
        handler = new MyHandler();
        WristbandManager.getInstance(this).registerCallback(new WristbandManagerCallback() {

            @Override
            public void onNotifyModeSettingReceive(ApplicationLayerNotifyPacket applicationLayerNotifyPacket) {
                super.onNotifyModeSettingReceive(applicationLayerNotifyPacket);
                Log.i(tag, "reminderFunction = " + applicationLayerNotifyPacket.toString());
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
        sw_call.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                setNotifySwitch(NotifyType.CALL, isChecked);
            }
        });
        sw_QQ.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                setNotifySwitch(NotifyType.QQ, isChecked);
            }
        });
        sw_we_chat.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                setNotifySwitch(NotifyType.WECHAT, isChecked);
            }
        });
        sw_sms.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                setNotifySwitch(NotifyType.SMS, isChecked);
            }
        });
        sw_line.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                setNotifySwitch(NotifyType.LINE, isChecked);
            }
        });
        sw_twitter.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                setNotifySwitch(NotifyType.TWITTER, isChecked);
            }
        });
        sw_facebook.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                setNotifySwitch(NotifyType.FACEBOOK, isChecked);
            }
        });
        sw_messenger.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                setNotifySwitch(NotifyType.MESSENGER, isChecked);
            }
        });
        sw_whatsApp.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                setNotifySwitch(NotifyType.WHATSAPP, isChecked);
            }
        });
        sw_linked_in.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                setNotifySwitch(NotifyType.LINKEDIN, isChecked);
            }
        });
        sw_instagram.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                setNotifySwitch(NotifyType.INSTAGRAM, isChecked);
            }
        });
        sw_skype.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                setNotifySwitch(NotifyType.SKYPE, isChecked);
            }
        });
        sw_viber.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                setNotifySwitch(NotifyType.VIBER, isChecked);
            }
        });
        sw_kakaotalk.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                setNotifySwitch(NotifyType.KAKAOTALK, isChecked);
            }
        });
        sw_vkontakte.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                setNotifySwitch(NotifyType.VKONTAKTE, isChecked);
            }
        });
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.btn_read:
                readNotifySwitch();
                break;
        }
    }

    private void readNotifySwitch() {
        Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                if (WristbandManager.getInstance(NotifySwitchActivity.this).sendNotifyModeRequest()) {
                    handler.sendEmptyMessage(0x01);
                } else {
                    handler.sendEmptyMessage(0x02);
                }
            }
        });
        thread.start();
    }

    private void setNotifySwitch(final NotifyType type, final boolean isOpen) {
        Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                if (WristbandManager.getInstance(NotifySwitchActivity.this).setNotifyMode(type, isOpen)) {
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
