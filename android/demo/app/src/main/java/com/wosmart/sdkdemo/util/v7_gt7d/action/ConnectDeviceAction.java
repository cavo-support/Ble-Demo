package com.wosmart.sdkdemo.util.v7_gt7d.action;

import android.content.Intent;
import android.os.Bundle;

import androidx.annotation.Nullable;

import com.wosmart.sdkdemo.R;
import com.wosmart.sdkdemo.activity.ScanActivity;
import com.wosmart.sdkdemo.common.BaseActivity;
import com.wosmart.ukprotocollibary.WristbandManager;
import com.wosmart.ukprotocollibary.WristbandManagerCallback;

public class ConnectDeviceAction extends BaseActivity {


    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

    }

    private void connectDevice(String macAddress) {
        WristbandManager.getInstance(this).registerCallback(new WristbandManagerCallback() {
            @Override
            public void onConnectionStateChange(boolean result) {
                super.onConnectionStateChange(result);

            }

            @Override
            public void onError(int error) {
                super.onError(error);
            }
        });

        WristbandManager.getInstance(this).connect(macAddress);
    }

}
