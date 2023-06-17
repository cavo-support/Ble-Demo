package com.wosmart.sdkdemo.util.v7_gt7d.action;

import android.os.Bundle;

import androidx.annotation.Nullable;

import com.wosmart.sdkdemo.App;
import com.wosmart.sdkdemo.common.BaseActivity;
import com.wosmart.ukprotocollibary.WristbandManager;
import com.wosmart.ukprotocollibary.model.enums.DeviceLanguage;

public class SetLanguageAction extends BaseActivity {


    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        new Thread(new Runnable() {
            @Override
            public void run() {
                // 设置语言为中文
                WristbandManager.getInstance(App.getInstance()).settingLanguage(DeviceLanguage.LANGUAGE_SAMPLE_CHINESE);
            }
        }).start();
    }
}
