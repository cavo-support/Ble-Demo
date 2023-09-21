package com.wosmart.sdkdemo.activity;

import android.os.Bundle;
import androidx.annotation.Nullable;
import androidx.appcompat.widget.Toolbar;
import android.text.TextUtils;
import android.util.Log;
import android.view.View;
import android.widget.ProgressBar;
import android.widget.TextView;

import com.realsil.sdk.dfu.model.DfuConfig;
import com.realsil.sdk.dfu.model.DfuProgressInfo;
import com.realsil.sdk.dfu.model.OtaDeviceInfo;
import com.realsil.sdk.dfu.model.Throughput;
import com.realsil.sdk.dfu.utils.DfuAdapter;
import com.realsil.sdk.dfu.utils.GattDfuAdapter;
import com.wosmart.sdkdemo.App;
import com.wosmart.sdkdemo.R;
import com.wosmart.sdkdemo.common.BaseActivity;
import com.wosmart.ukprotocollibary.WristbandManager;
import com.wosmart.ukprotocollibary.WristbandManagerCallback;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerDeviceInfoPacket;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

import static com.realsil.sdk.dfu.DfuConstants.PROGRESS_ACTIVE_IMAGE_AND_RESET;


/**
 *
 * 0. read device info to get device version code
 *    compare the device version code to your latest version code(you can save it to your app or get it from you web service).
 *
 * 1. check ota sdk {@link App#onCreate()}
 *    we have init ota sdk at App，if you want to use it, you can init ota sdk at application.
 *    and you should add DfuService in AndroidManifest.xml
 *    the ota file should match you smart watch
 *
 * 2. prepare ota file {@link FirmwareUpgradeOtaActivity#prepareOtaFile}
 *    we save it at asset now, maybe you will download it in internet
 *
 * 3. init ota sdk service {@link FirmwareUpgradeOtaActivity#initUkOta}
 *
 */
public class FirmwareUpgradeOtaActivity extends BaseActivity {

    private String mac;

    private ProgressBar progressBar;

    private TextView statusTv;

    private GattDfuAdapter dfuHelper;

    private DfuAdapter.DfuHelperCallback dfuHelperCallback;

    private DfuConfig dfuConfig;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_firmware_upgrade_ota);

        mac = getIntent().getStringExtra("mac");

        if (TextUtils.isEmpty(mac)) {
            finish();
            return;
        }

        progressBar = findViewById(R.id.progressBar);

        statusTv = findViewById(R.id.tv_status);

        findViewById(R.id.btn_firmware_upgrade).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                checkVersion();
            }
        });

        boolean connect = WristbandManager.getInstance().isConnect();
        Log.e("EEEEE", "isConnect = " + connect);
    }

    private void checkVersion() {
        WristbandManager.getInstance().registerCallback(new WristbandManagerCallback() {

            @Override
            public void onDeviceInfo(ApplicationLayerDeviceInfoPacket packet) {
                super.onDeviceInfo(packet);

                int curVersionCode = packet.getVersionCode();
                String curVersionName = packet.getVersionName();

                // compare the device version code to your latest version code(you can save it to your app or get it from you web service)
                int yourVersionCode = 0;
                if (yourVersionCode > curVersionCode) {
                    startOta();
                }
            }
        });

        WristbandManager.getInstance().requestDeviceInfo();
    }

    private void startOta() {
        // we have init ota sdk at App，if you want to use it, you can init ota sdk at application.
        // and you should add DfuService in AndroidManifest.xml
        // the ota file should match you smart watch
        if (!WristbandManager.getInstance().isOpenBt() || !WristbandManager.getInstance().isConnect()) {
            // device not connect
            return;
        }

        prepareOtaFile();
    }

    public void prepareOtaFile() {
        String binFileName = "V101_3.6.3.0.bin";// we save it at asset now, you will download it in internet
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

    /**
     * init ota service
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
                        // ready to ota,
                        startUkOta(mac, otaFilePath);
                        runOnUiThread(new Runnable() {
                            @Override
                            public void run() {
                                statusTv.setText("transfer ota files");
                            }
                        });
                    }
                }

                @Override
                public void onTargetInfoChanged(OtaDeviceInfo otaDeviceInfo) {
                    super.onTargetInfoChanged(otaDeviceInfo);
                }

                @Override
                public void onError(final int i, int i1) {
                    super.onError(i, i1);
                    // fail
                    Log.e("AAAA", "firmware upgrade ota error = " + i);

                    runOnUiThread(new Runnable() {
                        @Override
                        public void run() {
                            statusTv.setText("firmware upgrade ota error = " + i);
                        }
                    });
                }

                @Override
                public void onProcessStateChanged(int i, Throughput throughput) {
                    super.onProcessStateChanged(i, throughput);
                    if (i == PROGRESS_ACTIVE_IMAGE_AND_RESET) {
                        // success
                        Log.e("AAAA", "firmware upgrade ota success");

                        runOnUiThread(new Runnable() {
                            @Override
                            public void run() {
                                statusTv.setText("firmware upgrade ota success");
                            }
                        });
                    }
                }

                @Override
                public void onProgressChanged(final DfuProgressInfo dfuProgressInfo) {
                    super.onProgressChanged(dfuProgressInfo);
                    // progress info
                    Log.e("AAAA", "firmware upgrade ota onProgressChanged progress = " + dfuProgressInfo.toString());
                    runOnUiThread(new Runnable() {
                        @Override
                        public void run() {
                            statusTv.setText("onProgressChanged = " + dfuProgressInfo.getProgress());
                            progressBar.setProgress(dfuProgressInfo.getProgress(), true);
                        }
                    });
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

}
