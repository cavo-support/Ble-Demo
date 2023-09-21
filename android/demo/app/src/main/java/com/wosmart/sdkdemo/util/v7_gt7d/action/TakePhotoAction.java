package com.wosmart.sdkdemo.util.v7_gt7d.action;

import android.os.Bundle;

import androidx.annotation.Nullable;

import com.wosmart.sdkdemo.App;
import com.wosmart.sdkdemo.common.BaseActivity;
import com.wosmart.ukprotocollibary.WristbandManager;
import com.wosmart.ukprotocollibary.WristbandManagerCallback;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerFunctionPacket;
import com.wosmart.ukprotocollibary.model.enums.DeviceFunctionStatus;

public class TakePhotoAction extends BaseActivity {


    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        ApplicationLayerFunctionPacket functionPacket = WristbandManager.getInstance().getFunctionPacket();
        if (functionPacket == null) {
            // 如果功能列表为空，必须先获取一次功能列表，然后用户可自行缓存该功能列表也可使用 SDK 缓存
            WristbandManager.getInstance().sendFunctionReq();
            return;
        }
        // 判断是否支持该功能
        boolean isSupport = functionPacket.getCameraControl() == DeviceFunctionStatus.SUPPORT;

        WristbandManager.getInstance().registerCallback(new WristbandManagerCallback() {

            @Override
            public void onTakePhotoRsp() {
                super.onTakePhotoRsp();
                // 收到转腕拍照请求
            }
        });
        new Thread(new Runnable() {
            @Override
            public void run() {
                // 打开转腕拍照功能
                WristbandManager.getInstance().sendCameraControlCommand(true);
            }
        }).start();
    }
}
