package com.wosmart.sdkdemo.activity;

import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.TextView;

import androidx.annotation.Nullable;
import androidx.appcompat.widget.Toolbar;

import com.wosmart.sdkdemo.R;
import com.wosmart.sdkdemo.common.BaseActivity;
import com.wosmart.ukprotocollibary.WristbandManager;
import com.wosmart.ukprotocollibary.WristbandManagerCallback;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerFunctionPacket;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerTodaySumSportPacket;
import com.wosmart.ukprotocollibary.model.db.GlobalGreenDAO;
import com.wosmart.ukprotocollibary.model.db.JWHealthDataManager;
import com.wosmart.ukprotocollibary.model.enums.DeviceFunctionStatus;
import com.wosmart.ukprotocollibary.v2.JWHealthDataSearchParams;
import com.wosmart.ukprotocollibary.v2.JWValueCallback;
import com.wosmart.ukprotocollibary.v2.common.executor.JWArchTaskExecutor;
import com.wosmart.ukprotocollibary.v2.entity.JWHRVRmssdInfo;
import com.wosmart.ukprotocollibary.v2.entity.JWHealthData;
import com.wosmart.ukprotocollibary.v2.entity.JWSaunaInfo;

import java.util.Calendar;
import java.util.List;

public class HRVRmssdActivity extends BaseActivity implements View.OnClickListener {

    public static final int FUNCTION_ID = 49;

    private static final String TAG = "HRVRmssdActivity";

    private Toolbar toolbar;

    private TextView logTv;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_hrv_rmssd);
        initView();
        initData();
        addListener();

        readHRVRmssdConfig();
    }

    private void initData() {
        // make sure you have logged in successfully before performing synchronization
        // 执行同步前确保已经登录成功 WristbandManager.getInstance().startLoginProcess("1234567890");
        // HRV RMSSD data can only be obtained after synchronization is completed
        // 在同步完成后才能获取到 hrv rmssd 数据
        WristbandManager.getInstance().sendDataRequest();
        WristbandManager.getInstance().registerCallback(new WristbandManagerCallback() {

            @Override
            public void onReadHRVRmssdConfigRsp(boolean enable, int interval) {
                super.onReadHRVRmssdConfigRsp(enable, interval);
                Log.e(TAG, "enable = " + enable + ", interval = " + interval);
                logTv.setText("enable = " + enable + ", interval = " + interval);
            }

            @Override
            public void onSyncHRVRmssdDataReceived(List<JWHRVRmssdInfo> dataList) {
                super.onSyncHRVRmssdDataReceived(dataList);
                Log.e(TAG, "onSyncHRVRmssdDataReceived, dataList = " + (dataList != null ? dataList.toString() : ""));
                if (dataList == null || dataList.isEmpty()) {
                    return;
                }
                StringBuilder sb = new StringBuilder();
                for (JWHRVRmssdInfo data : dataList) {
                    sb.append("value = " + data.value + ", time = " + data.time + "\n");
                }
                logTv.setText(sb.toString());
            }
        });

    }

    /**
     * set hrv rmssd
     *
     * @param enable true is open
     * @param interval only support 5 min/times, 10 min/times, 15 min/times
     */
    public void setHRVRmssd(boolean enable, int interval) {
        JWArchTaskExecutor.getIOThreadExecutor().execute(new Runnable() {
            @Override
            public void run() {
                WristbandManager.getInstance().setHRVRmssd(enable, interval);
            }
        });
    }

    private void readHRVRmssdConfig() {
        JWArchTaskExecutor.getIOThreadExecutor().execute(new Runnable() {
            @Override
            public void run() {
                WristbandManager.getInstance().readHRVRmssdConfig();
            }
        });
    }

    private void getHRVRmssdHistory() {
        Calendar calendar = Calendar.getInstance();
        int year = calendar.get(Calendar.YEAR);
        int month = calendar.get(Calendar.MONTH) + 1;
        int day = calendar.get(Calendar.DAY_OF_MONTH);

        // after sync hrv rmssd data, you can get special sauna data by date from SDK database
        JWHealthDataManager.getInstance().getHistoryHRVRmssdListByDate(year, month, day, new JWValueCallback<List<JWHRVRmssdInfo>>() {
            @Override
            public void onSuccess(List<JWHRVRmssdInfo> dataList) {
                if (dataList == null || dataList.isEmpty()) {
                    return;
                }
                StringBuilder sb = new StringBuilder();
                for (JWHRVRmssdInfo data : dataList) {
                    sb.append("value = " + data.value + ", time = " + data.time + "\n");
                }
                logTv.setText(sb.toString());
            }

            @Override
            public void onError(int code, String desc) {

            }
        });

        // or custom params
        JWHealthDataSearchParams params = new JWHealthDataSearchParams();
        params.setDataType(JWHealthData.DateType.HRVRmssd);

        // start time
        params.setTimeBegin(calendar.getTimeInMillis());

        // one hour
        params.setTimePeriod(3600000);
        JWHealthDataManager.getInstance().getHistoryHRVRmssdList(params, new JWValueCallback<List<JWHRVRmssdInfo>>() {
            @Override
            public void onSuccess(List<JWHRVRmssdInfo> dataList) {
                if (dataList == null || dataList.isEmpty()) {
                    return;
                }
                StringBuilder sb = new StringBuilder();
                for (JWHRVRmssdInfo data : dataList) {
                    sb.append("value = " + data.value + ", time = " + data.time + "\n");
                }
                logTv.setText(sb.toString());
            }

            @Override
            public void onError(int code, String desc) {

            }
        });
    }

    private void initView() {
        toolbar = findViewById(R.id.toolbar);
        logTv = findViewById(R.id.tv_log);
    }



    private void addListener() {
        findViewById(R.id.btn_read_config).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                readHRVRmssdConfig();
            }
        });
        findViewById(R.id.btn_read_history).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                getHRVRmssdHistory();
            }
        });
        findViewById(R.id.btn_close).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                setHRVRmssd(false, 0);
            }
        });
        findViewById(R.id.btn_open_5).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                setHRVRmssd(true, 5);
            }
        });
        findViewById(R.id.btn_open_10).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                setHRVRmssd(true, 10);
            }
        });
        findViewById(R.id.btn_open_15).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                setHRVRmssd(true, 15);
            }
        });

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
