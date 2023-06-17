package com.wosmart.sdkdemo.util.v7_gt7d.action;

import android.os.Bundle;

import androidx.annotation.Nullable;

import com.wosmart.sdkdemo.App;
import com.wosmart.sdkdemo.common.BaseActivity;
import com.wosmart.sdkdemo.util.v7_gt7d.Utils;
import com.wosmart.ukprotocollibary.WristbandManager;
import com.wosmart.ukprotocollibary.WristbandManagerCallback;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerFunctionPacket;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerReadHealthPacket;
import com.wosmart.ukprotocollibary.model.db.JWHealthDataManager;
import com.wosmart.ukprotocollibary.model.enums.DeviceFunctionStatus;
import com.wosmart.ukprotocollibary.v2.JWHealthDataSearchParams;
import com.wosmart.ukprotocollibary.v2.JWValueCallback;
import com.wosmart.ukprotocollibary.v2.entity.JWTemperatureInfo;

import java.util.List;

public class TemperatureAction extends BaseActivity {


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
        boolean isSupport = functionPacket.getTemperature() == DeviceFunctionStatus.SUPPORT;

        WristbandManager.getInstance(App.getInstance()).registerCallback(new WristbandManagerCallback() {

            @Override
            public void onReadHealthDataPacket(ApplicationLayerReadHealthPacket readHealthPacket) {
                super.onReadHealthDataPacket(readHealthPacket);
                if (Utils.checkHealthStatus(readHealthPacket)) {
                    return;
                }
                if (Utils.checkPowerStatus()) {
                    return;
                }
                if (Utils.isSyncHealthData()) {
                    return;
                }
                // 设备空闲，电量充足，当前不在同步数据，即可开始测量
                startMeasure();
            }
        });

        // 所有功能的点测模式开始前建议判断设备当前是否正忙和电量状态
        readHealth();
    }

    private void readHealth() {
        new Thread(new Runnable() {
            @Override
            public void run() {
                WristbandManager.getInstance(App.getInstance()).readHealth();
            }
        }).start();
    }

    private void startMeasure() {
        new Thread(new Runnable() {
            @Override
            public void run() {
                // 开关温度测量 true 开 false 关
                WristbandManager.getInstance(App.getInstance()).setTemperatureStatus(true);
            }
        }).start();
    }

    private void getHistoryTemperatureList() {
        // 可从 SDK 数据库中获取指定时间数据，同步完成后数据为最完整状态

        // 指定日期
        JWHealthDataManager.getInstance().getHistoryTemperatureListByDate(2023, 6, 16, new JWValueCallback<List<JWTemperatureInfo>>() {
            @Override
            public void onSuccess(List<JWTemperatureInfo> data) {

            }

            @Override
            public void onError(int code, String desc) {

            }
        });

        // 指定条件
        // for example, if you want get data at 2022-03-04 07:00 - 2022-03-04 08:00
        // params.timeBegin = 1646348400000
        // params.timePeriod = 3600s * 1000
        JWHealthDataSearchParams searchParams = new JWHealthDataSearchParams();
        searchParams.setUserID("");
        searchParams.setTimeBegin(1646348400000L);
        searchParams.setTimePeriod(3600000);
        JWHealthDataManager.getInstance().getHistoryTemperatureList(searchParams, new JWValueCallback<List<JWTemperatureInfo>>() {
            @Override
            public void onSuccess(List<JWTemperatureInfo> data) {

            }

            @Override
            public void onError(int code, String desc) {

            }
        });
    }


}
