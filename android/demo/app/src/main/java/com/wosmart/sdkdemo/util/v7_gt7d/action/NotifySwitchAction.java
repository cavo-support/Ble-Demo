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

public class NotifySwitchAction extends BaseActivity {

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        WristbandManager.getInstance().registerCallback(new WristbandManagerCallback() {

            @Override
            public void onNotifyModeSettingReceive(ApplicationLayerNotifyPacket applicationLayerNotifyPacket) {
                super.onNotifyModeSettingReceive(applicationLayerNotifyPacket);
                // 各软件通知开关配置
                DeviceFunctionStatus weChat = applicationLayerNotifyPacket.getWeChat();
                if (weChat == DeviceFunctionStatus.UN_SUPPORT) {
                    // 不支持
                } else {
                    if (weChat == DeviceFunctionStatus.SUPPORT_OPEN) {
                        // 开启
                    } else if (weChat == DeviceFunctionStatus.SUPPORT_CLOSE) {
                        // 关闭
                    }
                }
            }
        });

        new Thread(new Runnable() {
            @Override
            public void run() {
                // 请求各通知开关配置，建议连接完设置后获取一次，然后全局缓存
                WristbandManager.getInstance().sendNotifyModeRequest();

                // 设置单个通知配置
                WristbandManager.getInstance().setNotifyMode(NotifyType.WECHAT, true);

                ApplicationLayerNotifyPacket packet = new ApplicationLayerNotifyPacket();
                packet.setCall(DeviceFunctionStatus.SUPPORT_OPEN);
                packet.setSms(DeviceFunctionStatus.SUPPORT_OPEN);
                packet.setQQ(DeviceFunctionStatus.SUPPORT_OPEN);
                packet.setWeChat(DeviceFunctionStatus.SUPPORT_OPEN);
                packet.setLine(DeviceFunctionStatus.SUPPORT_OPEN);
                packet.setTwitter(DeviceFunctionStatus.SUPPORT_OPEN);
                packet.setFacebook(DeviceFunctionStatus.SUPPORT_OPEN);
                packet.setMessenger(DeviceFunctionStatus.SUPPORT_OPEN);

                // 一次性设置多个通知配置
                WristbandManager.getInstance().setAllNotify(packet);
            }
        }).start();
        

    }
}
