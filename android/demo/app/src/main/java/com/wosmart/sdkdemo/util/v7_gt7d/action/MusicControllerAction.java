package com.wosmart.sdkdemo.util.v7_gt7d.action;

import android.os.Bundle;

import androidx.annotation.Nullable;

import com.wosmart.sdkdemo.App;
import com.wosmart.sdkdemo.common.BaseActivity;
import com.wosmart.ukprotocollibary.WristbandManager;
import com.wosmart.ukprotocollibary.WristbandManagerCallback;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerMusicPlayerPacket;

public class MusicControllerAction extends BaseActivity {


    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);


        WristbandManager.getInstance(App.getInstance()).registerCallback(new WristbandManagerCallback() {

            @Override
            public void onMusicPlay() {
                super.onMusicPlay();
                // 音乐播放
            }

            @Override
            public void onMusicPause() {
                super.onMusicPause();
                // 音乐暂停
            }

            @Override
            public void onMusicNext() {
                super.onMusicNext();
                // 音乐下一首
            }

            @Override
            public void onMusicPre() {
                super.onMusicPre();
                // 音乐上一首
            }

            @Override
            public void onMusicToggle() {
                super.onMusicToggle();
                // 暂时无用
            }

            @Override
            public void onMusicVolumeUp() {
                super.onMusicVolumeUp();
                // 音量加
            }

            @Override
            public void onMusicVolumeDown() {
                super.onMusicVolumeDown();
                // 音量减
            }
        });

        new Thread(new Runnable() {
            @Override
            public void run() {
                ApplicationLayerMusicPlayerPacket packet = new ApplicationLayerMusicPlayerPacket();
                packet.setPlayerToggle(true);// 打开音乐控制
                packet.setPlayStatus(true);// 是否正在播放
                packet.setVolumePercent(3);// 音量百分比
                WristbandManager.getInstance(App.getInstance()).setMusicStatus(packet);
            }
        }).start();
    }


}
