package com.wosmart.sdkdemo;

import android.app.Application;

import com.realsil.sdk.core.RtkConfigure;
import com.realsil.sdk.core.RtkCore;
import com.realsil.sdk.dfu.RtkDfu;

public class App extends Application {

    @Override
    public void onCreate() {
        super.onCreate();

        //init rtk OTA
        RtkConfigure configure = new RtkConfigure.Builder()
                .debugEnabled(true)
                .printLog(true)
                .logTag("OTA")
                .globalLogLevel(1)
                .build();
        RtkCore.initialize(this, configure);
        RtkDfu.initialize(this, true);

    }
}