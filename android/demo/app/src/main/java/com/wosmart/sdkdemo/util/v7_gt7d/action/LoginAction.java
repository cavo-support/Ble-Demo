package com.wosmart.sdkdemo.util.v7_gt7d.action;

import android.os.Bundle;

import androidx.annotation.Nullable;

import com.wosmart.sdkdemo.common.BaseActivity;
import com.wosmart.ukprotocollibary.WristbandManager;
import com.wosmart.ukprotocollibary.WristbandManagerCallback;

public class LoginAction extends BaseActivity {


    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        WristbandManager.getInstance(this).registerCallback(new WristbandManagerCallback() {

            @Override
            public void onLoginStateChange(int state) {
                super.onLoginStateChange(state);
                // 此回调会触发多次，登录流程只需关心下面这个状态码，其它的回调都是无效的
                if (state == WristbandManager.STATE_WRIST_LOGIN) {
                    // 登录成功
                }
            }

            @Override
            public void onError(int error) {
                super.onError(error);
                // 登录错误回调在这里返回
                if (error == WristbandManager.ERROR_CODE_NO_LOGIN_RESPONSE_COME) {
                    // 登录无响应(设备无回应)
                } else if (error == WristbandManager.ERROR_CODE_BOND_ERROR) {
                    // 绑定失败
                }
            }
        });
    }

    private void login(String userID) {
        // 连接设备成功后即可发起登录流程
        WristbandManager.getInstance(this).startLoginProcess(userID);
    }

}
