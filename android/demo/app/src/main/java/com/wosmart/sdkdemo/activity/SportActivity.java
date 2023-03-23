package com.wosmart.sdkdemo.activity;

import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import androidx.annotation.Nullable;
import androidx.appcompat.widget.Toolbar;
import android.util.Log;
import android.view.View;
import android.widget.Button;

import com.wosmart.sdkdemo.common.BaseActivity;
import com.wosmart.sdkdemo.R;
import com.wosmart.ukprotocollibary.WristbandManager;
import com.wosmart.ukprotocollibary.WristbandManagerCallback;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerHrpPacket;

public class SportActivity extends BaseActivity implements View.OnClickListener {

    private String tag = "SportActivity";

    private Toolbar toolbar;

    private Button btn_check_sport_rate;

    private Button btn_start_sport_rate;

    private Button btn_stop_sport_rate;

    private Handler handler;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_sport);
        initView();
        initData();
        addListener();
    }

    private void initView() {
        toolbar = findViewById(R.id.toolbar);
        btn_check_sport_rate = findViewById(R.id.btn_check_sport_rate);
        btn_start_sport_rate = findViewById(R.id.btn_start_sport_rate);
        btn_stop_sport_rate = findViewById(R.id.btn_stop_sport_rate);
    }

    private void initData() {
        handler = new MyHandler();
        WristbandManager.getInstance(this).registerCallback(new WristbandManagerCallback() {
            @Override
            public void onSportRateStatus(int status) {
                super.onSportRateStatus(status);
                if (status == 0) {
                    Log.i(tag, "hrp detect start");
                } else if (status == 1) {
                    Log.i(tag, "hrp detect stop");
                } else if (status == 2) {
                    Log.i(tag, "hrp detect busy");
                } else if (status == 3) {
                    Log.i(tag, "hrp detect normal");
                }
            }

            @Override
            public void onHrpDataReceiveIndication(ApplicationLayerHrpPacket packet) {
                super.onHrpDataReceiveIndication(packet);
                Log.i(tag, "hrp data = " + packet.toString());
            }

            @Override
            public void onDeviceCancelSingleHrpRead() {
                super.onDeviceCancelSingleHrpRead();
                Log.i(tag, "cancel sport rate");
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
        btn_check_sport_rate.setOnClickListener(this);
        btn_start_sport_rate.setOnClickListener(this);
        btn_stop_sport_rate.setOnClickListener(this);
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.btn_check_sport_rate:
                checkSport();
                break;
            case R.id.btn_start_sport_rate:
                startSport();
                break;
            case R.id.btn_stop_sport_rate:
                stopSport();
                break;
        }
    }

    private void checkSport() {
        if (WristbandManager.getInstance(this).checkAppSportRateDetect()) {
            showToast(getString(R.string.app_success));
        } else {
            showToast(getString(R.string.app_fail));
        }
    }


    private void startSport() {
        Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                if (WristbandManager.getInstance(SportActivity.this).setAppSportRateDetect(true)) {
                    handler.sendEmptyMessage(0x01);
                } else {
                    handler.sendEmptyMessage(0x02);
                }
            }
        });
        thread.start();
    }

    private void stopSport() {
        Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                if (WristbandManager.getInstance(SportActivity.this).setAppSportRateDetect(false)) {
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
