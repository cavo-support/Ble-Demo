package com.wosmart.sdkdemo.activity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;

import androidx.annotation.Nullable;

import com.wosmart.sdkdemo.R;
import com.wosmart.sdkdemo.common.BaseActivity;

public class WatchFaceActivity extends BaseActivity {

    public static final int FUNCTION_ID = 48;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_watch_face);

        findViewById(R.id.btn_built_in_watch_face).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                startActivity(new Intent(WatchFaceActivity.this, BuiltInWatchFaceActivity.class));
            }
        });

        findViewById(R.id.btn_market_watch_face).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                startActivity(new Intent(WatchFaceActivity.this, MarketWatchFaceActivity.class));
            }
        });

        findViewById(R.id.btn_custom_watch_face).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                startActivity(new Intent(WatchFaceActivity.this, CustomWatchFaceActivity.class));
            }
        });
    }
}
