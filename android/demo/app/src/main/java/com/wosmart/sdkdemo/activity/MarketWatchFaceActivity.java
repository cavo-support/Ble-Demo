package com.wosmart.sdkdemo.activity;

import static com.realsil.sdk.dfu.DfuConstants.PROGRESS_ACTIVE_IMAGE_AND_RESET;

import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.TextView;

import androidx.annotation.Nullable;

import com.realsil.sdk.dfu.DfuConstants;
import com.realsil.sdk.dfu.image.BinFactory;
import com.realsil.sdk.dfu.image.BinIndicator;
import com.realsil.sdk.dfu.image.LoadParams;
import com.realsil.sdk.dfu.model.BinInfo;
import com.realsil.sdk.dfu.model.DfuConfig;
import com.realsil.sdk.dfu.model.DfuProgressInfo;
import com.realsil.sdk.dfu.model.OtaDeviceInfo;
import com.realsil.sdk.dfu.model.Throughput;
import com.realsil.sdk.dfu.utils.ConnectParams;
import com.realsil.sdk.dfu.utils.DfuAdapter;
import com.realsil.sdk.dfu.utils.GattDfuAdapter;
import com.wosmart.sdkdemo.App;
import com.wosmart.sdkdemo.R;
import com.wosmart.sdkdemo.common.BaseActivity;
import com.wosmart.ukprotocollibary.WristbandManager;
import com.wosmart.ukprotocollibary.WristbandManagerCallback;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerScreenStylePacket;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

public class MarketWatchFaceActivity extends BaseActivity {


    private TextView progressTv;

    private int faceCount = 0;
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setContentView(R.layout.activity_watch_face_market);

        progressTv = findViewById(R.id.tv_progress);

        // 先读取内置表盘信息 First read the built-in dial information
        readWatchFaceCount();
        findViewById(R.id.btn_set_watch_face).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                setMarketWatchFace();
            }
        });
    }


    /**
     * 设置内置表盘
     */
    private void readWatchFaceCount() {
        // 读取内置表盘
        WristbandManager.getInstance().registerCallback(new WristbandManagerCallback() {

            @Override
            public void onHomePager(ApplicationLayerScreenStylePacket packet) {
                super.onHomePager(packet);
                if (isDestroyed()) {
                    return;
                }
                // 内置表盘信息返回，必须记录内置表盘总数，升级表盘之后需设置新表盘的坐标
                // To return built-in dial information, the total number of built-in dials must be recorded.
                // After upgrading the dial, the coordinates of the new dial need to be set.
                packet.getCurIndex();
                faceCount = packet.getTotal();
            }
        });

        new Thread(new Runnable() {
            @Override
            public void run() {
                // 请求内置表盘
                WristbandManager.getInstance().requestHomePager();
            }
        }).start();
    }

    /**
     * 设置市场表盘
     */
    private void setMarketWatchFace() {
        String deviceMac = App.getInstance().getDeviceMac();
        String otaFilePath = "your ota file path";
        WristbandManager.getInstance().registerCallback(new WristbandManagerCallback() {
            @Override
            public void onSilenceOtaStatus(int status) {
                super.onSilenceOtaStatus(status);
                if (isDestroyed()) {
                    return;
                }
                if (status != 0) {
                    // 设备正忙，当前无法升级，device is busy
                    return;
                }

                enterSilenceModel(deviceMac, otaFilePath, WristbandManager.OTA_MODE_DIAL_MARKET_RESOURCES);
            }

        });

        Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                // 检查设备是否可以升级表盘 check if the device can upgrade the watch face
                WristbandManager.getInstance(MarketWatchFaceActivity.this).sendRequestSilenceOtaStatus();
            }
        });
        thread.start();
    }

    /**
     * 设置表盘升级模式 set watch face upgrade mode
     * @param mode see {@link WristbandManager#OTA_MODE_MAIN_DISPLAY_RESOURCE}
     *                 {@link WristbandManager#OTA_MODE_DISPLAY_FONT}
     *                 {@link WristbandManager#OTA_MODE_MAIN_FONT_LIBRARIES_INVOLVED_IN_THE_MAIN_INTERFACE}
     *                 {@link WristbandManager#OTA_MODE_CUSTOM_INTERFACE_RESOURCES}
     *                 {@link WristbandManager#OTA_MODE_DIAL_MARKET_RESOURCES}
     */
    private void enterSilenceModel(String deviceMac, String otaFilePath, int mode) {
        WristbandManager.getInstance().registerCallback(new WristbandManagerCallback() {

            @Override
            public void onSilenceUpgradeModel(int model) {
                super.onSilenceUpgradeModel(model);
                if (isDestroyed()) {
                    return;
                }
                // 设置升级模式返回 set upgrade mode return
                prepareOtaFile(deviceMac);
//                initUkOta(deviceMac, otaFilePath);
            }
        });
        Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                // 设置表盘升级模式 set watch face upgrade mode
                WristbandManager.getInstance(MarketWatchFaceActivity.this).sendEnterSilenceModel(mode);
                try {
                    Thread.sleep(1000);
                } catch (InterruptedException e) {
                    throw new RuntimeException(e);
                }

                // 延时 1 秒检测设置结果，也可不检查结果直接进行升级，检查了更保险
                WristbandManager.getInstance(MarketWatchFaceActivity.this).sendRequestSilenceModel();
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
                        // OTA SDK 初始化成功
                        connectDevice(mac);
                    } else if (i == DfuAdapter.STATE_PREPARED) {
                        // ready to ota
                        checkOTAFile(mac, dfuHelper.getOtaDeviceInfo(), otaFilePath);
//                        startUkOta(mac, otaFilePath);
                    }
                }

                @Override
                public void onTargetInfoChanged(OtaDeviceInfo otaDeviceInfo) {
                    super.onTargetInfoChanged(otaDeviceInfo);
                }

                @Override
                public void onError(int type, int code) {
                    super.onError(type, code);
                    // fail
                    Log.e("SSSS", "onError type = " + type + ", code = " + code);
                }

                @Override
                public void onProcessStateChanged(int i, Throughput throughput) {
                    super.onProcessStateChanged(i, throughput);
                    Log.e("SSSS", "progress state = " + i);
                    if (i == PROGRESS_ACTIVE_IMAGE_AND_RESET) {
                        // success
                        new Thread(new Runnable() {
                            @Override
                            public void run() {
                                // 表盘 OTA 成功，设置新表盘位置，mode = WristbandManager.OTA_MODE_DIAL_MARKET_RESOURCES 情况下为固定 faceCount + 2
                                // The watch face OTA is successful, set the new watch face index,
                                // in the case of mode = WristbandManager.OTA_MODE_DIAL_MARKET_RESOURCES, it is fixed faceCount + 2
                                WristbandManager.getInstance(MarketWatchFaceActivity.this).settingHomePager(faceCount + 2);
                            }
                        }).start();
                    }

                }

                @Override
                public void onProgressChanged(DfuProgressInfo dfuProgressInfo) {
                    super.onProgressChanged(dfuProgressInfo);
                    // progress info
                    int progress = dfuProgressInfo.getProgress();
                    runOnUiThread(new Runnable() {
                        @Override
                        public void run() {
                            progressTv.setText(progress + "%");
                        }
                    });
                    Log.e("SSSS", "progress = " + progress);
                }
            };
        }
        dfuHelper.initialize(dfuHelperCallback);
    }

    private void connectDevice(String mac) {
        ConnectParams connectParams = new ConnectParams.Builder()
                .address(mac)
                .reconnectTimes(3)
                .build();
        dfuHelper.connectDevice(connectParams);
    }

    public void prepareOtaFile(String mac) {
        String binFileName = "mode5_usedata_E88P_0.16.0.1_OTA.bin";// we save it at asset now, you will download it in internet
        File dir = new File(getCacheDir() + "/bin");
        if (!dir.exists()) {
            dir.mkdir();
        }
        // check local bin file, you must save it to local before ota
        File binFile = new File(dir, binFileName);
        if (binFile.exists()) {
            // bin file is ready, start ota now
            initUkOta(mac, binFile.getAbsolutePath());
            return;
        }
        try {
            binFile.createNewFile();
            // load bin file to phone
            InputStream is = this.getApplicationContext().getResources().getAssets().open(binFileName);
            FileOutputStream fos = new FileOutputStream(binFile);
            byte[] buffere = new byte[is.available()];
            is.read(buffere);
            fos.write(buffere);
            is.close();
            fos.close();

            // bin file is ready, start ota now
            initUkOta(mac, binFile.getAbsolutePath());
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void checkOTAFile(String mac, OtaDeviceInfo otaDeviceInfo, String filePath) {
        try {
            LoadParams.Builder builder = new LoadParams.Builder()
                    .setPrimaryIcType(DfuConstants.IC_BEE1)
                    .setFilePath(filePath) // Mandatory
                    .setFileSuffix("bin")
                    .setOtaDeviceInfo(otaDeviceInfo) // Recommend
                    .setIcCheckEnabled(true)
                    .setSectionSizeCheckEnabled(true)
                    .setVersionCheckEnabled(true);
            BinInfo binInfo = BinFactory.loadImageBinInfo(builder.build());
            if (binInfo.supportBinInputStreams != null && binInfo.supportBinInputStreams.size() <= 0) {
                //文件错误, bin file error
            } else {
                //文件正确
                startUkOta(mac, filePath);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    private void startUkOta(String mac, String filePath) {
        if (null == dfuConfig) {
            dfuConfig = new DfuConfig();
        }
        dfuConfig.setFilePath(filePath);
        dfuConfig.setAddress(mac);
        dfuConfig.setOtaWorkMode(DfuConstants.OTA_MODE_SILENT_FUNCTION);
        dfuConfig.setAutomaticActiveEnabled(true);
        dfuConfig.setFileIndicator(BinIndicator.INDICATOR_FULL);
        dfuHelper.startOtaProcess(dfuConfig);// start to ota
    }

}
