package com.wosmart.sdkdemo.util.v7_gt7d.action;

import android.os.Bundle;

import androidx.annotation.Nullable;

import com.wosmart.sdkdemo.App;
import com.wosmart.sdkdemo.common.BaseActivity;
import com.wosmart.ukprotocollibary.WristbandManager;
import com.wosmart.ukprotocollibary.WristbandManagerCallback;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerAlarm2Packet;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerFunctionPacket;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerSitPacket;
import com.wosmart.ukprotocollibary.model.enums.DeviceFunctionStatus;

public class AlarmAction extends BaseActivity {


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
        boolean isSupport = functionPacket.getAlarm() == DeviceFunctionStatus.SUPPORT;


    }

    private void readAlarm() {
        WristbandManager.getInstance().registerCallback(new WristbandManagerCallback() {

            @Override
            public void onAlarm2(ApplicationLayerAlarm2Packet alarm2) {
                super.onAlarm2(alarm2);
                // 2.0 闹钟返回
            }
        });
        new Thread(new Runnable() {
            @Override
            public void run() {
                WristbandManager.getInstance().requestAlarm2();
            }
        }).start();
    }

    private void setAlarm() {
        new Thread(new Runnable() {
            @Override
            public void run() {

                // 设置闹钟
                ApplicationLayerAlarm2Packet packet = new ApplicationLayerAlarm2Packet();
                packet.setmId(1);// 最多设置 8 个闹钟，需由 app 控制 id 唯一
                packet.setEnable(true);// true 打开
                packet.setmYear(23);// 从 2000 年开始，23 即 2023 年
                packet.setmMonth(6);
                packet.setmDay(17);
                packet.setmMinute(13);
                packet.setContent("闹钟标签");// 最多 15 字节
                // 与久坐提醒同样的 flags 设置模式，可以使用相同的常量
                // 设置每天都提醒，则 flags = ApplicationLayerSitPacket.REPETITION_ALL;
                // 删除该提醒，则 flags = ApplicationLayerSitPacket.REPETITION_NULL;
                // 如果设置星期一，星期三提醒，则 flags = ApplicationLayerSitPacket.REPETITION_MON | ApplicationLayerSitPacket.REPETITION_WED
                packet.setmDayFlags(ApplicationLayerSitPacket.REPETITION_ALL);// 由低 bit 位到高 bit 位，分别代表周一到周日的重复设置。bit 位为 1 表示重复，为 0 时表示不重复。所有 bit 都为 0 时，表示只在当天有效。
                WristbandManager.getInstance().setAlarm2(packet);

            }
        }).start();
    }

    private void modifyAlarm() {
        new Thread(new Runnable() {
            @Override
            public void run() {
                // 修改闹钟
                ApplicationLayerAlarm2Packet packet = new ApplicationLayerAlarm2Packet();
                packet.setmId(1);// 需由 app 记录需要修改的闹钟的 id
                packet.setEnable(true);// true 打开
                packet.setmYear(23);// 从 2000 年开始，23 即 2023 年
                packet.setmMonth(6);
                packet.setmDay(19);
                packet.setmMinute(13);
                packet.setContent("闹钟标签");// 最多 15 字节
                // 与久坐提醒同样的 flags 设置模式，可以使用相同的常量
                // 设置每天都提醒，则 flags = ApplicationLayerSitPacket.REPETITION_ALL;
                // 删除该提醒，则 flags = ApplicationLayerSitPacket.REPETITION_NULL;
                // 如果设置星期一，星期三提醒，则 flags = ApplicationLayerSitPacket.REPETITION_MON | ApplicationLayerSitPacket.REPETITION_WED
                packet.setmDayFlags(ApplicationLayerSitPacket.REPETITION_ALL);// 由低 bit 位到高 bit 位，分别代表周一到周日的重复设置。bit 位为 1 表示重复，为 0 时表示不重复。所有 bit 都为 0 时，表示只在当天有效。
                WristbandManager.getInstance().setAlarm2(packet);


                // 删除闹钟，当 month 和 day 以及 day flags 同时设置为 0 的时候，意思是删除该闹钟。

            }
        }).start();
    }

    private void deleteAlarm() {
        new Thread(new Runnable() {
            @Override
            public void run() {
                // 修改闹钟
                ApplicationLayerAlarm2Packet packet = new ApplicationLayerAlarm2Packet();
                packet.setmId(1);// 需由 app 记录需要删除的闹钟的 id
                packet.setEnable(false);// true 打开
                packet.setmYear(0);
                packet.setmMonth(0);
                packet.setmDay(0);
                packet.setmMinute(0);
                packet.setContent(null);// 最多 15 字节
                packet.setmDayFlags(ApplicationLayerSitPacket.REPETITION_NULL);// 由低 bit 位到高 bit 位，分别代表周一到周日的重复设置。bit 位为 1 表示重复，为 0 时表示不重复。所有 bit 都为 0 时，表示只在当天有效。

                // 删除闹钟，当 month 和 day 以及 day flags 同时设置为 0 的时候，意思是删除该闹钟。
                WristbandManager.getInstance().setAlarm2(packet);
            }
        }).start();
    }

}
