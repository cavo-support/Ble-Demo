package com.wosmart.sdkdemo.util.v7_gt7d.action;

import android.os.Bundle;

import androidx.annotation.Nullable;

import com.wosmart.sdkdemo.common.BaseActivity;
import com.wosmart.ukprotocollibary.model.db.JWHealthDataManager;
import com.wosmart.ukprotocollibary.v2.JWHealthDataSearchParams;
import com.wosmart.ukprotocollibary.v2.JWValueCallback;
import com.wosmart.ukprotocollibary.v2.entity.JWStepInfo;

import java.util.List;

public class StepAction extends BaseActivity {

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);


        // 步数自动计量，无需开启或关闭
        // 在同步结束后，可从 SDK 数据库中获取指定时间步数

        // 指定日期
        JWHealthDataManager.getInstance().getHistoryStepListByDate(2023, 6, 16, new JWValueCallback<List<JWStepInfo>>() {
            @Override
            public void onSuccess(List<JWStepInfo> data) {

            }

            @Override
            public void onError(int code, String desc) {

            }
        });

        // 指定条件
        // for example, if you want get data at 2022-03-04 07:00 - 2022-03-04 08:00
        // option.timeBegin = 1646348400000
        // option.timePeriod = 3600s * 1000
        JWHealthDataSearchParams searchParams = new JWHealthDataSearchParams();
        searchParams.setUserID("");
        searchParams.setTimeBegin(1646348400000L);
        searchParams.setTimePeriod(3600000);
        JWHealthDataManager.getInstance().getHistoryStepList(searchParams, new JWValueCallback<List<JWStepInfo>>() {
            @Override
            public void onSuccess(List<JWStepInfo> data) {

            }

            @Override
            public void onError(int code, String desc) {

            }
        });
    }
}
