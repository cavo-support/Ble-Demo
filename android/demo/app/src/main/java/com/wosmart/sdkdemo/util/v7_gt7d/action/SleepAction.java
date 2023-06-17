package com.wosmart.sdkdemo.util.v7_gt7d.action;

import android.os.Bundle;

import androidx.annotation.Nullable;

import com.wosmart.sdkdemo.common.BaseActivity;
import com.wosmart.ukprotocollibary.model.db.JWHealthDataManager;
import com.wosmart.ukprotocollibary.model.sleep.filter.SleepFilter;
import com.wosmart.ukprotocollibary.model.sleep.filter.SleepInfo;
import com.wosmart.ukprotocollibary.v2.JWHealthDataSearchParams;
import com.wosmart.ukprotocollibary.v2.JWValueCallback;
import com.wosmart.ukprotocollibary.v2.entity.JWSleepInfo;
import com.wosmart.ukprotocollibary.v2.entity.JWStepInfo;

import java.util.List;

public class SleepAction extends BaseActivity {

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);


        // 睡眠自动计量，无需开启或关闭
        // 在同步结束后，可从 SDK 数据库中获取指定时间睡眠

        // 指定日期
        JWHealthDataManager.getInstance().getHistorySleepListByDate(2023, 6, 16, new JWValueCallback<List<JWSleepInfo>>() {
            @Override
            public void onSuccess(List<JWSleepInfo> data) {

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
        JWHealthDataManager.getInstance().getHistorySleepList(searchParams, new JWValueCallback<List<JWSleepInfo>>() {
            @Override
            public void onSuccess(List<JWSleepInfo> data) {

            }

            @Override
            public void onError(int code, String desc) {

            }
        });

        // 支持按年月日过滤无效睡眠数据
        SleepInfo sleepInfo = SleepFilter.filterByData(2023, 6, 16);
    }
}
