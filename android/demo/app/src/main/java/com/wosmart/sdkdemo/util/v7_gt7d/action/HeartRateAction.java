package com.wosmart.sdkdemo.util.v7_gt7d.action;

import android.os.Bundle;

import androidx.annotation.Nullable;

import com.wosmart.sdkdemo.App;
import com.wosmart.sdkdemo.common.BaseActivity;
import com.wosmart.sdkdemo.util.v7_gt7d.utils.Utils;
import com.wosmart.ukprotocollibary.WristbandManager;
import com.wosmart.ukprotocollibary.WristbandManagerCallback;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerFunctionPacket;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerHrpPacket;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerReadHealthPacket;
import com.wosmart.ukprotocollibary.model.db.JWHealthDataManager;
import com.wosmart.ukprotocollibary.model.enums.DeviceFunctionStatus;
import com.wosmart.ukprotocollibary.v2.JWHealthDataSearchParams;
import com.wosmart.ukprotocollibary.v2.JWValueCallback;
import com.wosmart.ukprotocollibary.v2.entity.JWHeartRateInfo;

import java.util.List;

public class HeartRateAction extends BaseActivity {


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
        boolean isSupport = functionPacket.getRate() == DeviceFunctionStatus.SUPPORT;

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
                // 设备空闲，电量充足，当前不在同步数据，可以开启测量
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
        WristbandManager.getInstance(App.getInstance()).registerCallback(new WristbandManagerCallback() {

            @Override
            public void onHrpDataReceiveIndication(ApplicationLayerHrpPacket packet) {
                super.onHrpDataReceiveIndication(packet);
                // 心率测量返回
            }
        });
        new Thread(new Runnable() {
            @Override
            public void run() {
                // 开启心率测量
                WristbandManager.getInstance(App.getInstance()).readHrpValue();
                // 结束心率测量
                WristbandManager.getInstance(App.getInstance()).stopReadHrpValue();
            }
        }).start();
    }

    /**
     * 读取自动监测配置
     */
    private void readAutoMeasureConfig() {
        WristbandManager.getInstance(App.getInstance()).registerCallback(new WristbandManagerCallback() {

            @Override
            public void onHrpContinueParamRsp(boolean enable, int interval) {
                super.onHrpContinueParamRsp(enable, interval);
                // 自动监测配置返回
                // enable true 打开，interval 间隔 单位 分钟
            }
        });
        new Thread(new Runnable() {
            @Override
            public void run() {
                // 请求自动监测配置
                WristbandManager.getInstance(App.getInstance()).sendContinueHrpParamRequest();
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
                WristbandManager.getInstance(App.getInstance()).setContinueHrp(true, 5);
            }
        }).start();
    }

    private void getHistoryHeartRateList() {
        // 可从 SDK 数据库中获取指定时间数据，同步完成后数据为最完整状态

        // 指定日期
        JWHealthDataManager.getInstance().getHistoryHeartRateListByDate(2023, 6, 16, new JWValueCallback<List<JWHeartRateInfo>>() {
            @Override
            public void onSuccess(List<JWHeartRateInfo> data) {

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
        JWHealthDataManager.getInstance().getHistoryHeartRateList(searchParams, new JWValueCallback<List<JWHeartRateInfo>>() {
            @Override
            public void onSuccess(List<JWHeartRateInfo> data) {

            }

            @Override
            public void onError(int code, String desc) {

            }
        });
    }




}
