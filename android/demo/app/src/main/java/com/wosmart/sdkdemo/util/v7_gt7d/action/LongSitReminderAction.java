package com.wosmart.sdkdemo.util.v7_gt7d.action;

import android.os.Bundle;

import androidx.annotation.Nullable;

import com.wosmart.sdkdemo.App;
import com.wosmart.sdkdemo.common.BaseActivity;
import com.wosmart.ukprotocollibary.WristbandManager;
import com.wosmart.ukprotocollibary.WristbandManagerCallback;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerFunctionPacket;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerSitPacket;
import com.wosmart.ukprotocollibary.model.enums.DeviceFunctionStatus;

public class LongSitReminderAction extends BaseActivity {


    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        ApplicationLayerFunctionPacket functionPacket = WristbandManager.getInstance().getFunctionPacket();
        if (functionPacket == null) {
            // 如果功能列表为空，必须先获取一次功能列表，然后用户可自行缓存该功能列表也可使用 SDK 缓存
            WristbandManager.getInstance().sendFunctionReq();
            return;
        }
        // 判断是否支持该功能
        boolean isSupport = functionPacket.getLongSitReminder() == DeviceFunctionStatus.SUPPORT;

        WristbandManager.getInstance().registerCallback(new WristbandManagerCallback() {

            @Override
            public void onLongSitSettingReceive(ApplicationLayerSitPacket packet) {
                super.onLongSitSettingReceive(packet);
                // 久坐提醒设置返回
            }
        });
        new Thread(new Runnable() {
            @Override
            public void run() {
                // 读取久坐提醒
                WristbandManager.getInstance().sendLongSitRequest();

                // 设置久坐提醒
                ApplicationLayerSitPacket packet = new ApplicationLayerSitPacket();

                packet.setmEnable(true);// true 开启，false 关闭
                packet.setmStartNotifyTime(8);// 开始时间，单位小时，24 小时制
                packet.setmStopNotifyTime(17);// 结束时间，单位小时，24 小时制
                packet.setmNotifyTime(1);// 间隔 0 - 65535，单位 分钟

                // 由低 bit 位到高 bit 位，分别代表周一到周日的重复设置。bit 位为 1 表示重复，为 0 时表示不重复。所有 bit 都为 0 时，表示只在当天有效。
                // 设置每天都提醒，则 flags = ApplicationLayerSitPacket.REPETITION_ALL;
                // 删除该提醒，则 flags = ApplicationLayerSitPacket.REPETITION_NULL;
                // 如果设置星期一，星期三提醒，则 flags = ApplicationLayerSitPacket.REPETITION_MON | ApplicationLayerSitPacket.REPETITION_WED
                packet.setmDayFlags(ApplicationLayerSitPacket.REPETITION_ALL);
                WristbandManager.getInstance().setLongSit(packet);
            }
        }).start();
    }


}
