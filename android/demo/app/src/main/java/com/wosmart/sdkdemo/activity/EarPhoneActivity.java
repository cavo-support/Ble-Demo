package com.wosmart.sdkdemo.activity;

import android.bluetooth.BluetoothA2dp;
import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.bluetooth.BluetoothHeadset;
import android.bluetooth.BluetoothManager;
import android.bluetooth.BluetoothProfile;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.support.annotation.Nullable;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.View;
import android.widget.Button;

import com.wosmart.sdkdemo.common.BaseActivity;
import com.wosmart.sdkdemo.R;
import com.wosmart.sdkdemo.util.ClsUtils;
import com.wosmart.ukprotocollibary.WristbandManager;
import com.wosmart.ukprotocollibary.WristbandManagerCallback;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerEarMacPacket;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerEarStatusPacket;

import java.lang.reflect.InvocationTargetException;

public class EarPhoneActivity extends BaseActivity implements View.OnClickListener {
    private String tag = "LoginActivity";

    private Toolbar toolbar;

    private Button btn_read_address;

    private Button btn_read_status;

    private Handler handler;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_ear_phone);
        initView();
        initData();
        addListener();
    }

    private void initView() {
        toolbar = findViewById(R.id.toolbar);
        btn_read_address = findViewById(R.id.btn_read_address);
        btn_read_status = findViewById(R.id.btn_read_status);
    }

    private void initData() {
        handler = new MyHandler();
        WristbandManager.getInstance(this).registerCallback(new WristbandManagerCallback() {
            @Override
            public void onEarMac(ApplicationLayerEarMacPacket packet) {
                super.onEarMac(packet);
                Log.i(tag, "ear mac = " + packet.toString());
            }

            @Override
            public void onEarStatus(ApplicationLayerEarStatusPacket packet) {
                super.onEarStatus(packet);
                Log.i(tag, "ear status = " + packet.toString());
            }

            @Override
            public void onEarConnectStatus(int status) {
                super.onEarConnectStatus(status);
                Log.i(tag, "ear connect status = " + status);

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
        btn_read_address.setOnClickListener(this);
        btn_read_status.setOnClickListener(this);
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.btn_read_address:
                requestAddress();
                break;
            case R.id.btn_read_status:
                readStatus();
                break;
        }
    }


    public void readStatus() {
        Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                if (WristbandManager.getInstance(EarPhoneActivity.this).requestClassicStatus()) {
                    handler.sendEmptyMessage(0x01);
                } else {
                    handler.sendEmptyMessage(0x02);
                }
            }
        });
        thread.start();
    }


    private synchronized void requestAddress() {
        Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                if (WristbandManager.getInstance(EarPhoneActivity.this).requestClassicAddress()) {
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
