package com.wosmart.sdkdemo.util.v7_gt7d.action;

import android.os.Bundle;

import androidx.annotation.Nullable;

import com.wosmart.sdkdemo.App;
import com.wosmart.sdkdemo.common.BaseActivity;
import com.wosmart.sdkdemo.util.v7_gt7d.utils.Utils;
import com.wosmart.ukprotocollibary.WristbandManager;
import com.wosmart.ukprotocollibary.WristbandManagerCallback;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerFunctionPacket;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerReadHealthPacket;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerSpo2Packet;
import com.wosmart.ukprotocollibary.model.db.JWHealthDataManager;
import com.wosmart.ukprotocollibary.model.enums.DeviceFunctionStatus;
import com.wosmart.ukprotocollibary.v2.JWHealthDataSearchParams;
import com.wosmart.ukprotocollibary.v2.JWValueCallback;
import com.wosmart.ukprotocollibary.v2.entity.JWSpO2Info;

import java.util.List;

public class SpO2Action extends BaseActivity {


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
        boolean isSupport = functionPacket.getSpo2Measure() == DeviceFunctionStatus.SUPPORT;

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
                // 设备空闲，电量充足，当前不在同步数据，再检查一次状态
                checkSpO2Status();
            }

            @Override
            public void onSpo2MeasureStatus(int status) {
                super.onSpo2MeasureStatus(status);
                // 0 血氧测试关闭返回
                // 1 血氧测试开启返回
                // 2 设备正忙，血氧测试不可以开启
                // 3 血氧测试可以开启
                if (status == 3) {
                    // 设备状态正常，可以开启测量
                    startMeasure();
                }
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

    private void checkSpO2Status() {
        new Thread(new Runnable() {
            @Override
            public void run() {
                WristbandManager.getInstance(App.getInstance()).checkSpo2Status();
            }
        }).start();
    }

    private void startMeasure() {
        WristbandManager.getInstance(App.getInstance()).registerCallback(new WristbandManagerCallback() {

            @Override
            public void onSpo2DataReceive(ApplicationLayerSpo2Packet packet) {
                super.onSpo2DataReceive(packet);
                // 血氧数据返回
            }
        });
        new Thread(new Runnable() {
            @Override
            public void run() {
                // 开关测量 true 开 false 关
                WristbandManager.getInstance(App.getInstance()).setSpo2Status(true);
            }
        }).start();
    }

    /**
     * 读取自动监测配置
     */
    private void readAutoMeasureConfig() {
        WristbandManager.getInstance(App.getInstance()).registerCallback(new WristbandManagerCallback() {

            @Override
            public void requestSpo2Continuous(boolean enable, int interval) {
                super.requestSpo2Continuous(enable, interval);
                // 自动监测配置返回
                // enable true 打开，interval 间隔 单位 分钟
            }
        });
        new Thread(new Runnable() {
            @Override
            public void run() {
                // 请求自动监测配置
                WristbandManager.getInstance(App.getInstance()).requestSpo2Continuous();
            }
        }).start();
    }

    /**
     * 自动监测
     */
    private void autoMeasure() {
        // 自动测量不会实时返回数据，需进行同步后获取
        new Thread(new Runnable() {
            @Override
            public void run() {
                // 自动测量
                // enable true 打开，interval 间隔 单位 分钟
                WristbandManager.getInstance(App.getInstance()).setSpo2Continuous(true, 5);
            }
        }).start();
    }

    private void getHistorySpO2List() {
        // 可从 SDK 数据库中获取指定时间数据，同步完成后数据为最完整状态

        // 指定日期
        JWHealthDataManager.getInstance().getHistorySpO2ListByDate(2023, 6, 16, new JWValueCallback<List<JWSpO2Info>>() {
            @Override
            public void onSuccess(List<JWSpO2Info> data) {

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
        JWHealthDataManager.getInstance().getHistorySpO2List(searchParams, new JWValueCallback<List<JWSpO2Info>>() {
            @Override
            public void onSuccess(List<JWSpO2Info> data) {

            }

            @Override
            public void onError(int code, String desc) {

            }
        });
    }


}
