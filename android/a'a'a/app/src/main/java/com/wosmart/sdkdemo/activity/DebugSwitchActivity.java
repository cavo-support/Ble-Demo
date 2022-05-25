package com.wosmart.sdkdemo.activity;

import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.support.annotation.Nullable;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.CompoundButton;
import android.widget.Switch;
import android.widget.TextView;

import com.wosmart.sdkdemo.R;
import com.wosmart.sdkdemo.common.BaseActivity;
import com.wosmart.ukprotocollibary.WristbandManager;
import com.wosmart.ukprotocollibary.WristbandManagerCallback;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerEarMacPacket;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerEarStatusPacket;
import com.wosmart.ukprotocollibary.util.DataConverter;

import java.util.Arrays;
import java.util.logging.Logger;

public class DebugSwitchActivity extends BaseActivity implements View.OnClickListener {
    private String tag = "DebugSwitchActivity";

    private Toolbar toolbar;
    private Handler handler;
    private Switch st_debug;
    private TextView tv_show_debug1;
    private TextView tv_show_debug2;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_debug_switch);
        initView();
        initData();
        addListener();
    }

    private void initView() {
        toolbar = findViewById(R.id.toolbar);
        st_debug = findViewById(R.id.st_debug);
        tv_show_debug1 = findViewById(R.id.tv_show_debug1);
        tv_show_debug2 = findViewById(R.id.tv_show_debug2);
    }

    private void initData() {
        handler = new MyHandler();
    }

    private void addListener() {
        toolbar.setNavigationOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                finish();
            }
        });
        st_debug.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton compoundButton, boolean b) {
                if(b){
//                    Log.d(tag,"switch="+b);
                    handler.sendEmptyMessage(0x01);

                }else{
//                    Log.d(tag,"switch="+b);
                    handler.sendEmptyMessage(0x02);
                }
            }
        });
    }

    private void setText(byte[] data){
//        tv_show_debug1.setText(Arrays.toString(data));
        tv_show_debug2.setText(DataConverter.bytes2Hex(data));
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {

        }
    }

    private class MyHandler extends Handler {
        @Override
        public void handleMessage(Message msg) {
            super.handleMessage(msg);
            switch (msg.what) {
                case 0x01:
                    showToast(getString(R.string.app_success));
                    WristbandManager.getInstance(DebugSwitchActivity.this).setDebugNotify(true);
                    WristbandManager.getInstance(DebugSwitchActivity.this).registerCallback(new WristbandManagerCallback(){
                        @Override
                        public void onDebugDataReceiver(byte[] data) {
                            setText(data);
                        }
                    });
                    break;
                case 0x02:
                    WristbandManager.getInstance(DebugSwitchActivity.this).setDebugNotify(false);
                    tv_show_debug1.setText("");
                    tv_show_debug2.setText("");
                    break;
            }
        }
    }

}
