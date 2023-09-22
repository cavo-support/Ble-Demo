package com.wosmart.sdkdemo;

import android.app.Application;
import android.util.Log;

import com.realsil.sdk.core.RtkConfigure;
import com.realsil.sdk.core.RtkCore;
import com.realsil.sdk.dfu.RtkDfu;
import com.wosmart.ukprotocollibary.WristbandManager;
import com.wosmart.ukprotocollibary.WristbandManagerCallback;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerTodaySumSportPacket;
import com.wosmart.ukprotocollibary.model.db.GlobalGreenDAO;
import com.wosmart.ukprotocollibary.model.db.JWHealthDataManager;
import com.wosmart.ukprotocollibary.v2.JWValueCallback;
import com.wosmart.ukprotocollibary.v2.entity.JWSaunaInfo;

import java.util.Calendar;
import java.util.List;

public class App extends Application {

    private static final String TAG = "App";

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

            @Override
            public void onSyncDataEnd(ApplicationLayerTodaySumSportPacket packet) {
                super.onSyncDataEnd(packet);
            }

            @Override
            public void onSyncSaunaDataStart(int totalCount) {
                super.onSyncSaunaDataStart(totalCount);
                // sync sauna data started, it will be trigger after sync health data[onSyncDataEnd]
                Log.e(TAG, "onSyncSaunaDataStart");
            }

            @Override
            public void onSyncSaunaDataReceived(List<JWSaunaInfo> saunaInfoList) {
                super.onSyncSaunaDataReceived(saunaInfoList);
                // sync pulse data received, you can save it by yourself
                Log.e(TAG, "onSyncSaunaDataReceived, dataList = " + (saunaInfoList != null ? saunaInfoList.toString() : ""));
            }

            @Override
            public void onSyncSaunaDataFinished() {
                super.onSyncSaunaDataFinished();
                // sync sauna data finished
                Log.e(TAG, "onSyncSaunaDataFinished");
                Calendar calendar = Calendar.getInstance();
                int year = calendar.get(Calendar.YEAR);
                int month = calendar.get(Calendar.MONTH) + 1;
                int day = calendar.get(Calendar.DAY_OF_MONTH);

                // after sync sauna data, you can get special sauna data by date from SDK database
                List<JWSaunaInfo> saunaInfoList = GlobalGreenDAO.getInstance().loadSaunaDataByDate(year, month, day);
                if (saunaInfoList != null) {
                    Log.e(TAG, "onSyncSaunaDataFinished, local dataList = " + saunaInfoList.toString());
                }

                // or user this method to get sauna data, it's 2.0 api
                JWHealthDataManager.getInstance().getHistorySaunaListByDate(year, month, day, new JWValueCallback<List<JWSaunaInfo>>() {
                    @Override
                    public void onSuccess(List<JWSaunaInfo> data) {

                    }

                    @Override
                    public void onError(int code, String desc) {

                    }
                });
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
