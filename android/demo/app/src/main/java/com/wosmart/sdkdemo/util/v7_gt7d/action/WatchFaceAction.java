package com.wosmart.sdkdemo.util.v7_gt7d.action;

import android.os.Bundle;

import androidx.annotation.Nullable;

import com.wosmart.sdkdemo.App;
import com.wosmart.sdkdemo.common.BaseActivity;
import com.wosmart.sdkdemo.util.v7_gt7d.utils.Utils;
import com.wosmart.ukprotocollibary.WristbandManager;
import com.wosmart.ukprotocollibary.WristbandManagerCallback;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerScreenStylePacket;

public class WatchFaceAction extends BaseActivity {


    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);


        if (Utils.batteryLevel < 10) {// 小于百分之十尽量不要设置表盘
            return;
        }
        if (Utils.isSyncHealthData()) {// 同步状态尽量不要设置表盘
            return;
        }

        // 表盘只有设置，没有删除
        // 表盘设置分为 3 种模式
        // 1. 设置手表内置表盘
        // 2. 设置已制作好的表盘文件(可使用我们已定制的表盘文件)
        // 3. 设置自定义图片背景的表盘(用户自定义表盘文件)
    }


    /**
     * 设置内置表盘
     */
    private void setBuiltInWatchFace() {
        // 读取内置表盘

        WristbandManager.getInstance(App.getInstance()).registerCallback(new WristbandManagerCallback() {

            @Override
            public void onHomePager(ApplicationLayerScreenStylePacket packet) {
                super.onHomePager(packet);
                // 内置表盘返回
                packet.getCurIndex();
                packet.getTotal();
            }
        });

        new Thread(new Runnable() {
            @Override
            public void run() {
                // 请求内置表盘
                WristbandManager.getInstance(App.getInstance()).requestHomePager();

                // 设置内置表盘
                WristbandManager.getInstance(App.getInstance()).settingHomePager(0);
            }
        }).start();

    }

}
