package com.wosmart.sdkdemo.activity;

import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.text.TextUtils;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.RadioGroup;

import androidx.annotation.Nullable;
import androidx.appcompat.widget.Toolbar;

import com.wosmart.sdkdemo.R;
import com.wosmart.sdkdemo.common.BaseActivity;
import com.wosmart.ukprotocollibary.WristbandManager;
import com.wosmart.ukprotocollibary.WristbandManagerCallback;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerFunctionPacket;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerSitPacket;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerTodaySumSportPacket;
import com.wosmart.ukprotocollibary.model.db.GlobalGreenDAO;
import com.wosmart.ukprotocollibary.model.enums.DeviceFunctionStatus;
import com.wosmart.ukprotocollibary.v2.JWCallback;
import com.wosmart.ukprotocollibary.v2.entity.JWPulseInfo;

import java.util.Calendar;
import java.util.List;

public class PulseActivity extends BaseActivity implements View.OnClickListener {

    private static final String TAG = "PulseActivity";

    private Toolbar toolbar;

    private RadioGroup statusRg;
    private EditText durationEt;
    private EditText levelEt;
    private Button setBtn;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_pulse);
        initView();
        initData();
        addListener();
    }

    private void initData() {
        // check is support pulse
        WristbandManager.getInstance(this).sendFunctionReq();
        WristbandManager.getInstance(this).registerCallback(new WristbandManagerCallback() {

            @Override
            public void onDeviceFunction(ApplicationLayerFunctionPacket functionPacket) {
                super.onDeviceFunction(functionPacket);
                if (functionPacket.getPulse() == DeviceFunctionStatus.SUPPORT) {
                    setBtn.setEnabled(true);
                }
            }

            @Override
            public void onSyncPulseDataStart(int totalCount) {
                super.onSyncPulseDataStart(totalCount);
                // sync pulse data started
                Log.e(TAG, "onSyncPulseDataStart");
            }

            @Override
            public void onSyncPulseDataReceived(List<JWPulseInfo> pulseInfoList) {
                super.onSyncPulseDataReceived(pulseInfoList);
                // sync pulse data received, you can save it by yourself
                Log.e(TAG, "onSyncPulseDataReceived, dataList = " + (pulseInfoList != null ? pulseInfoList.toString() : ""));
            }

            @Override
            public void onSyncPulseDataFinished() {
                super.onSyncPulseDataFinished();
                // sync pulse data finished
                Log.e(TAG, "onSyncPulseDataFinished");
                Calendar calendar = Calendar.getInstance();
                int year = calendar.get(Calendar.YEAR);
                int month = calendar.get(Calendar.MONTH) + 1;
                int day = calendar.get(Calendar.DAY_OF_MONTH);

                // after sync pulse data, you can get special pulse data by date from SDK database
                List<JWPulseInfo> pulseInfoList = GlobalGreenDAO.getInstance().loadPulseDataByDate(year, month, day);
                if (pulseInfoList != null) {
                    Log.e(TAG, "onSyncPulseDataFinished, local dataList = " + pulseInfoList.toString());
                }
            }

            @Override
            public void onPulseFinished(int duration) {
                super.onPulseFinished(duration);
                // after pulse finished, this callback will be trigger
                Log.e(TAG, "onPulseFinished, duration = " + duration);
            }

        });

    }

    private void initView() {
        toolbar = findViewById(R.id.toolbar);

        statusRg = findViewById(R.id.rg_status);
        durationEt = findViewById(R.id.et_duration);
        levelEt = findViewById(R.id.et_level);
        setBtn = findViewById(R.id.btn_set);

        setBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String durationStr = durationEt.getText().toString();
                String levelStr = levelEt.getText().toString();
                if (TextUtils.isEmpty(durationStr)) {
                    showToast("duration cannot be empty");
                    return;
                }
                if (TextUtils.isEmpty(levelStr)) {
                    showToast("level cannot be empty");
                    return;
                }
                final int duration = Integer.parseInt(durationStr);
                final int level = Integer.parseInt(levelStr);
                boolean openFlag = false;
                if (statusRg.getCheckedRadioButtonId() == R.id.rb_open) {
                    openFlag = true;
                }
                final boolean isOpen = openFlag;
                new Thread(new Runnable() {
                    @Override
                    public void run() {
                        WristbandManager.getInstance(PulseActivity.this).setPulse(isOpen, duration, level, new JWCallback() {
                            @Override
                            public void onSuccess() {
                            }

                            @Override
                            public void onError(int code, String desc) {
                            }
                        });
                    }
                }).start();
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
    }


    @Override
    public void onClick(View v) {
    }
}
