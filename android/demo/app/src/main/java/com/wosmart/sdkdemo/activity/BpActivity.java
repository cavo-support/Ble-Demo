package com.wosmart.sdkdemo.activity;

import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import androidx.annotation.Nullable;
import androidx.appcompat.widget.Toolbar;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.Switch;

import com.wosmart.sdkdemo.common.BaseActivity;
import com.wosmart.sdkdemo.R;
import com.wosmart.ukprotocollibary.WristbandManager;
import com.wosmart.ukprotocollibary.WristbandManagerCallback;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerBp2ControlPacket;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerBpItemPacket;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerBpPacket;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerPrivateBpPacket;
import com.wosmart.ukprotocollibary.model.db.GlobalGreenDAO;

import java.util.Calendar;

/**
 * 注意点：
 * 设置血压是否展示在设备上，请确认固件是否支持血压2.0, 是否支持血压2.0 请参见获取设备功能 ApplicationLayerFunctionPacket.getBp2()
 * 检测血压前 请确保血压开关已打开
 * 血压自动检测依赖心率，打开血压自动检测需要开启心率自动检测
 * 私人血压 只对血压自动检测起作用，点测还是通用血压
 * 打开私人血压后，自动检测的血压值，会围绕设置的私人血压波动，过滤差距较大的值；
 * 获取血压自动检测的值，在同步数据页面，参见回调方法onBpList(ApplicationLayerBpListPacket packet)；
 * <p>
 * <p>
 * note：
 * To set whether the blood pressure is displayed on the device, please confirm whether the firmware supports blood pressure 2.0, and whether it supports blood pressure 2.0, please refer to get device function ApplicationLayerFunctionPacket.getBp2()
 * Before checking blood pressure, make sure the blood pressure switch is turned on
 * The automatic blood pressure detection depends on the heart rate. To turn on the blood pressure automatic detection, you need to turn on the heart rate automatic detection
 * Private blood pressure only works for automatic blood pressure detection, spot measurement or general blood pressure
 * After turning on the personal blood pressure, the automatically detected blood pressure value will fluctuate around the set personal blood pressure, filtering the values with larger gaps;
 * Get the value of automatic blood pressure detection, in the sync data activity, see the callback method onBpList(ApplicationLayerBpListPacket packet);
 */

public class BpActivity extends BaseActivity implements View.OnClickListener {

    private String tag = "BpActivity";

    private Toolbar toolbar;

    private Button btn_start_measure;

    private Button btn_stop_measure;

    private Button btn_read_bp_setting;

    private Switch sw_show_bp;

    private Button btn_setting_bp;

    private Button btn_read_private_bp_setting;

    private Switch sw_private_bp;

    private Button btn_setting_private_bp;

    private Button btn_query_local_bp;

    private Handler handler;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_bp);
        initView();
        initData();
        addListener();
    }

    private void initView() {
        toolbar = findViewById(R.id.toolbar);
        btn_start_measure = findViewById(R.id.btn_start_measure);
        btn_stop_measure = findViewById(R.id.btn_stop_measure);
        btn_read_bp_setting = findViewById(R.id.btn_read_bp_setting);
        sw_show_bp = findViewById(R.id.sw_show_bp);
        btn_setting_bp = findViewById(R.id.btn_setting_bp);
        btn_read_private_bp_setting = findViewById(R.id.btn_read_private_bp_setting);
        sw_private_bp = findViewById(R.id.sw_private_bp);
        btn_setting_private_bp = findViewById(R.id.btn_setting_private_bp);
        btn_query_local_bp = findViewById(R.id.btn_query_local_bp);
    }

    private void initData() {
        handler = new MyHandler();
        WristbandManager.getInstance().registerCallback(new WristbandManagerCallback() {
            @Override
            public void onBpDataReceiveIndication(ApplicationLayerBpPacket packet) {
                super.onBpDataReceiveIndication(packet);
                for (ApplicationLayerBpItemPacket item : packet.getBpItems()) {
                    Log.i(tag, "bp high :" + item.getmHighValue() + " low : " + item.getmLowValue());
                }
            }

            @Override
            public void onDeviceCancelSingleBpRead() {
                super.onDeviceCancelSingleBpRead();
                Log.i(tag, "stop measure bp ");
            }

            @Override
            public void onBp2Control(ApplicationLayerBp2ControlPacket packet) {
                super.onBp2Control(packet);
                Log.i(tag, "on bp2 control " + packet.toString());
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
        btn_start_measure.setOnClickListener(this);
        btn_stop_measure.setOnClickListener(this);
        btn_read_bp_setting.setOnClickListener(this);
        btn_setting_bp.setOnClickListener(this);
        btn_read_private_bp_setting.setOnClickListener(this);
        btn_setting_private_bp.setOnClickListener(this);
        btn_query_local_bp.setOnClickListener(this);
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.btn_start_measure:
                startMeasure();
                break;
            case R.id.btn_stop_measure:
                stopMeasure();
                break;
            case R.id.btn_read_bp_setting:
                readBpSetting();
                break;
            case R.id.btn_setting_bp:
                boolean show = sw_show_bp.isChecked();
                ApplicationLayerBp2ControlPacket packet = new ApplicationLayerBp2ControlPacket();
                packet.setOpen(show);
                settingBp(packet);
                break;
            case R.id.btn_read_private_bp_setting:
                readPrivateBp();
                break;
            case R.id.btn_setting_private_bp:
                boolean isPrivate = sw_private_bp.isChecked();
                ApplicationLayerPrivateBpPacket packet1 = new ApplicationLayerPrivateBpPacket();
                packet1.setOpen(isPrivate);
                packet1.setHighValue(130);
                packet1.setLowValue(80);
                setPrivateBp(packet1);
                break;
            case R.id.btn_query_local_bp:
                loadLocal();
                break;
        }
    }

    private void loadLocal() {
        Calendar calendar = Calendar.getInstance();
        int year = calendar.get(Calendar.YEAR);
        int month = calendar.get(Calendar.MONTH) + 1;
        int day = calendar.get(Calendar.DAY_OF_MONTH);

//        List<BpData> bpDatas = GlobalGreenDAO.getInstance().loadBpDataByDate(year, month, day);
//
//        if (null != bpDatas) {
//            for (BpData item : bpDatas) {
//                Log.i(tag, "item = " + item.toString());
//            }
//        }
    }

    private void startMeasure() {
        Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                if (WristbandManager.getInstance(BpActivity.this).readBpValue()) {
                    handler.sendEmptyMessage(0x01);
                } else {
                    handler.sendEmptyMessage(0x02);
                }
            }
        });
        thread.start();
    }

    private void stopMeasure() {
        Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                if (WristbandManager.getInstance(BpActivity.this).stopReadBpValue()) {
                    handler.sendEmptyMessage(0x01);
                } else {
                    handler.sendEmptyMessage(0x02);
                }
            }
        });
        thread.start();
    }

    private void readBpSetting() {
        Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                if (WristbandManager.getInstance(BpActivity.this).setBpControlRequest()) {
                    handler.sendEmptyMessage(0x01);
                } else {
                    handler.sendEmptyMessage(0x02);
                }
            }
        });
        thread.start();
    }

    private void settingBp(final ApplicationLayerBp2ControlPacket packet) {
        Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                if (WristbandManager.getInstance(BpActivity.this).setBp2Control(packet)) {
                    handler.sendEmptyMessage(0x01);
                } else {
                    handler.sendEmptyMessage(0x02);
                }
            }
        });
        thread.start();
    }

    private void readPrivateBp() {
        ApplicationLayerPrivateBpPacket packet = WristbandManager.getInstance(BpActivity.this).readPrivateBp();
        Log.i(tag, "private bp = " + packet.toString());
    }

    private void setPrivateBp(ApplicationLayerPrivateBpPacket packet) {
        WristbandManager.getInstance(BpActivity.this).setPrivateBp(packet);
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
