package com.wosmart.sdkdemo.activity;

import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.support.annotation.Nullable;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.View;

import com.wosmart.sdkdemo.common.BaseActivity;
import com.wosmart.sdkdemo.R;
import com.wosmart.ukprotocollibary.WristbandManager;
import com.wosmart.ukprotocollibary.WristbandManagerCallback;

public class FindPhoneActivity extends BaseActivity implements View.OnClickListener {

    private String tag = "FindPhoneActivity";

    private Toolbar toolbar;

    private Handler handler;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_find_phone);
        initView();
        initData();
        addListener();
    }

    private void initView() {
        toolbar = findViewById(R.id.toolbar);
    }

    private void initData() {
        handler = new MyHandler();
        WristbandManager.getInstance(this).registerCallback(new WristbandManagerCallback() {
            @Override
            public void onFindPhone() {
                super.onFindPhone();
                Log.i(tag, getString(R.string.app_find_phone));
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
                    break;
                case 0x02:
                    showToast(getString(R.string.app_fail));
                    break;
            }
        }
    }

}
