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
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerCustomUiPacket;

/**
 * 需要连接支持自定义主界面的设备
 * <p>
 * Need to connect to a device that supports custom UI
 */
public class CustomUiActivity extends BaseActivity implements View.OnClickListener {

    private String tag = "CustomUiActivity";

    private Toolbar toolbar;

    private Button btn_read;

    private CheckBox cb_color;

    private EditText et_gravity;

    private EditText et_x;

    private EditText et_y;

    private Button btn_set;

    private Handler handler;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_custom_ui);
        initView();
        initData();
        addListener();
    }

    private void initView() {
        toolbar = findViewById(R.id.toolbar);
        btn_read = findViewById(R.id.btn_read);
        cb_color = findViewById(R.id.cb_color);
        et_gravity = findViewById(R.id.et_gravity);
        et_x = findViewById(R.id.et_x);
        et_y = findViewById(R.id.et_y);
        btn_set = findViewById(R.id.btn_set);
    }

    private void initData() {
        handler = new MyHandler();

        WristbandManager.getInstance().registerCallback(new WristbandManagerCallback() {

            @Override
            public void onCustomUiSetting(ApplicationLayerCustomUiPacket packet) {
                super.onCustomUiSetting(packet);
                Log.i(tag, "onCustomUiSetting : " + packet.toString());
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
        btn_read.setOnClickListener(this);
        btn_set.setOnClickListener(this);
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.btn_read:
                readCustomUiConfig();
                break;
            case R.id.btn_set:
                boolean light = cb_color.isChecked();
                String gravityStr = et_gravity.getText().toString();
                String xStr = et_x.getText().toString();
                String yStr = et_y.getText().toString();
                if (null != gravityStr && !gravityStr.isEmpty()) {
                    if (null != xStr && !xStr.isEmpty()) {
                        if (null != yStr && !yStr.isEmpty()) {
                            int gravity = Integer.parseInt(gravityStr);
                            int x = Integer.parseInt(xStr);
                            int y = Integer.parseInt(yStr);
                            ApplicationLayerCustomUiPacket packet = new ApplicationLayerCustomUiPacket();
                            packet.setTimeColor(light ? 1 : 0);
                            packet.setGravity(gravity);
                            packet.setxCoordinate(x);
                            packet.setyCoordinate(y);

                            setCustomUiConfig(packet);
                        } else {
                            showToast(getString(R.string.app_y_coordinate));
                        }
                    } else {
                        showToast(getString(R.string.app_x_coordinate));
                    }
                } else {
                    showToast(getString(R.string.app_gravity));
                }
                break;
        }
    }

    private void readCustomUiConfig() {
        Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                if (WristbandManager.getInstance(CustomUiActivity.this).readCustomUi()) {
                    handler.sendEmptyMessage(0x01);
                } else {
                    handler.sendEmptyMessage(0x02);
                }
            }
        });
        thread.start();
    }

    private void setCustomUiConfig(final ApplicationLayerCustomUiPacket packet) {
        Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                if (WristbandManager.getInstance(CustomUiActivity.this).setCustomUi(packet)) {
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
