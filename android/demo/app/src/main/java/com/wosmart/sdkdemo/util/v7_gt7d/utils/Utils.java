package com.wosmart.sdkdemo.util.v7_gt7d.utils;

import com.wosmart.sdkdemo.App;
import com.wosmart.ukprotocollibary.WristbandManager;
import com.wosmart.ukprotocollibary.WristbandManagerCallback;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerDeviceStatusPacket;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerReadHealthPacket;

public class Utils {

    public static boolean isSyncHealthData = false;

    public static boolean isLowPowerMode = false;

    public static int batteryLevel = 0;

    /**
     * 判断是否正在同步数据
     */
    public static boolean isSyncHealthData() {
        return isSyncHealthData;
    }

    /**
     * 判断设备是否正忙
     */
    public static boolean checkHealthStatus(ApplicationLayerReadHealthPacket readHealthPacket) {
        if (readHealthPacket == null) {
            return false;
        }
        return readHealthPacket.getEcgTestIng() == 1 || readHealthPacket.getSportIng() == 1 || readHealthPacket.getSpo2ManualIng() == 1 || readHealthPacket.getBpManualIng() == 1 || readHealthPacket.getHrpManualIng() == 1 || readHealthPacket.getPressureManualIng() == 1 || readHealthPacket.getGluTestIng1() == 1 || readHealthPacket.getPulseIng() == 1;
    }

    /**
     * 判断设备是否为低功耗模式或者电量低
     *
     * @return true
     */
    public static boolean checkPowerStatus() {
        WristbandManager.getInstance(App.getInstance()).registerCallback(new WristbandManagerCallback() {

            @Override
            public void onDeviceStatus(ApplicationLayerDeviceStatusPacket packet) {
                super.onDeviceStatus(packet);
            }
        });
        // 获取设备状态
        WristbandManager.getInstance(App.getInstance()).readDeviceStatus();
        return isLowPowerMode || batteryLevel <= 5;
    }

}
