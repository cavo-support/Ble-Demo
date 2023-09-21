package com.wosmart.sdkdemo.activity;

import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import androidx.annotation.Nullable;
import androidx.appcompat.widget.Toolbar;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.RadioGroup;

import com.wosmart.sdkdemo.common.BaseActivity;
import com.wosmart.sdkdemo.R;
import com.wosmart.ukprotocollibary.WristbandManager;
import com.wosmart.ukprotocollibary.WristbandManagerCallback;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerNotifyPacket;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerSwitchPacket;
import com.wosmart.ukprotocollibary.model.enums.DeviceFunctionStatus;

public class LightControlActivity extends BaseActivity implements View.OnClickListener {
    private String tag = "LightControlActivity";

    private Toolbar toolbar;

    private Button btn_read_turn_wrist;

    private RadioGroup rg_turn_wrist;

    private Button btn_set_turn_wrist;

    private Button btn_read;

    private EditText et_light_time;

    private Button btn_set;

    private Handler handler;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_light_control);
        initView();
        initData();
        addListener();
    }

    private void initView() {
        toolbar = findViewById(R.id.toolbar);
        btn_read_turn_wrist = findViewById(R.id.btn_read_turn_wrist);
        rg_turn_wrist = findViewById(R.id.rg_turn_wrist);
        btn_set_turn_wrist = findViewById(R.id.btn_set_turn_wrist);
        btn_read = findViewById(R.id.btn_read);
        et_light_time = findViewById(R.id.et_light_time);
        btn_set = findViewById(R.id.btn_set);
    }

    private void initData() {
        handler = new MyHandler();
        WristbandManager.getInstance().registerCallback(new WristbandManagerCallback() {
            @Override
            public void onScreenLightDuration(int duration) {
                super.onScreenLightDuration(duration);
                Log.i(tag, "duration : " + duration);
            }

            @Override
            public void onTurnOverWristSettingReceive(boolean mode) {
                super.onTurnOverWristSettingReceive(mode);
                Log.i(tag, "turn wrist status : " + mode);
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
        btn_read_turn_wrist.setOnClickListener(this);
        btn_set_turn_wrist.setOnClickListener(this);
        btn_read.setOnClickListener(this);
        btn_set.setOnClickListener(this);
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.btn_read_turn_wrist:
                readTurnWrist();
                break;
            case R.id.btn_set_turn_wrist:
                boolean flag = rg_turn_wrist.getCheckedRadioButtonId() == R.id.rb_open;
                setTurnWrist(flag);
                break;
            case R.id.btn_read:
                readScreenLight();
                break;
            case R.id.btn_set:
                String durationStr = et_light_time.getText().toString();
                if (null != durationStr && !durationStr.isEmpty()) {
                    int duration = Integer.parseInt(durationStr);
                    setScreenLight(duration);
                } else {
                    showToast(getString(R.string.app_light_duration_hint));
                }
                break;
        }
    }

    private void readTurnWrist() {
        Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                if (WristbandManager.getInstance(LightControlActivity.this).sendTurnOverWristRequest()) {
                    handler.sendEmptyMessage(0x01);
                } else {
                    handler.sendEmptyMessage(0x02);
                }
            }
        });
        thread.start();
    }

    private void setTurnWrist(final boolean openFlag) {
        Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                if (WristbandManager.getInstance(LightControlActivity.this).setTurnOverWrist(openFlag)) {
                    handler.sendEmptyMessage(0x01);
                } else {
                    handler.sendEmptyMessage(0x02);
                }
            }
        });
        thread.start();
    }

    private void readScreenLight() {
        Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                if (WristbandManager.getInstance(LightControlActivity.this).sendScreenLightDurationReq()) {
                    handler.sendEmptyMessage(0x01);
                } else {
                    handler.sendEmptyMessage(0x02);
                }
            }
        });
        thread.start();
    }


    private void setScreenLight(final int duration) {
        Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                if (WristbandManager.getInstance(LightControlActivity.this).settingScreenLightDuration(duration)) {
                    handler.sendEmptyMessage(0x01);
                } else {
                    handler.sendEmptyMessage(0x02);
                }
            }
        });
        thread.start();
    }

    private void setScreenLightPercent(final int percent) {
        Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                if (WristbandManager.getInstance(LightControlActivity.this).settingScreenLight(percent)) {
                    handler.sendEmptyMessage(0x01);
                } else {
                    handler.sendEmptyMessage(0x02);
                }
            }
        });
        thread.start();
    }

    private void setAutoLock(final ApplicationLayerSwitchPacket packet) {
        Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                if (WristbandManager.getInstance(LightControlActivity.this).settingAutoLock(packet)) {
                    handler.sendEmptyMessage(0x01);
                } else {
                    handler.sendEmptyMessage(0x02);
                }
            }
        });
        thread.start();
    }

    private void setAllNotify(final ApplicationLayerNotifyPacket packet) {
        Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                if (WristbandManager.getInstance(LightControlActivity.this).setAllNotify(packet)) {
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
