package com.wosmart.sdkdemo.util.v7_gt7d.action;

import android.os.Bundle;

import androidx.annotation.Nullable;

import com.wosmart.sdkdemo.App;
import com.wosmart.sdkdemo.common.BaseActivity;
import com.wosmart.ukprotocollibary.WristbandManager;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerUserPacket;

public class SetUserInfoAction extends BaseActivity {

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        new Thread(new Runnable() {
            @Override
            public void run() {
                // 男，25 岁，高 170，体重 65.5 kg
                ApplicationLayerUserPacket userPacket = new ApplicationLayerUserPacket(true, 25, 170D, 65.5D);
                WristbandManager.getInstance(App.getInstance()).setUserProfile(userPacket);
            }
        }).start();
    }
}
