package com.wosmart.sdkdemo.activity;

import android.bluetooth.BluetoothDevice;
import android.bluetooth.le.ScanRecord;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.widget.SwipeRefreshLayout;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.View;

import com.wosmart.sdkdemo.adapter.DeviceAdapter;
import com.wosmart.sdkdemo.common.BaseActivity;
import com.wosmart.sdkdemo.R;
import com.wosmart.sdkdemo.model.SearchResult;
import com.wosmart.ukprotocollibary.WristbandManager;
import com.wosmart.ukprotocollibary.WristbandManagerCallback;
import com.wosmart.ukprotocollibary.WristbandScanCallback;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

public class ScanActivity extends BaseActivity {

    private String tag = "ScanActivity";

    private Toolbar toolbar;

    private SwipeRefreshLayout srl_search;

    private RecyclerView rcy_device;

    private List<SearchResult> devices;

    private DeviceAdapter adapter;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_scan);

        toolbar = findViewById(R.id.toolbar);

        srl_search = findViewById(R.id.srl_search);

        srl_search.setOnRefreshListener(new SwipeRefreshLayout.OnRefreshListener() {
            @Override
            public void onRefresh() {
                devices.clear();
                adapter.notifyDataSetChanged();
                startScan();
            }
        });

        rcy_device = findViewById(R.id.rcy_device);
        rcy_device.setLayoutManager(new LinearLayoutManager(this));
        devices = new ArrayList<>();
        adapter = new DeviceAdapter(this, devices);
        adapter.setListener(new DeviceAdapter.onItemClickListener() {
            @Override
            public void onItemClick(int pos) {
                stopScan();
                showProgress();
                SearchResult result = devices.get(pos);
                connect(result.getAddress(), result.getName());
            }
        });
        rcy_device.setAdapter(adapter);

        toolbar.setNavigationOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                finish();
            }
        });
    }


    private void startScan() {
        WristbandManager.getInstance(this).startScan(true, new WristbandScanCallback() {
            @Override
            public void onWristbandDeviceFind(BluetoothDevice device, int rssi, byte[] scanRecord) {
                super.onWristbandDeviceFind(device, rssi, scanRecord);
                SearchResult result = new SearchResult(device, rssi, scanRecord);
                Log.d(tag+"1",result.toString());
                if (!devices.contains(result)) {
                    devices.add(result);
                    Collections.sort(devices, new RssiComparable());
                    adapter.notifyDataSetChanged();
                }
            }

            @Override
            public void onWristbandDeviceFind(BluetoothDevice device, int rssi, ScanRecord scanRecord) {
                super.onWristbandDeviceFind(device, rssi, scanRecord);
                SearchResult result = new SearchResult(device, rssi, null);
                Log.d(tag+"2",result.toString());
                if (!devices.contains(result)) {
                    devices.add(result);
                    Collections.sort(devices, new RssiComparable());
                    adapter.notifyDataSetChanged();
                }
            }

            @Override
            public void onLeScanEnable(boolean enable) {
                super.onLeScanEnable(enable);
                if (!enable) {
                    srl_search.setRefreshing(false);
                }
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

    private void stopScan() {
        WristbandManager.getInstance(this).stopScan();
    }

    private void connect(final String mac, final String name) {

        WristbandManager.getInstance(this).registerCallback(new WristbandManagerCallback() {
            @Override
            public void onConnectionStateChange(boolean status) {
                super.onConnectionStateChange(status);
                if (status) {
                    dismissProgress();
                    showToast(getString(R.string.app_connect_success));
                    Intent intent = new Intent();
                    intent.putExtra("mac", mac);
                    intent.putExtra("name", name);
                    setResult(0x02, intent);
                    ScanActivity.this.finish();
                } else {
                    dismissProgress();
                    showToast(getString(R.string.app_connect_fail));
                    disConnect();
                }
            }

            @Override
            public void onError(int error) {
                super.onError(error);
                showToast(getString(R.string.app_error));
            }
        });

        WristbandManager.getInstance(this).connect(mac);

    }

    private void disConnect() {
        WristbandManager.getInstance(this).close();
    }

    private class RssiComparable implements Comparator<SearchResult> {
        @Override
        public int compare(SearchResult o1, SearchResult o2) {
            return Integer.compare(o2.rssi, o1.rssi);
        }

        @Override
        public boolean equals(Object obj) {
            return false;
        }
    }

}
