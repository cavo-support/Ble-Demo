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

import com.wosmart.sdkdemo.common.BaseActivity;
import com.wosmart.sdkdemo.R;
import com.wosmart.ukprotocollibary.WristbandManager;
import com.wosmart.ukprotocollibary.WristbandManagerCallback;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerAlarmPacket;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerAlarmsPacket;


public class ClockActivity extends BaseActivity implements View.OnClickListener {
    private String tag = "tag";

    private Toolbar toolbar;

    private Button btn_read_clock;

    private EditText et_year;

    private EditText et_month;

    private EditText et_day;

    private EditText et_hour;

    private EditText et_minute;

    private CheckBox cb_sunday;

    private CheckBox cb_monday;

    private CheckBox cb_tuesday;

    private CheckBox cb_wednesday;

    private CheckBox cb_thursday;

    private CheckBox cb_friday;

    private CheckBox cb_saturday;

    private Button btn_send;

    private Handler handler;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_clock);
        initView();
        initData();
        addListener();
    }

    private void initView() {
        toolbar = findViewById(R.id.toolbar);
        btn_read_clock = findViewById(R.id.btn_read_clock);
        et_year = findViewById(R.id.et_year);
        et_month = findViewById(R.id.et_month);
        et_day = findViewById(R.id.et_day);
        et_hour = findViewById(R.id.et_hour);
        et_minute = findViewById(R.id.et_minute);
        cb_sunday = findViewById(R.id.cb_sunday);
        cb_monday = findViewById(R.id.cb_monday);
        cb_tuesday = findViewById(R.id.cb_tuesday);
        cb_wednesday = findViewById(R.id.cb_wednesday);
        cb_thursday = findViewById(R.id.cb_thursday);
        cb_friday = findViewById(R.id.cb_friday);
        cb_saturday = findViewById(R.id.cb_saturday);
        btn_send = findViewById(R.id.btn_send);
    }

    private void initData() {
        handler = new MyHandler();
        WristbandManager.getInstance(this).registerCallback(new WristbandManagerCallback() {
            @Override
            public void onAlarmsDataReceive(ApplicationLayerAlarmsPacket data) {
                super.onAlarmsDataReceive(data);
                Log.i(tag, "receiver alarm = " + data.toString());
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
        btn_read_clock.setOnClickListener(this);
        btn_send.setOnClickListener(this);
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.btn_read_clock:
                readClock();
                break;
            case R.id.btn_send:
                String yearStr = et_year.getText().toString();
                String monthStr = et_month.getText().toString();
                String dayStr = et_day.getText().toString();
                String hourStr = et_hour.getText().toString();
                String minuteStr = et_minute.getText().toString();

                boolean sundayFlag = cb_sunday.isChecked();
                boolean mondayFlag = cb_monday.isChecked();
                boolean tuesdayFlag = cb_tuesday.isChecked();
                boolean wednesdayFlag = cb_wednesday.isChecked();
                boolean thursdayFlag = cb_thursday.isChecked();
                boolean fridayFlag = cb_friday.isChecked();
                boolean saturdayFlag = cb_saturday.isChecked();

                if (null != yearStr && !yearStr.isEmpty()) {
                    if (null != monthStr && !monthStr.isEmpty()) {
                        if (null != dayStr && !dayStr.isEmpty()) {
                            if (null != hourStr && !hourStr.isEmpty()) {
                                if (null != minuteStr && !minuteStr.isEmpty()) {
                                    int startYear = Integer.parseInt(yearStr);
                                    int startMonth = Integer.parseInt(monthStr);
                                    int startDay = Integer.parseInt(dayStr);
                                    int startHour = Integer.parseInt(hourStr);
                                    int startMinute = Integer.parseInt(minuteStr);

                                    String repeatStr = "";
                                    if (sundayFlag) {
                                        repeatStr += "1";
                                    } else {
                                        repeatStr += "0";
                                    }
                                    if (mondayFlag) {
                                        repeatStr += "1";
                                    } else {
                                        repeatStr += "0";
                                    }
                                    if (tuesdayFlag) {
                                        repeatStr += "1";
                                    } else {
                                        repeatStr += "0";
                                    }
                                    if (wednesdayFlag) {
                                        repeatStr += "1";
                                    } else {
                                        repeatStr += "0";
                                    }
                                    if (thursdayFlag) {
                                        repeatStr += "1";
                                    } else {
                                        repeatStr += "0";
                                    }
                                    if (fridayFlag) {
                                        repeatStr += "1";
                                    } else {
                                        repeatStr += "0";
                                    }
                                    if (saturdayFlag) {
                                        repeatStr += "1";
                                    } else {
                                        repeatStr += "0";
                                    }

                                    ApplicationLayerAlarmsPacket clocks = new ApplicationLayerAlarmsPacket();
                                    ApplicationLayerAlarmPacket clock = new ApplicationLayerAlarmPacket();
                                    clock.setId(0);
                                    clock.setmYear(startYear);
                                    clock.setmMonth(startMonth);
                                    clock.setmDay(startDay);
                                    clock.setmHour(startHour);
                                    clock.setmMinute(startMinute);
                                    clock.setmDayFlags(parseRepeat(repeatStr));
                                    clocks.add(clock);

                                    setClock(clocks);
                                } else {
                                    showToast(getString(R.string.app_clock_hint_year));
                                }
                            } else {
                                showToast(getString(R.string.app_clock_hint_month));
                            }
                        } else {
                            showToast(getString(R.string.app_clock_hint_day));
                        }
                    } else {
                        showToast(getString(R.string.app_clock_hint_hour));
                    }
                } else {
                    showToast(getString(R.string.app_clock_hint_minute));
                }
                break;
        }
    }


    private void readClock() {
        Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                if (WristbandManager.getInstance(ClockActivity.this).setClocksSyncRequest()) {
                    handler.sendEmptyMessage(0x01);
                } else {
                    handler.sendEmptyMessage(0x02);
                }
            }
        });
        thread.start();
    }

    private void setClock(final ApplicationLayerAlarmsPacket clockData) {
        Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                if (WristbandManager.getInstance(ClockActivity.this).setClocks(clockData)) {
                    handler.sendEmptyMessage(0x01);
                } else {
                    handler.sendEmptyMessage(0x02);
                }
            }
        });
        thread.start();
    }

    private byte parseRepeat(String repeat) {
        int result = 0;
        if (null != repeat && repeat.length() == 7) {
            for (int i = 0; i < 7; i++) {
                String str = repeat.substring(i, i + 1);
                int value = Integer.parseInt(str);
                if (value == 1) {
                    result += Math.pow(2, 6 - i);
                }
            }
        }
        return (byte) (result & 0xFF);
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
