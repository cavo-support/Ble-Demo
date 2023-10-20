package com.wosmart.sdkdemo.activity;

import static com.realsil.sdk.dfu.DfuConstants.PROGRESS_ACTIVE_IMAGE_AND_RESET;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Bundle;
import android.text.TextUtils;
import android.util.Log;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.Nullable;
import androidx.core.content.ContextCompat;

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
import com.wosmart.sdkdemo.util.v7_gt7d.utils.ota.CustomOTAFileUtils;
import com.wosmart.ukprotocollibary.WristbandManager;
import com.wosmart.ukprotocollibary.WristbandManagerCallback;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerCustomUiPacket;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerScreenStylePacket;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Random;

public class CustomWatchFaceActivity extends BaseActivity {

    private static final String TAG = "CustomWatchFaceActivity";

    private int faceCount = 0;

    /**
     * 是否为圆形手表 Is it a round watch?
     */
    private boolean isRoundWatch;

    private ImageView previewImg;

    private TextView progressTv;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setContentView(R.layout.activity_watch_face_market);

        progressTv = findViewById(R.id.tv_progress);
        previewImg = findViewById(R.id.img_preview);
        previewImg.setDrawingCacheEnabled(true);

        isRoundWatch = new Random().nextBoolean();// 用户需确认手表是否为圆形 Users need to confirm whether the watch is round
        isRoundWatch = false;
        previewImg.setImageDrawable(ContextCompat.getDrawable(this, isRoundWatch ? R.mipmap.bg_preview_round : R.mipmap.bg_preview_rect));

        // 先读取内置表盘信息 First read the built-in dial information
        readWatchFaceCount();

        findViewById(R.id.btn_set_watch_face).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                setCustomWatchFace();
            }
        });

        WristbandManager.getInstance().registerCallback(new WristbandManagerCallback() {

            @Override
            public void onBondReqChipType(int type) {
                super.onBondReqChipType(type);
                // 在登录成功后会触发此回调，用户需自行记录设备芯片类型
                // 若没有触发此回调，则是默认芯片类型 0
                // This callback will be triggered after successful login. The user needs to record the device chip type by himself.
                // If this callback is not triggered, the default chip type is 0
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
                // 内置表盘返回 build-in watch face return
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
     * 设置自定义表盘
     */
    private void setCustomWatchFace() {
        String deviceMac = App.getInstance().getDeviceMac();
        Bitmap bgBitmap = BitmapFactory.decodeResource(getResources(), isRoundWatch ? R.mipmap.bg_preview_round : R.mipmap.bg_preview_rect);// your watch face background img
        Bitmap previewBitmap = previewImg.getDrawingCache();// your watch face preview img

        // 每个手表对应的尺寸不一样，具体的尺寸联系请我们获取
        // V101
//        String otaFilePath = CustomOTAFileUtils.createOTAFile(this, bgBitmap, previewBitmap,
//                isRoundWatch, App.getInstance().getDeviceChipType(), 80, 160,
//                66, 128, 0, 1, "#04fbfe");

        // TF 5S
//        String otaFilePath = CustomOTAFileUtils.createOTAFile(this, bgBitmap, previewBitmap,
//                isRoundWatch, App.getInstance().getDeviceChipType(), 360, 360,
//                238, 238, 119, 2, "#08d3ff");

        // P1S
        String otaFilePath = CustomOTAFileUtils.createOTAFile(this, bgBitmap, previewBitmap,
                isRoundWatch, App.getInstance().getDeviceChipType(), 172, 320,
                129, 240, 18, 2, "#08d3ff");

        if (TextUtils.isEmpty(otaFilePath)) {
            return;
        }
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

                enterSilenceModel(deviceMac, otaFilePath, WristbandManager.OTA_MODE_CUSTOM_INTERFACE_RESOURCES);
            }

        });

        Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                // 检查设备是否可以升级表盘 check if the device can upgrade the watch face
                WristbandManager.getInstance(CustomWatchFaceActivity.this).sendRequestSilenceOtaStatus();
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
//                prepareOtaFile(deviceMac);
                initUkOta(deviceMac, otaFilePath);
            }
        });
        Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                // 设置表盘升级模式 set watch face upgrade mode
                WristbandManager.getInstance(CustomWatchFaceActivity.this).sendEnterSilenceModel(mode);
                try {
                    Thread.sleep(1000);
                } catch (InterruptedException e) {
                    throw new RuntimeException(e);
                }

                // 延时 1 秒检测设置结果，也可不检查结果直接进行升级，检查了更保险
                WristbandManager.getInstance(CustomWatchFaceActivity.this).sendRequestSilenceModel();
            }
        });
        thread.start();
    }

    /**
     * 区别市场表盘，自定义表盘需设置时间位置，颜色，x,y 等信息，可与我们沟通获取设备对应配置
     * Different from market dials, custom dials require more settings such as time position, color, x, y and other information.
     * You can communicate with us to obtain the corresponding configuration of the device.
     */
    private void onOTASuccess() {
        new Thread(new Runnable() {
            @Override
            public void run() {
                // 表盘 OTA 成功
                // 设置表盘时间位置，字体颜色，坐标等信息
//                ApplicationLayerCustomUiPacket packet = new ApplicationLayerCustomUiPacket();
//                int color = 0;// 0 黑色 65535 白色
//                int position = 5;// 九宫格，时间位置
//                packet.setTimeColor(color);
                // 时间显示位置以九宫格为准
                // 1 2 3
                // 4 5 6
                // 7 8 9
                // gravity取值范围 0，1，2，代表左 中 右
                // 具体的 x，y 坐标联系我们获取
//                switch (position) {
//                    case 1:
//                        packet.setGravity(0);
//                        packet.setxCoordinate(15);
//                        packet.setyCoordinate(14);
//                        break;
//                    case 2:
//                        packet.setGravity(1);
//                        packet.setxCoordinate(51);
//                        packet.setyCoordinate(14);
//                        break;
//                    case 3:
//                        packet.setGravity(2);
//                        packet.setxCoordinate(86);
//                        packet.setyCoordinate(14);
//                        break;
//                    case 4:
//                        packet.setGravity(0);
//                        packet.setxCoordinate(15);
//                        packet.setyCoordinate(85);
//                        break;
//                    case 5:
//                        packet.setGravity(1);
//                        packet.setxCoordinate(51);
//                        packet.setyCoordinate(85);
//                        break;
//                    case 6:
//                        packet.setGravity(2);
//                        packet.setxCoordinate(86);
//                        packet.setyCoordinate(85);
//                        break;
//                    case 7:
//                        packet.setGravity(0);
//                        packet.setxCoordinate(15);
//                        packet.setyCoordinate(157);
//                        break;
//                    case 8:
//                        packet.setGravity(1);
//                        packet.setxCoordinate(51);
//                        packet.setyCoordinate(157);
//                        break;
//                    case 9:
//                        packet.setGravity(2);
//                        packet.setxCoordinate(86);
//                        packet.setyCoordinate(157);
//                        break;
//                }

                ApplicationLayerCustomUiPacket packet = new ApplicationLayerCustomUiPacket();
                packet.setGravity(1);
                packet.setTimeColor(0);
                packet.setxCoordinate(77);
                packet.setyCoordinate(37);
                WristbandManager.getInstance().setCustomUi(packet);

                // 设置新表盘位置，mode = WristbandManager.OTA_MODE_DIAL_MARKET_RESOURCES 情况下为固定 faceCount + 1
                // The watch face OTA is successful, set the new watch face index,
                // in the case of mode = WristbandManager.OTA_MODE_DIAL_MARKET_RESOURCES, it is fixed faceCount + 1
                WristbandManager.getInstance(CustomWatchFaceActivity.this).settingHomePager(faceCount + 1);
            }
        }).start();
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
                    Log.e(TAG, "onError type = " + type + ", code = " + code);
                    if (type == 65536 && code == 517) {
                        // 自定义表盘升级模式下，这个 type 和 code 也是成功
                        // In the custom dial upgrade mode, this type and code are also successful
                        onOTASuccess();
                    } else {
                        // 其它都是错误 Everything else is wrong
                    }
                }

                @Override
                public void onProcessStateChanged(int i, Throughput throughput) {
                    super.onProcessStateChanged(i, throughput);
                    Log.e("SSSS", "progress state = " + i);
                    if (i == PROGRESS_ACTIVE_IMAGE_AND_RESET) {
                        // success
                        onOTASuccess();
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
                Toast.makeText(this, "bin file error", Toast.LENGTH_SHORT).show();
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
