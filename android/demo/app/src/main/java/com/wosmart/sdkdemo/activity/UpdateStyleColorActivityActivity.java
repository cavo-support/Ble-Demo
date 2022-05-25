package com.wosmart.sdkdemo.activity;

import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.support.annotation.Nullable;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.View;
import android.widget.CompoundButton;
import android.widget.Switch;
import android.widget.TextView;

import com.wosmart.sdkdemo.R;
import com.wosmart.sdkdemo.adapter.UpdateStyleColorAdapter;
import com.wosmart.sdkdemo.common.BaseActivity;
import com.wosmart.sdkdemo.model.StyleColor;
import com.wosmart.sdkdemo.util.ClsUtils;
import com.wosmart.ukprotocollibary.WristbandManager;
import com.wosmart.ukprotocollibary.WristbandManagerCallback;
import com.wosmart.ukprotocollibary.util.DataConverter;

import java.util.ArrayList;
import java.util.List;

public class UpdateStyleColorActivityActivity extends BaseActivity implements View.OnClickListener {
    private String tag = "UpdateStyleColorActivityActivity";

    private Toolbar toolbar;
    private Handler handler;
    private RecyclerView rcy_color_select;
    private UpdateStyleColorAdapter adapter;
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_style_color);
        initView();
        initData();
        addListener();
    }

    private void initView() {
        toolbar = findViewById(R.id.toolbar);
        rcy_color_select = findViewById(R.id.rcy_color_select);
    }

    private void initData() {
        handler = new MyHandler();
        List<StyleColor> colors = new ArrayList<>();
        StyleColor color0 = new StyleColor(0,getResources().getString(R.string.app_default_text),true);
        StyleColor color1 = new StyleColor(1,"M:100--Y:100",false);
        StyleColor color2 = new StyleColor(2,"M:75--Y:100",false);
        StyleColor color3 = new StyleColor(3,"Y:100",false);
        StyleColor color4 = new StyleColor(4,"C:75--Y:100",false);
        StyleColor color5 = new StyleColor(5,"C:100--M:50",false);
        StyleColor color6 = new StyleColor(6,"C:100--M:100",false);
        StyleColor color7 = new StyleColor(7,"C:60--M:90",false);
        colors.add(color0);
        colors.add(color1);
        colors.add(color2);
        colors.add(color3);
        colors.add(color4);
        colors.add(color5);
        colors.add(color6);
        colors.add(color7);
        adapter = new UpdateStyleColorAdapter(this,colors);
        rcy_color_select.setLayoutManager(new LinearLayoutManager(this));
        rcy_color_select.setAdapter(adapter);
    }

    private void addListener() {
        toolbar.setNavigationOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                finish();
            }
        });
        adapter.setListener(new UpdateStyleColorAdapter.onItemClickListener() {
            @Override
            public void onItemClick(int pos) {
                if(ClsUtils.isConnect) {
                    Message message = new Message();
                    message.what = 0x01;
                    message.arg1 = pos;
                    handler.sendMessage(message);
                }else{
                    showToast(getResources().getString(R.string.app_connect_device_not));
                }
            }
        });
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {

        }
    }

    private class MyHandler extends Handler {
        @Override
        public void handleMessage(Message msg) {
            super.handleMessage(msg);
            switch (msg.what) {
                case 0x01:
                    WristbandManager.getInstance(UpdateStyleColorActivityActivity.this).setCustomStyleColor(msg.arg1);
                    showToast(getString(R.string.app_success));
                    break;
            }
        }
    }

}
