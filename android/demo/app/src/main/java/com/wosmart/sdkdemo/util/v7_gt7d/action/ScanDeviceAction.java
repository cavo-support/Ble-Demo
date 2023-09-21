package com.wosmart.sdkdemo.util.v7_gt7d.action;

import android.bluetooth.BluetoothDevice;
import android.bluetooth.le.ScanRecord;
import android.os.Build;
import android.os.Bundle;
import android.util.Log;

import androidx.annotation.Nullable;

import com.wosmart.sdkdemo.common.BaseActivity;
import com.wosmart.sdkdemo.model.SearchResult;
import com.wosmart.ukprotocollibary.WristbandManager;
import com.wosmart.ukprotocollibary.WristbandScanCallback;

import java.util.Collections;

public class ScanDeviceAction extends BaseActivity {

    @Override
    protected void onDestroy() {
        super.onDestroy();

        // 注意连接设备前或退出界面要取消扫描
        WristbandManager.getInstance().stopScan();
    }

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        scanDevice();
    }

    private void scanDevice() {
        WristbandManager.getInstance().startScan(true, new WristbandScanCallback() {
            @Override
            public void onWristbandDeviceFind(BluetoothDevice device, int rssi, byte[] scanRecord) {
                super.onWristbandDeviceFind(device, rssi, scanRecord);
                // 因 Android 系统版本原因，搜索蓝牙设备会有两种回调
                // 在 android.os.Build.VERSION.SDK_INT < Build.VERSION_CODES.LOLLIPOP 使用这个回调
            }

            @Override
            public void onWristbandDeviceFind(BluetoothDevice device, int rssi, ScanRecord scanRecord) {
                super.onWristbandDeviceFind(device, rssi, scanRecord);
                // 在 android.os.Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP 使用这个回调
            }

            @Override
            public void onLeScanEnable(boolean enable) {
                super.onLeScanEnable(enable);

            }

            @Override
            public void onWristbandLoginStateChange(boolean connected) {
                super.onWristbandLoginStateChange(connected);
            }

            @Override
            public void onStartLeScan() {
                super.onStartLeScan();
            }

            @Override
            public void onStopLeScan() {
                super.onStopLeScan();
            }

            @Override
            public void onCancelLeScan() {
                super.onCancelLeScan();
            }
        });
    }

}
