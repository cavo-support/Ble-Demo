package com.wosmart.sdkdemo.activity;

import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import androidx.annotation.Nullable;
import androidx.appcompat.widget.Toolbar;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;

import com.wosmart.sdkdemo.common.BaseActivity;
import com.wosmart.sdkdemo.R;
import com.wosmart.ukprotocollibary.WristbandManager;

public class StepGoalActivity extends BaseActivity implements View.OnClickListener {

    private Toolbar toolbar;
    private EditText et_step_goal;
    private Button btn_set;
    private EditText et_sleep_goal;
    private Button btn_set_sleep;

    private Handler handler;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_step_goal);
        initView();
        initData();
        addListener();
    }

    private void initView() {
        toolbar = findViewById(R.id.toolbar);
        et_step_goal = findViewById(R.id.et_step_goal);
        btn_set = findViewById(R.id.btn_set);
        et_sleep_goal = findViewById(R.id.et_sleep_goal);
        btn_set_sleep = findViewById(R.id.btn_set_sleep);
    }

    private void initData() {
        handler = new MyHandler();
    }

    private void addListener() {
        toolbar.setNavigationOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                finish();
            }
        });
        btn_set.setOnClickListener(this);
        btn_set_sleep.setOnClickListener(this);
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.btn_set:
                String goalStr = et_step_goal.getText().toString();
                if (null != goalStr) {
                    int goal = Integer.parseInt(goalStr);
                    setStepGoal(goal);
                } else {
                    showToast(getString(R.string.app_goal_hint_step));
                }
                break;
            case R.id.btn_set_sleep:
                String goalStr2 = et_sleep_goal.getText().toString();
                if (null != goalStr2) {
                    int goal2 = Integer.parseInt(goalStr2);
                    setSleepGoal(goal2);
                } else {
                    showToast(getString(R.string.app_goal_hint_sleep));
                }
                break;
        }
    }

    private void setStepGoal(final int goal) {
        Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                if (WristbandManager.getInstance(StepGoalActivity.this).setTargetStep(goal)) {
                    handler.sendEmptyMessage(0x01);
                } else {
                    handler.sendEmptyMessage(0x02);
                }
            }
        });
        thread.start();
    }

    private void setSleepGoal(final int goal) {
        Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                if (WristbandManager.getInstance(StepGoalActivity.this).setTargetSleep(goal)) {
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
