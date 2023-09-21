package com.wosmart.sdkdemo.activity;

import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import androidx.annotation.Nullable;
import androidx.appcompat.widget.Toolbar;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.EditText;

import com.wosmart.sdkdemo.R;
import com.wosmart.sdkdemo.common.BaseActivity;
import com.wosmart.ukprotocollibary.WristbandManager;
import com.wosmart.ukprotocollibary.WristbandManagerCallback;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerMusicPlayerPacket;


/**
 * 需要连接支持音乐控制的设备
 *
 * Need to connect a device that supports music control
 */
public class MusicControlActivity extends BaseActivity implements View.OnClickListener {

    private String tag = "MusicControlActivity";

    private Toolbar toolbar;

    private CheckBox cb_music;

    private EditText et_volume;

    private Button btn_set_music;

    private Handler handler;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_music);
        initView();
        initData();
        addListener();
    }

    private void initView() {
        toolbar = findViewById(R.id.toolbar);
        cb_music = findViewById(R.id.cb_music);
        et_volume = findViewById(R.id.et_volume);
        btn_set_music = findViewById(R.id.btn_set_music);
    }

    private void initData() {
        handler = new MyHandler();

        WristbandManager.getInstance().registerCallback(new WristbandManagerCallback() {
            @Override
            public void onMusicNext() {
                super.onMusicNext();
                Log.i(tag, "onMusicNext");
            }

            @Override
            public void onMusicPre() {
                super.onMusicPre();
                Log.i(tag, "onMusicPre");
            }

            @Override
            public void onMusicPlay() {
                super.onMusicPlay();
                Log.i(tag, "onMusicPlay");
            }

            @Override
            public void onMusicPause() {
                super.onMusicPause();
                Log.i(tag, "onMusicPause");
            }

            @Override
            public void onMusicToggle() {
                super.onMusicToggle();
                Log.i(tag, "onMusicToggle");
            }

            @Override
            public void onMusicVolumeDown() {
                super.onMusicVolumeDown();
                Log.i(tag, "onMusicVolumeDown");
            }

            @Override
            public void onMusicVolumeUp() {
                super.onMusicVolumeUp();
                Log.i(tag, "onMusicVolumeUp");

            }
        });
    }

    private void addListener() {
        toolbar.setNavigationOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                finish();
            }
        });
        btn_set_music.setOnClickListener(this);
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.btn_set_music:
                boolean play = cb_music.isChecked();
                String volumeStr = et_volume.getText().toString();
                if (null != volumeStr && !volumeStr.isEmpty()) {
                    int volume = Integer.parseInt(volumeStr);
                    ApplicationLayerMusicPlayerPacket packet = new ApplicationLayerMusicPlayerPacket();
                    packet.setPlayerToggle(true);
                    packet.setPlayStatus(play);
                    packet.setVolumePercent(volume);

                    setMusic(packet);
                } else {
                    showToast(getString(R.string.app_music_volume));
                }
                break;
        }
    }

    private void setMusic(final ApplicationLayerMusicPlayerPacket packet) {
        Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                if (WristbandManager.getInstance(MusicControlActivity.this).setMusicStatus(packet)) {
                    handler.sendEmptyMessage(0x01);
                } else {
                    handler.sendEmptyMessage(0x02);
                }
            }
        });
        thread.start();
    }

    private class MyHandler extends Handler {
        @Override
        public void handleMessage(Message msg) {
            super.handleMessage(msg);
            switch (msg.what) {
                case 0x01:
                    showToast(getString(R.string.app_success));
                    break;
                case 0x02:
                    showToast(getString(R.string.app_fail));
                    break;
            }
        }
    }
}
