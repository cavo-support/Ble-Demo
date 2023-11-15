package com.wosmart.sdkdemo.util.v7_gt7d.action;

import android.os.Bundle;

import androidx.annotation.Nullable;

import com.wosmart.sdkdemo.common.BaseActivity;
import com.wosmart.ukprotocollibary.WristbandManager;
import com.wosmart.ukprotocollibary.WristbandManagerCallback;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerSyncSwitchItemPacket;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerSyncSwitchPacket;

public class GluContinuousAction extends BaseActivity {


    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        // 血糖自动监测

        WristbandManager.getInstance().registerCallback(new WristbandManagerCallback() {

            @Override
            public void onSyncSwitch(ApplicationLayerSyncSwitchPacket packet) {
                super.onSyncSwitch(packet);
                // 设备开关状态返回，首次连接设备或设备开关有变化会自动触发此回调
                // 0--时间制式（12/24小时制）
                // 1--语言选择
                // 2--心率监测开关
                // 3--血压监测开关
                // 4--血氧监测开关
                // 5--温度监测开关
                // 6--温度补偿开关
                // 7--温度功能独立（不依赖心率测量）
                // 8--血糖监测开关
                // 9--手势亮屏开关（也叫转腕亮屏，抬手亮屏）
                // 10--尿酸监测开关
                // 11--血脂监测开关
                if (packet != null && packet.getItemPackets() != null) {
                    for (ApplicationLayerSyncSwitchItemPacket itemPacket : packet.getItemPackets()) {
                        if (itemPacket.getSwitchType() == 8) {
                            // 血糖开关状态，暂时还未定义常量，请导入注释包看具体含义
                            boolean enable = itemPacket.getSwitchValue() == 1;
                        }
                    }
                }
            }

            @Override
            public void onGluContinuous(boolean enable, int interval) {
                super.onGluContinuous(enable, interval);
                // 主动血糖自动监测开关状态返回
            }
        });

        // 打开血糖自动监测，间隔为 15 分钟
        WristbandManager.getInstance().setGluContinuous(true, 15);

        // 主动获取血糖自动监测状态，onGluContinuous 返回具体信息
        WristbandManager.getInstance().getGluContinuous();

        // 获取 SDK 缓存的各种数据开关状态信息，也可在 onSyncSwitch 监听获取
        WristbandManager.getInstance().getSyncSwitchPacket();
    }
}
