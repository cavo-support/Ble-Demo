package com.wosmart.sdkdemo.activity;

import android.os.Bundle;
import android.view.View;

import androidx.annotation.Nullable;

import com.wosmart.sdkdemo.App;
import com.wosmart.sdkdemo.R;
import com.wosmart.sdkdemo.common.BaseActivity;
import com.wosmart.ukprotocollibary.WristbandManager;
import com.wosmart.ukprotocollibary.WristbandManagerCallback;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerScreenStylePacket;

public class BuiltInWatchFaceActivity extends BaseActivity {

    private int faceCount = 0;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setContentView(R.layout.activity_watch_face_market);

        findViewById(R.id.btn_set_watch_face).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                new Thread(new Runnable() {
                    @Override
                    public void run() {
                        // 设置第几个内置表盘，确保 index 要小于 faceCount
                        // Set the number of built-in dials and make sure the index is smaller than faceCount
                        int faceIndex = 3;
                        if (faceIndex >= faceCount) {
                            return;
                        }
                        WristbandManager.getInstance(App.getInstance()).settingHomePager(faceIndex);
                    }
                }).start();
            }
        });
    }


    /**
     * 设置内置表盘
     */
    private void readWatchFaceCount() {
        // 读取内置表盘
        WristbandManager.getInstance(App.getInstance()).registerCallback(new WristbandManagerCallback() {

            @Override
            public void onHomePager(ApplicationLayerScreenStylePacket packet) {
                super.onHomePager(packet);
                // 内置表盘返回 build-in watch face return
                packet.getCurIndex();
                faceCount = packet.getTotal();


            }
        });

        new Thread(new Runnable() {
            @Override
            public void run() {
                // 请求内置表盘 read build-in watch face
                WristbandManager.getInstance(App.getInstance()).requestHomePager();
            }
        }).start();
    }


}
