package com.wosmart.sdkdemo.util.v7_gt7d.action;

import android.os.Bundle;

import androidx.annotation.Nullable;

import com.wosmart.sdkdemo.App;
import com.wosmart.sdkdemo.common.BaseActivity;
import com.wosmart.ukprotocollibary.WristbandManager;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerFunctionPacket;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerTimerPacket;
import com.wosmart.ukprotocollibary.model.enums.DeviceFunctionStatus;
import com.wosmart.ukprotocollibary.model.enums.TimerOpt;

public class CountDownAction extends BaseActivity {

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
        boolean isSupport = functionPacket.getCountDown() == DeviceFunctionStatus.SUPPORT;

        new Thread(new Runnable() {
            @Override
            public void run() {
                // 查找设备
                ApplicationLayerTimerPacket packet = new ApplicationLayerTimerPacket();
                packet.setShow(true);// true 打开手表端倒计时功能，false 关闭
                packet.setSeconds(5);// 时间，单位 秒
                // TimerOpt.BEGIN 开始倒计时
                // TimerOpt.END  结束倒计时
                // TimerOpt.SETTING 仅设置倒计时
                packet.setOpt(TimerOpt.BEGIN);
                WristbandManager.getInstance(App.getInstance()).setTimerInfo(packet);
            }
        }).start();

    }



}
