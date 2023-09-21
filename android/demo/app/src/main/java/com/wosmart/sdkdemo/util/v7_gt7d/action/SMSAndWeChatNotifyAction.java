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

public class SMSAndWeChatNotifyAction extends BaseActivity {

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        WristbandManager.getInstance().registerCallback(new WristbandManagerCallback() {

            @Override
            public void onNotifyModeSettingReceive(ApplicationLayerNotifyPacket applicationLayerNotifyPacket) {
                super.onNotifyModeSettingReceive(applicationLayerNotifyPacket);
                // 各软件通知开关配置
                DeviceFunctionStatus sms = applicationLayerNotifyPacket.getSms();
                if (sms == DeviceFunctionStatus.SUPPORT_OPEN) {
                    // 已经打开短信提醒
                }
                DeviceFunctionStatus weChat = applicationLayerNotifyPacket.getWeChat();
                if (weChat == DeviceFunctionStatus.SUPPORT_OPEN) {
                    // 已经打开微信提醒
                }
            }
        });

        new Thread(new Runnable() {
            @Override
            public void run() {
                // 请求各通知开关配置，建议连接完设置后获取一次，然后全局缓存
                WristbandManager.getInstance().sendNotifyModeRequest();

                // 通知来电
                WristbandManager.getInstance().sendOtherNotifyInfo(NotifyType.SMS, "18025481234 来短信了");
                WristbandManager.getInstance().sendOtherNotifyInfo(NotifyType.WECHAT, "18025481234 给你发微信了");
            }
        }).start();
    }


}
