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
import com.wosmart.ukprotocollibary.model.enums.DeviceLanguage;

public class LanguageActivity extends BaseActivity implements View.OnClickListener {
    private String tag = "LanguageActivity";

    private Toolbar toolbar;
    private EditText et_language;
    private Button btn_set;

    private Handler handler;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_language);
        initView();
        initData();
        addListener();
    }

    private void initView() {
        toolbar = findViewById(R.id.toolbar);
        et_language = findViewById(R.id.et_language);
        btn_set = findViewById(R.id.btn_set);
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
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.btn_set:
                String languageStr = et_language.getText().toString();
                if (null != languageStr && !languageStr.isEmpty()) {
                    int language = Integer.parseInt(languageStr);
                    DeviceLanguage languageType;
                    if (language == 0) {
                        languageType = DeviceLanguage.LANGUAGE_SAMPLE_CHINESE;
                    } else if (language == 1) {
                        languageType = DeviceLanguage.LANGUAGE_TRADITIONAL_CHINESE;
                    } else if (language == 3) {
                        languageType = DeviceLanguage.LANGUAGE_SPANISH;
                    } else if (language == 4) {
                        languageType = DeviceLanguage.LANGUAGE_FRENCH;
                    } else if (language == 5) {
                        languageType = DeviceLanguage.LANGUAGE_GERMAN;
                    } else if (language == 6) {
                        languageType = DeviceLanguage.LANGUAGE_ITALIAN;
                    } else {
                        languageType = DeviceLanguage.LANGUAGE_ENGLISH;
                    }
                    setLanguage(languageType);
                } else {
                    showToast(getString(R.string.app_language_hint));
                }
                break;
        }
    }

    private void setLanguage(final DeviceLanguage language) {
        Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                if (WristbandManager.getInstance(LanguageActivity.this).settingLanguage(language)) {
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
