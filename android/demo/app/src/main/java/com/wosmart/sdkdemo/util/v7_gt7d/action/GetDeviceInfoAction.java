package com.wosmart.sdkdemo.util.v7_gt7d.action;

import android.os.Bundle;

import androidx.annotation.Nullable;

import com.wosmart.sdkdemo.App;
import com.wosmart.sdkdemo.common.BaseActivity;
import com.wosmart.ukprotocollibary.WristbandManager;
import com.wosmart.ukprotocollibary.WristbandManagerCallback;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerDeviceInfoPacket;

public class GetDeviceInfoAction extends BaseActivity {

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);


        WristbandManager.getInstance().registerCallback(new WristbandManagerCallback() {

            @Override
            public void onDeviceInfo(ApplicationLayerDeviceInfoPacket packet) {
                super.onDeviceInfo(packet);

                // 设备信息返回
            }

        });

        // 请求设备信息
        new Thread(new Runnable() {
            @Override
            public void run() {
                WristbandManager.getInstance().requestDeviceInfo();
            }
        }).start();
    }
}
