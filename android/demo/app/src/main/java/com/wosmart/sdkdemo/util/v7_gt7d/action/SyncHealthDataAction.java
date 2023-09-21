package com.wosmart.sdkdemo.util.v7_gt7d.action;

import android.os.Bundle;

import androidx.annotation.Nullable;

import com.wosmart.sdkdemo.App;
import com.wosmart.sdkdemo.common.BaseActivity;
import com.wosmart.sdkdemo.util.v7_gt7d.utils.Utils;
import com.wosmart.ukprotocollibary.WristbandManager;
import com.wosmart.ukprotocollibary.WristbandManagerCallback;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerBeginPacket;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerBpListPacket;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerBpPacket;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerGLUPacket;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerHrpPacket;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerRateListPacket;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerRtkHrvPacket;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerSleepPacket;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerSpo2Packet;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerSportPacket;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerStepPacket;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerTodaySumSportPacket;
import com.wosmart.ukprotocollibary.model.db.JWHealthDataManager;
import com.wosmart.ukprotocollibary.v2.JWValueCallback;
import com.wosmart.ukprotocollibary.v2.entity.JWBloodPressureInfo;
import com.wosmart.ukprotocollibary.v2.entity.JWBloodSugarInfo;
import com.wosmart.ukprotocollibary.v2.entity.JWHeartRateInfo;
import com.wosmart.ukprotocollibary.v2.entity.JWHeartRateVariabilityInfo;
import com.wosmart.ukprotocollibary.v2.entity.JWSleepInfo;
import com.wosmart.ukprotocollibary.v2.entity.JWSpO2Info;
import com.wosmart.ukprotocollibary.v2.entity.JWSportInfo;
import com.wosmart.ukprotocollibary.v2.entity.JWStepInfo;
import com.wosmart.ukprotocollibary.v2.entity.JWTemperatureInfo;

import java.util.List;

public class SyncHealthDataAction extends BaseActivity {


    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        WristbandManager.getInstance().registerCallback(new WristbandManagerCallback() {

            @Override
            public void onSyncDataBegin(ApplicationLayerBeginPacket packet) {
                super.onSyncDataBegin(packet);
                // 同步开始
                Utils.isSyncHealthData = true;// 同步过程中尽量不要启动其它功能
            }

            @Override
            public void onSyncDataEnd(ApplicationLayerTodaySumSportPacket packet) {
                super.onSyncDataEnd(packet);
                // 同步结束
                Utils.isSyncHealthData = false;
                // 同步结束后，可从 SDK 数据库中获取各部分数据
                getHealthDataList();
            }

            @Override
            public void onStepDataReceiveIndication(ApplicationLayerStepPacket packet) {
                super.onStepDataReceiveIndication(packet);
                // 步数
            }

            @Override
            public void onSportDataReceiveIndication(ApplicationLayerSportPacket packet) {
                super.onSportDataReceiveIndication(packet);
                // 运动
            }

            @Override
            public void onSleepDataReceiveIndication(ApplicationLayerSleepPacket packet) {
                super.onSleepDataReceiveIndication(packet);
                // 睡眠
            }

            @Override
            public void onHrpDataReceiveIndication(ApplicationLayerHrpPacket packet) {
                super.onHrpDataReceiveIndication(packet);
                // 心率
            }

            @Override
            public void onBpDataReceiveIndication(ApplicationLayerBpPacket packet) {
                super.onBpDataReceiveIndication(packet);
                // 血压
            }

            @Override
            public void onRateList(ApplicationLayerRateListPacket packet) {
                super.onRateList(packet);
                // 批量心率
            }

            @Override
            public void onTemperatureData(ApplicationLayerHrpPacket packet) {
                super.onTemperatureData(packet);
                // 温度
            }

            @Override
            public void onTemperatureList(ApplicationLayerRateListPacket packet) {
                super.onTemperatureList(packet);
                // 批量温度
            }

            @Override
            public void onBpList(ApplicationLayerBpListPacket packet) {
                super.onBpList(packet);
                // 批量血压
            }

            @Override
            public void onSpo2DataReceive(ApplicationLayerSpo2Packet packet) {
                super.onSpo2DataReceive(packet);
                // 血氧
            }

            @Override
            public void onRtkHrvDataRsp(ApplicationLayerRtkHrvPacket rtkHrvPacket) {
                super.onRtkHrvDataRsp(rtkHrvPacket);
                // 心率变异性
            }

            @Override
            public void onGluDataRes(ApplicationLayerGLUPacket gluPacket) {
                super.onGluDataRes(gluPacket);
                // 血糖
            }
        });

        new Thread(new Runnable() {
            @Override
            public void run() {
                // 请求同步健康数据
                WristbandManager.getInstance().sendDataRequest();
            }
        }).start();
    }

    private void getHealthDataList() {
        int year = 2023;
        int month = 6;
        int day = 17;

        // 获取步数
        JWHealthDataManager.getInstance().getHistoryStepListByDate(year, month, day, new JWValueCallback<List<JWStepInfo>>() {
            @Override
            public void onSuccess(List<JWStepInfo> data) {

            }

            @Override
            public void onError(int code, String desc) {

            }
        });

        // 获取睡眠
        JWHealthDataManager.getInstance().getHistorySleepListByDate(year, month, day, new JWValueCallback<List<JWSleepInfo>>() {
            @Override
            public void onSuccess(List<JWSleepInfo> data) {

            }

            @Override
            public void onError(int code, String desc) {

            }
        });

        // 获取温度
        JWHealthDataManager.getInstance().getHistoryTemperatureListByDate(year, month, day, new JWValueCallback<List<JWTemperatureInfo>>() {
            @Override
            public void onSuccess(List<JWTemperatureInfo> data) {

            }

            @Override
            public void onError(int code, String desc) {

            }
        });

        // 获取运动
        JWHealthDataManager.getInstance().getHistorySportListByDate(year, month, day, new JWValueCallback<List<JWSportInfo>>() {
            @Override
            public void onSuccess(List<JWSportInfo> data) {

            }

            @Override
            public void onError(int code, String desc) {

            }
        });

        // 获取血压
        JWHealthDataManager.getInstance().getHistoryBloodPressureListByDate(year, month, day, new JWValueCallback<List<JWBloodPressureInfo>>() {
            @Override
            public void onSuccess(List<JWBloodPressureInfo> data) {

            }

            @Override
            public void onError(int code, String desc) {

            }
        });

        // 获取血糖
        JWHealthDataManager.getInstance().getHistoryBloodSugarListByDate(year, month, day, new JWValueCallback<List<JWBloodSugarInfo>>() {
            @Override
            public void onSuccess(List<JWBloodSugarInfo> data) {

            }

            @Override
            public void onError(int code, String desc) {

            }
        });

        // 获取心率
        JWHealthDataManager.getInstance().getHistoryHeartRateListByDate(year, month, day, new JWValueCallback<List<JWHeartRateInfo>>() {
            @Override
            public void onSuccess(List<JWHeartRateInfo> data) {

            }

            @Override
            public void onError(int code, String desc) {

            }
        });

        // 获取心率变异性
        JWHealthDataManager.getInstance().getHistoryHeartRateVariabilityListByDate(year, month, day, new JWValueCallback<List<JWHeartRateVariabilityInfo>>() {
            @Override
            public void onSuccess(List<JWHeartRateVariabilityInfo> data) {

            }

            @Override
            public void onError(int code, String desc) {

            }
        });

        // 获取血氧
        JWHealthDataManager.getInstance().getHistorySpO2ListByDate(year, month, day, new JWValueCallback<List<JWSpO2Info>>() {
            @Override
            public void onSuccess(List<JWSpO2Info> data) {

            }

            @Override
            public void onError(int code, String desc) {

            }
        });
    }

}

