package com.wosmart.sdkdemo.common;

import android.app.Dialog;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.Toast;

import com.wosmart.sdkdemo.R;
import com.wosmart.ukprotocollibary.util.SDKLogger;

public class BaseActivity extends AppCompatActivity {

    private Dialog progress;

    protected void showToast(String content) {
        showToast(content, Toast.LENGTH_SHORT);
    }


    protected void showToast(String content, int duration) {
        Toast.makeText(this, content, duration).show();
    }

    protected void showProgress() {
        if (null == progress) {
            progress = new Dialog(this, R.style.centerDialog);
            View view_progress = LayoutInflater.from(this).inflate(R.layout.view_progress, null);
            progress.setContentView(view_progress);
            progress.setCanceledOnTouchOutside(false);
            progress.setCancelable(true);
        }
        progress.show();
    }

    protected void dismissProgress() {
        if (null != progress && progress.isShowing()) {
            progress.dismiss();
        }
    }

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        SDKLogger.setContext(this);
    }
}
