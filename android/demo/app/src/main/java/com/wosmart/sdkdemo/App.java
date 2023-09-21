package com.wosmart.sdkdemo;

import android.app.Application;
import android.util.Log;

import com.realsil.sdk.core.RtkConfigure;
import com.realsil.sdk.core.RtkCore;
import com.realsil.sdk.dfu.RtkDfu;
import com.wosmart.ukprotocollibary.WristbandManager;
import com.wosmart.ukprotocollibary.WristbandManagerCallback;

public class App extends Application {

    private static App sInstance;

    public static App getInstance() {
        return sInstance;
    }

    private String deviceMac;

    /**
     * 设备芯片类型 0:C(正常芯片) 1:D(VD版本)
     */
    private int deviceChipType = 0;

    @Override
    public void onCreate() {
        super.onCreate();

        sInstance = this;
        //init rtk OTA
        RtkConfigure configure = new RtkConfigure.Builder()
                .debugEnabled(true)
                .printLog(true)
                .logTag("OTA")
                .globalLogLevel(1)
                .build();
        RtkCore.initialize(this, configure);
        RtkDfu.initialize(this, true);

        WristbandManager.getInstance().initSDK(this);

        WristbandManager.getInstance().registerCallback(new WristbandManagerCallback() {

            @Override
            public void onBondReqChipType(int type) {
                super.onBondReqChipType(type);
                // 在登录成功后会触发此回调，用户需自行记录设备芯片类型
                // 若没有触发此回调，则是默认芯片类型 0
                // This callback will be triggered after successful login. The user needs to record the device chip type by himself.
                // If this callback is not triggered, the default chip type is 0
                deviceChipType = type;
                Log.e("SSSS", "deviceChipType = " + deviceChipType);
            }

        });
    }

    public int getDeviceChipType() {
        return deviceChipType;
    }

    public String getDeviceMac() {
        return deviceMac;
    }

    public void setDeviceMac(String deviceMac) {
        this.deviceMac = deviceMac;
    }
}
