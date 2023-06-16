package com.wosmart.sdkdemo.util.v7_gt7d.action;

import android.os.Bundle;

import androidx.annotation.Nullable;

import com.wosmart.sdkdemo.App;
import com.wosmart.sdkdemo.common.BaseActivity;
import com.wosmart.ukprotocollibary.WristbandManager;

public class TargetSetAction extends BaseActivity {


    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        new Thread(new Runnable() {
            @Override
            public void run() {
                // 设置目标卡路里，单位千卡，100 - 9999
                WristbandManager.getInstance(App.getInstance()).setTargetCalc(100);

                // 设置目标步数，范围 1000 - 65000
                WristbandManager.getInstance(App.getInstance()).setTargetStep(100);

                // 设置目标睡眠，单位 分钟，范围 90 - 900
                WristbandManager.getInstance(App.getInstance()).setTargetSleep(100);
            }
        }).start();
    }
}
