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

import com.realsil.sdk.core.RtkConfigure;
import com.realsil.sdk.core.RtkCore;
import com.realsil.sdk.dfu.RtkDfu;
import com.realsil.sdk.dfu.model.DfuConfig;
import com.realsil.sdk.dfu.model.DfuProgressInfo;
import com.realsil.sdk.dfu.model.OtaDeviceInfo;
import com.realsil.sdk.dfu.model.Throughput;
import com.realsil.sdk.dfu.utils.DfuAdapter;
import com.realsil.sdk.dfu.utils.GattDfuAdapter;
import com.wosmart.sdkdemo.R;
import com.wosmart.sdkdemo.common.BaseActivity;
import com.wosmart.sdkdemo.util.v7_gt7d.utils.ota.CustomOTAFileUtils;
import com.wosmart.ukprotocollibary.WristbandManager;
import com.wosmart.ukprotocollibary.WristbandManagerCallback;

import java.util.logging.Logger;

import static com.realsil.sdk.dfu.DfuConstants.PROGRESS_ACTIVE_IMAGE_AND_RESET;


public class SilenceOtaActivity extends BaseActivity implements View.OnClickListener {

    private String tag = "SilenceOtaActivity";



    private Toolbar toolbar;

    private Button btn_check_status;

    private EditText et_mode;

    private Button btn_set_mode;

    private Button btn_read_mode;

    private Handler handler;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_silence_ota);
        initView();
        initData();
        addListener();

        // we have init ota sdk at App，if you want to use it, you can init ota sdk at application.
        // and you must add DfuService in AndroidManifest.xml
        // 我们已在 Application 中初始化 OTA SDK，用户如需 OTA 也需提前初始化
        // 同时需要在清单文件中添加 DfuService
    }

    private void initView() {
        toolbar = findViewById(R.id.toolbar);
        btn_check_status = findViewById(R.id.btn_check_status);
        et_mode = findViewById(R.id.et_mode);
        btn_set_mode = findViewById(R.id.btn_set_mode);
        btn_read_mode = findViewById(R.id.btn_read_mode);
    }

    private void initData() {
        handler = new MyHandler();

        WristbandManager.getInstance(this).registerCallback(new WristbandManagerCallback() {
            @Override
            public void onSilenceOtaStatus(int status) {
                super.onSilenceOtaStatus(status);
                Log.i(tag, "onSilenceOtaStatus : " + status);
            }

            @Override
            public void onSilenceUpgradeModel(int model) {
                super.onSilenceUpgradeModel(model);
                Log.i(tag, "onSilenceUpgradeModel : " + model);

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
        btn_check_status.setOnClickListener(this);
        btn_set_mode.setOnClickListener(this);
        btn_read_mode.setOnClickListener(this);
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.btn_check_status:
                checkStatus();
                break;
            case R.id.btn_set_mode:
                String modeStr = et_mode.getText().toString();
                if (null != modeStr && !modeStr.isEmpty()) {
                    int mode = Integer.parseInt(modeStr);
                    setMode(mode);
                } else {
                    showToast(getString(R.string.app_silence_mode));
                }
                break;
            case R.id.btn_read_mode:
                readMode();
                break;
        }
    }

    private void checkStatus() {
        Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                if (WristbandManager.getInstance(SilenceOtaActivity.this).sendRequestSilenceOtaStatus()) {
                    handler.sendEmptyMessage(0x01);
                } else {
                    handler.sendEmptyMessage(0x02);
                }
            }
        });
        thread.start();
    }

    public static final int OTA_MODE_MAIN_DISPLAY_RESOURCE = 0;//主显示资源 Main display resource
    public static final int OTA_MODE_DISPLAY_FONT = 1;//显示字库 Display font
    public static final int OTA_MODE_MAIN_FONT_LIBRARIES_INVOLVED_IN_THE_MAIN_INTERFACE = 2;//主界面涉及到的字库 Font libraries involved in the main interface
    public static final int OTA_MODE_CUSTOM_INTERFACE_RESOURCES = 3;//自定义界面资源 Custom interface resources
    public static final int OTA_MODE_DIAL_MARKET_RESOURCES = 4;//表盘市场资源 Dial market resources

    /**
     * EnterSilenceModel tell device ready to ota
     *
     * @param mode see {@link WristbandManager#OTA_MODE_MAIN_DISPLAY_RESOURCE}
     *                 {@link WristbandManager#OTA_MODE_DISPLAY_FONT}
     *                 {@link WristbandManager#OTA_MODE_MAIN_FONT_LIBRARIES_INVOLVED_IN_THE_MAIN_INTERFACE}
     *                 {@link WristbandManager#OTA_MODE_CUSTOM_INTERFACE_RESOURCES}
     *                 {@link WristbandManager#OTA_MODE_DIAL_MARKET_RESOURCES}
     */
    private void setMode(final int mode) {
        Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                if (WristbandManager.getInstance(SilenceOtaActivity.this).sendEnterSilenceModel(mode)) {

                    // 需要用户自行准备 ota 文件，如果是我们的已有的表盘文件，可与我们联系获取
                    // 如果是用户自定义表盘文件，则调用如下工具类制作，具体参数请看函数注释
//                  String otaFilePath = CustomOTAFileUtils.createOTAFile();
                    initUkOta("your device mac", "your ota file path");

                    handler.sendEmptyMessage(0x01);
                } else {
                    handler.sendEmptyMessage(0x02);
                }
            }
        });
        thread.start();
    }

    private void readMode() {
        Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                if (WristbandManager.getInstance(SilenceOtaActivity.this).sendRequestSilenceModel()) {
                    handler.sendEmptyMessage(0x01);
                } else {
                    handler.sendEmptyMessage(0x02);
                }
            }
        });
        thread.start();
    }

    private GattDfuAdapter dfuHelper;

    private DfuAdapter.DfuHelperCallback dfuHelperCallback;

    private DfuConfig dfuConfig;

    /**
     * ota
     *
     * @param mac         device mac address
     * @param otaFilePath new ota file path
     */
    private void initUkOta(final String mac, final String otaFilePath) {
        if (null == dfuHelper) {
            dfuHelper = GattDfuAdapter.getInstance(this);
        }

        if (null == dfuHelperCallback) {
            dfuHelperCallback = new DfuAdapter.DfuHelperCallback() {
                @Override
                public void onStateChanged(int i) {
                    super.onStateChanged(i);
                    if (i == DfuAdapter.STATE_INIT_OK) {
                        // ready to ota
                        startUkOta(mac, otaFilePath);
                    }
                }

                @Override
                public void onTargetInfoChanged(OtaDeviceInfo otaDeviceInfo) {
                    super.onTargetInfoChanged(otaDeviceInfo);
                }

                @Override
                public void onError(int i, int i1) {
                    super.onError(i, i1);
                    // fail
                }

                @Override
                public void onProcessStateChanged(int i, Throughput throughput) {
                    super.onProcessStateChanged(i, throughput);
                    if (i == PROGRESS_ACTIVE_IMAGE_AND_RESET) {
                        // success
                    }
                }

                @Override
                public void onProgressChanged(DfuProgressInfo dfuProgressInfo) {
                    super.onProgressChanged(dfuProgressInfo);
                    // progress info
                }
            };
        }
        dfuHelper.initialize(dfuHelperCallback);
    }

    private void startUkOta(String mac, String filePath) {
        if (null == dfuConfig) {
            dfuConfig = new DfuConfig();
        }
        dfuConfig.setFilePath(filePath);
        dfuConfig.setAddress(mac);
        dfuConfig.setSectionSizeCheckEnabled(false);//取消大小限制
        dfuConfig.setVersionCheckEnabled(false);//版本检查
        dfuHelper.startOtaProcess(dfuConfig);// start to ota
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
