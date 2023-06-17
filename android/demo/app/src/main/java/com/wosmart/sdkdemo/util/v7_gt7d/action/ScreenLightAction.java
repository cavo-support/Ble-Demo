package com.wosmart.sdkdemo.util.v7_gt7d.action;

import android.os.Bundle;

import androidx.annotation.Nullable;

import com.wosmart.sdkdemo.App;
import com.wosmart.sdkdemo.common.BaseActivity;
import com.wosmart.ukprotocollibary.WristbandManager;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerFunctionPacket;
import com.wosmart.ukprotocollibary.model.enums.DeviceFunctionStatus;

public class ScreenLightAction extends BaseActivity {


    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        ApplicationLayerFunctionPacket functionPacket = WristbandManager.getInstance(App.getInstance()).getFunctionPacket();
        if (functionPacket == null) {
            // 如果功能列表为空，必须先获取一次功能列表，然后用户可自行缓存该功能列表也可使用 SDK 缓存
            WristbandManager.getInstance(App.getInstance()).sendFunctionReq();
            return;
        }
        // 判断是否支持该功能
        boolean isSupport = functionPacket.getLightControl() == DeviceFunctionStatus.SUPPORT;

        new Thread(new Runnable() {
            @Override
            public void run() {
                // 设置亮屏时间，20 - 100，单位 亮度百分比
                WristbandManager.getInstance(App.getInstance()).settingScreenLight(50);
            }
        }).start();
    }


}
