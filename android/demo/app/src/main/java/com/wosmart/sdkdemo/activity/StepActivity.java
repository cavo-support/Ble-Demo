package com.wosmart.sdkdemo.activity;

import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import androidx.annotation.Nullable;
import androidx.appcompat.widget.Toolbar;
import android.util.Log;
import android.view.View;
import android.widget.Button;

import com.wosmart.sdkdemo.common.BaseActivity;
import com.wosmart.sdkdemo.R;
import com.wosmart.ukprotocollibary.WristbandManager;
import com.wosmart.ukprotocollibary.WristbandManagerCallback;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerBeginPacket;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerStepPacket;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerTodaySumSportPacket;
import com.wosmart.ukprotocollibary.model.db.GlobalGreenDAO;
import com.wosmart.ukprotocollibary.model.sport.SportData;

import java.util.Calendar;
import java.util.List;

public class StepActivity extends BaseActivity implements View.OnClickListener {
    private String tag = "StepActivity";

    private Toolbar toolbar;

    private Button btn_sync_current;

    private Button btn_read_history;

    private Handler handler;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_step);
        initView();
        initData();
        addListener();
    }

    private void initView() {
        toolbar = findViewById(R.id.toolbar);
        btn_sync_current = findViewById(R.id.btn_sync_current);
        btn_read_history = findViewById(R.id.btn_read_history);
    }

    private void initData() {
        handler = new MyHandler();
        WristbandManager.getInstance(this).registerCallback(new WristbandManagerCallback() {

            @Override
            public void onSyncDataBegin(ApplicationLayerBeginPacket packet) {
                super.onSyncDataBegin(packet);
                // start sync
            }

            @Override
            public void onStepDataReceiveIndication(ApplicationLayerStepPacket packet) {
                super.onStepDataReceiveIndication(packet);
                // we will receive step info in sync progress,you can save it by yourself
            }

            @Override
            public void onSyncDataEnd(ApplicationLayerTodaySumSportPacket packet) {
                super.onSyncDataEnd(packet);
                // after sync, we can get step from sdk database
                readStepLocal();
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
        btn_sync_current.setOnClickListener(this);
        btn_read_history.setOnClickListener(this);
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.btn_sync_current:
                syncCurrent();
                break;
            case R.id.btn_read_history:
                readStepLocal();
                break;
        }
    }

    private void syncCurrent() {
        Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                // request sync health data
                if (WristbandManager.getInstance(StepActivity.this).sendDataRequest()) {
                    handler.sendEmptyMessage(0x01);
                } else {
                    handler.sendEmptyMessage(0x02);
                }
            }
        });
        thread.start();
    }

    private void readStepLocal() {
        Calendar calendar = Calendar.getInstance();
        int year = calendar.get(Calendar.YEAR);
        int month = calendar.get(Calendar.MONTH) + 1;
        int day = calendar.get(Calendar.DAY_OF_MONTH);

        List<SportData> steps = GlobalGreenDAO.getInstance().loadSportDataByDate(year, month, day);

        if (null != steps) {
            for (SportData item : steps) {
                Log.i(tag, "item = " + item.toString());
            }
        }
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
