package com.wosmart.sdkdemo.util.v7_gt7d.action;

import android.os.Bundle;

import androidx.annotation.Nullable;

import com.wosmart.sdkdemo.common.BaseActivity;
import com.wosmart.ukprotocollibary.model.db.JWHealthDataManager;
import com.wosmart.ukprotocollibary.v2.JWHealthDataSearchParams;
import com.wosmart.ukprotocollibary.v2.JWValueCallback;
import com.wosmart.ukprotocollibary.v2.entity.JWSportInfo;
import com.wosmart.ukprotocollibary.v2.entity.JWStepInfo;

import java.util.List;

public class SportAction extends BaseActivity {

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);


        // 运动无法从 SDK 发起
        // 可从 SDK 数据库中获取指定时间数据，同步完成后数据为最完整状态

        // 指定日期
        JWHealthDataManager.getInstance().getHistorySportListByDate(2023, 6, 16, new JWValueCallback<List<JWSportInfo>>() {
            @Override
            public void onSuccess(List<JWSportInfo> data) {

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
        JWHealthDataManager.getInstance().getHistorySportList(searchParams, new JWValueCallback<List<JWSportInfo>>() {
            @Override
            public void onSuccess(List<JWSportInfo> data) {

            }

            @Override
            public void onError(int code, String desc) {

            }
        });
    }
}
