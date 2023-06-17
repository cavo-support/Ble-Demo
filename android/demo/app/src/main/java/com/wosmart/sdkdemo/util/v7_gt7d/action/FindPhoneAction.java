package com.wosmart.sdkdemo.util.v7_gt7d.action;

import android.os.Bundle;

import androidx.annotation.Nullable;

import com.wosmart.sdkdemo.App;
import com.wosmart.sdkdemo.common.BaseActivity;
import com.wosmart.ukprotocollibary.WristbandManager;
import com.wosmart.ukprotocollibary.WristbandManagerCallback;

public class FindPhoneAction extends BaseActivity {

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        WristbandManager.getInstance(App.getInstance()).registerCallback(new WristbandManagerCallback() {

            @Override
            public void onFindPhone() {
                super.onFindPhone();
                // 老版本，设备呼叫手机
            }

            @Override
            public void onFindPhone(int status) {
                super.onFindPhone(status);
                // 新版本带状态，status == 0 关闭查找手机 == 1 打开查找手机
            }
        });
    }
}
