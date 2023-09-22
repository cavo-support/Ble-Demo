package com.wosmart.sdkdemo.activity;

import android.os.Bundle;
import android.util.Log;
import android.view.View;

import androidx.annotation.Nullable;
import androidx.appcompat.widget.Toolbar;

import com.wosmart.sdkdemo.R;
import com.wosmart.sdkdemo.common.BaseActivity;
import com.wosmart.ukprotocollibary.WristbandManager;
import com.wosmart.ukprotocollibary.WristbandManagerCallback;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerFunctionPacket;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerRateListPacket;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerTodaySumSportPacket;
import com.wosmart.ukprotocollibary.model.db.GlobalGreenDAO;
import com.wosmart.ukprotocollibary.model.db.JWHealthDataManager;
import com.wosmart.ukprotocollibary.model.enums.DeviceFunctionStatus;
import com.wosmart.ukprotocollibary.v2.JWValueCallback;
import com.wosmart.ukprotocollibary.v2.entity.JWSaunaInfo;

import java.util.Calendar;
import java.util.List;

public class SaunaActivity extends BaseActivity implements View.OnClickListener {

    private static final String TAG = "SaunaActivity";

    private Toolbar toolbar;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_sauna);
        initView();
        initData();
        addListener();
    }

    private void initData() {
        // make sure you have logged in successfully before performing synchronization
        // 执行同步前确保已经登录成功 WristbandManager.getInstance().startLoginProcess("1234567890");
        // when you end the sauna, you need to execute the synchronization function
        // 在桑拿结束后执行一次同步才能获取到桑拿数据
        WristbandManager.getInstance().sendDataRequest();
        WristbandManager.getInstance().registerCallback(new WristbandManagerCallback() {

            @Override
            public void onDeviceFunction(ApplicationLayerFunctionPacket functionPacket) {
                super.onDeviceFunction(functionPacket);
                if (functionPacket.getSauna() == DeviceFunctionStatus.SUPPORT) {
                    /// support sauna
                }
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
            public void onRateList(ApplicationLayerRateListPacket packet) {
                super.onRateList(packet);
                Log.e(TAG, "onRateList = " + packet.toString());
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

    private void initView() {
        toolbar = findViewById(R.id.toolbar);
    }



    private void addListener() {
        toolbar.setNavigationOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                finish();
            }
        });
    }


    @Override
    public void onClick(View v) {
    }
}
