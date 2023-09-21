package com.wosmart.sdkdemo.util.v7_gt7d.action;

import android.os.Bundle;

import androidx.annotation.Nullable;

import com.wosmart.sdkdemo.App;
import com.wosmart.sdkdemo.common.BaseActivity;
import com.wosmart.ukprotocollibary.WristbandManager;
import com.wosmart.ukprotocollibary.WristbandManagerCallback;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerNotifyPacket;
import com.wosmart.ukprotocollibary.model.enums.DeviceFunctionStatus;
import com.wosmart.ukprotocollibary.model.enums.NotifyType;

public class CallNotifyAction extends BaseActivity {

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        WristbandManager.getInstance().registerCallback(new WristbandManagerCallback() {

            @Override
            public void onNotifyModeSettingReceive(ApplicationLayerNotifyPacket applicationLayerNotifyPacket) {
                super.onNotifyModeSettingReceive(applicationLayerNotifyPacket);
                // 各软件通知开关配置
                DeviceFunctionStatus call = applicationLayerNotifyPacket.getCall();
                if (call == DeviceFunctionStatus.SUPPORT_OPEN) {
                    // 已经打开来电提醒
                }
            }

            @Override
            public void onAcceptCall() {
                super.onAcceptCall();
                // 已接听
            }

            @Override
            public void onEndCall() {
                super.onEndCall();
                // 已拒绝
            }
        });

        new Thread(new Runnable() {
            @Override
            public void run() {
                // 请求各通知开关配置，建议连接完设置后获取一次，然后全局缓存
                WristbandManager.getInstance().sendNotifyModeRequest();

                // 通知来电
                WristbandManager.getInstance().sendOtherNotifyInfo(NotifyType.CALL, "18025481234 来电");
                WristbandManager.getInstance().sendCallNotifyInfo("18025481234 来电");
            }
        }).start();
    }


}
