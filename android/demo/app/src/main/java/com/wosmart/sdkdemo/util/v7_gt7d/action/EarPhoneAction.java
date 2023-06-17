package com.wosmart.sdkdemo.util.v7_gt7d.action;

import android.os.Bundle;

import androidx.annotation.Nullable;

import com.wosmart.sdkdemo.App;
import com.wosmart.sdkdemo.common.BaseActivity;
import com.wosmart.ukprotocollibary.WristbandManager;
import com.wosmart.ukprotocollibary.WristbandManagerCallback;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerEarMacPacket;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerEarStatusPacket;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerFunctionPacket;
import com.wosmart.ukprotocollibary.model.enums.DeviceFunctionStatus;

public class EarPhoneAction extends BaseActivity {


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
        boolean isSupport = functionPacket.getEarPhone() == DeviceFunctionStatus.SUPPORT;


        WristbandManager.getInstance(App.getInstance()).registerCallback(new WristbandManagerCallback() {

            @Override
            public void onEarMac(ApplicationLayerEarMacPacket packet) {
                super.onEarMac(packet);
                // 音频蓝牙信息返回
            }

            @Override
            public void onEarConnectStatus(int status) {
                super.onEarConnectStatus(status);
                // 音频蓝牙连接状态回调
            }

            @Override
            public void onEarStatus(ApplicationLayerEarStatusPacket packet) {
                super.onEarStatus(packet);
                // 音频蓝牙配对状态及连接状态回调，在连接完设备后触发，设备音频蓝牙状态变更也会触发
            }

        });

        // 如未缓存到音频蓝牙地址，可再请求获取
        new Thread(new Runnable() {
            @Override
            public void run() {
                // 请求音频蓝牙地址, onEarMac 返回信息
                WristbandManager.getInstance(App.getInstance()).requestClassicAddress();
            }
        }).start();


        // 音频蓝牙为经典蓝牙，需用户自行连接，SDK 暂不提供支持
    }
}
