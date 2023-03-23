package com.wosmart.sdkdemo.activity;

import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.util.Log;
import android.view.View;
import android.widget.Button;

import androidx.annotation.Nullable;
import androidx.appcompat.widget.Toolbar;

import com.wosmart.sdkdemo.common.BaseActivity;
import com.wosmart.sdkdemo.R;
import com.wosmart.ukprotocollibary.WristbandManager;
import com.wosmart.ukprotocollibary.WristbandManagerCallback;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerBeginPacket;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerBpListItemPacket;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerBpListPacket;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerHrpItemPacket;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerHrpPacket;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerRateItemPacket;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerRateListPacket;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerSleepItemPacket;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerSleepPacket;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerSportItemPacket;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerSportPacket;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerStepItemPacket;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerStepPacket;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerTodaySumSportPacket;

public class SyncDataActivity extends BaseActivity implements View.OnClickListener {

    private String tag = "SyncDataActivity";

    private Toolbar toolbar;

    private Button btn_sync_data;

    private Handler handler;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_sync_data);
        initView();
        initData();
        addListener();
    }

    private void initView() {
        toolbar = findViewById(R.id.toolbar);
        btn_sync_data = findViewById(R.id.btn_sync_data);
    }

    private void initData() {
        handler = new MyHandler();
        WristbandManager.getInstance(this).registerCallback(new WristbandManagerCallback() {

            @Override
            public void onSyncDataBegin(ApplicationLayerBeginPacket packet) {
                super.onSyncDataBegin(packet);
                Log.i(tag, "sync begin");
            }

            @Override
            public void onStepDataReceiveIndication(ApplicationLayerStepPacket packet) {
                super.onStepDataReceiveIndication(packet);
                for (ApplicationLayerStepItemPacket item : packet.getStepsItems()) {
                    Log.i(tag, item.toString());
                }
                Log.i(tag, "size = " + packet.getStepsItems().size());
            }

            @Override
            public void onSleepDataReceiveIndication(ApplicationLayerSleepPacket packet) {
                super.onSleepDataReceiveIndication(packet);
                for (ApplicationLayerSleepItemPacket item : packet.getSleepItems()) {
                    Log.i(tag, item.toString());
                }
                Log.i(tag, "size = " + packet.getSleepItems().size());
            }

            @Override
            public void onHrpDataReceiveIndication(ApplicationLayerHrpPacket packet) {
                super.onHrpDataReceiveIndication(packet);
                for (ApplicationLayerHrpItemPacket item : packet.getHrpItems()) {
                    Log.i(tag, item.toString());
                }
                Log.i(tag, "size = " + packet.getHrpItems().size());
            }

            @Override
            public void onRateList(ApplicationLayerRateListPacket packet) {
                super.onRateList(packet);
                for (ApplicationLayerRateItemPacket item : packet.getRateList()) {
                    Log.i(tag, item.toString());
                }
                Log.i(tag, "size = " + packet.getRateList().size());
            }

            @Override
            public void onSportDataReceiveIndication(ApplicationLayerSportPacket packet) {
                super.onSportDataReceiveIndication(packet);
                for (ApplicationLayerSportItemPacket item : packet.getSportItems()) {
                    Log.i(tag, item.toString());
                }
                Log.i(tag, "size = " + packet.getSportItems().size());
            }

            //温度检测回调
            // temperature measure data call back
            @Override
            public void onTemperatureData(ApplicationLayerHrpPacket packet) {
                super.onTemperatureData(packet);

                for (ApplicationLayerHrpItemPacket item : packet.getHrpItems()) {
                    Log.i(tag, "temperature = " + item.toString());
                }
                Log.i(tag, "temperature size = " + packet.getHrpItems().size());
            }

            //温度历史数据回调
            // temperature history data call back
            @Override
            public void onTemperatureList(ApplicationLayerRateListPacket packet) {
                super.onTemperatureList(packet);
                for (ApplicationLayerRateItemPacket item : packet.getRateList()) {
                    Log.i(tag, "temperature = " + item.toString());
                }
                Log.i(tag, "temperature size = " + packet.getRateList().size());
            }

            @Override
            public void onSyncDataEnd(ApplicationLayerTodaySumSportPacket packet) {
                super.onSyncDataEnd(packet);
                Log.i(tag, "sync end");
            }

            /**
             * 血压自动检测回调
             *
             * bp auto measure callback
             *
             * @param packet
             */
            @Override
            public void onBpList(ApplicationLayerBpListPacket packet) {
                super.onBpList(packet);

                for (ApplicationLayerBpListItemPacket item : packet.getBpListItemPackets()) {
                    Log.i(tag, "bpItem = " + item.toString());
                }
                Log.i(tag, "bp size = " + packet.getBpListItemPackets().size());
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
        btn_sync_data.setOnClickListener(this);
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.btn_sync_data:
                syncData();
                break;
        }
    }

    private void syncData() {
        Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                if (WristbandManager.getInstance(SyncDataActivity.this).sendDataRequest()) {
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
