package com.wosmart.sdkdemo.util.v7_gt7d.action;

import android.os.Bundle;

import androidx.annotation.Nullable;

import com.wosmart.sdkdemo.App;
import com.wosmart.sdkdemo.common.BaseActivity;
import com.wosmart.sdkdemo.util.v7_gt7d.utils.Utils;
import com.wosmart.ukprotocollibary.WristbandManager;
import com.wosmart.ukprotocollibary.WristbandManagerCallback;

public class BatteryLevelAction extends BaseActivity {


    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        WristbandManager.getInstance().registerCallback(new WristbandManagerCallback() {

            @Override
            public void onBatteryRead(int value) {
                super.onBatteryRead(value);
                // 0 - 100
                Utils.batteryLevel = value;
            }

            @Override
            public void onBatteryChange(int value) {
                super.onBatteryChange(value);
                // 0 - 100
                Utils.batteryLevel = value;
            }
        });

        WristbandManager.getInstance().readBatteryLevel();
    }
}
