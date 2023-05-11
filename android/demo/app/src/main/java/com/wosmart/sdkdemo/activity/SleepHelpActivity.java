package com.wosmart.sdkdemo.activity;

import android.os.Bundle;
import android.text.TextUtils;
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
import com.wosmart.ukprotocollibary.model.enums.DeviceFunctionStatus;
import com.wosmart.ukprotocollibary.v2.JWCallback;

public class SleepHelpActivity extends BaseActivity implements View.OnClickListener {

    private Toolbar toolbar;

    private RadioGroup statusRg;
    private EditText durationEt;
    private EditText effectiveTimeEt;
    private EditText levelEt;
    private Button setBtn;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_sleep_help);
        initView();
        initData();
        addListener();
    }

    private void initView() {
        toolbar = findViewById(R.id.toolbar);

        statusRg = findViewById(R.id.rg_status);
        durationEt = findViewById(R.id.et_duration);
        effectiveTimeEt = findViewById(R.id.et_effective_time);
        levelEt = findViewById(R.id.et_level);
        setBtn = findViewById(R.id.btn_set);

        setBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String durationStr = durationEt.getText().toString();
                String effectiveTimeStr = effectiveTimeEt.getText().toString();
                String levelStr = levelEt.getText().toString();
                if (TextUtils.isEmpty(durationStr)) {
                    showToast("duration cannot be empty");
                    return;
                }
                if (TextUtils.isEmpty(effectiveTimeStr)) {
                    showToast("effective time cannot be empty");
                    return;
                }
                if (TextUtils.isEmpty(levelStr)) {
                    showToast("level cannot be empty");
                    return;
                }
                final int duration = Integer.parseInt(durationStr);
                final int effectiveTime = Integer.parseInt(effectiveTimeStr);
                if (effectiveTime > duration) {
                    showToast("effective time should be less than duration");
                    return;
                }
                final int level = Integer.parseInt(levelStr);
                boolean openFlag = false;
                if (statusRg.getCheckedRadioButtonId() == R.id.rb_open) {
                    openFlag = true;
                }
                final boolean isOpen = openFlag;
                new Thread(new Runnable() {
                    @Override
                    public void run() {
                        WristbandManager.getInstance(SleepHelpActivity.this).setSleepHelp(isOpen, duration, effectiveTime, level, new JWCallback() {
                            @Override
                            public void onSuccess() {
                                showToast(getString(R.string.app_success));
                            }

                            @Override
                            public void onError(int code, String desc) {
                                showToast(getString(R.string.app_fail));
                            }
                        });
                    }
                }).start();
            }
        });
    }

    private void initData() {
        // check is support sleep help
        WristbandManager.getInstance(this).sendFunctionReq();
        WristbandManager.getInstance(this).registerCallback(new WristbandManagerCallback() {

            @Override
            public void onDeviceFunction(ApplicationLayerFunctionPacket functionPacket) {
                super.onDeviceFunction(functionPacket);
                if (functionPacket.getSleepHelp() == DeviceFunctionStatus.SUPPORT) {
                    setBtn.setEnabled(true);
                }
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
