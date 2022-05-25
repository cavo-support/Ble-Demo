package com.wosmart.sdkdemo.activity;

import android.Manifest;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.Build;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.v4.app.ActivityCompat;
import android.support.v4.content.ContextCompat;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.wosmart.sdkdemo.common.BaseActivity;
import com.wosmart.sdkdemo.R;
import com.wosmart.sdkdemo.util.ClsUtils;
import com.wosmart.ukprotocollibary.WristbandManager;

public class MainActivity extends BaseActivity implements View.OnClickListener {

    private TextView tv_log;

    private Button btn_function;

    private Button btn_scan;

    private String mac = "";

    private String name = "";

    private boolean connectFlag;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        initView();

        initData();

        addListener();
    }

    private void initView() {
        tv_log = findViewById(R.id.tv_log);

        btn_function = findViewById(R.id.btn_function);

        btn_scan = findViewById(R.id.btn_scan);
    }

    private void initData() {
        checkStoragePermission();

    }

    private void addListener() {
        btn_function.setOnClickListener(this);
        btn_scan.setOnClickListener(this);
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == 0x01 && resultCode == 0x02) {
            mac = data.getStringExtra("mac");
            name = data.getStringExtra("name");
            connectFlag = true;
            ClsUtils.isConnect = true;
            appendLog("connected mac = " + mac);
            btn_scan.setText(getString(R.string.app_disconnect));
        }
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.btn_function:
                Intent function = new Intent();
                function.setClass(this, FunctionActivity.class);
                function.putExtra("mac", mac);
                function.putExtra("name", name);
                startActivity(function);
                break;
            case R.id.btn_scan:
                if (connectFlag) {
                    disConnect();
                } else {
                    Intent intent = new Intent();
                    intent.setClass(this, ScanActivity.class);
                    startActivityForResult(intent, 0x01);
                }
                break;
        }
    }

    private void checkLocationPermission() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            if (ContextCompat.checkSelfPermission(getApplication().getApplicationContext(), Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED || ContextCompat.checkSelfPermission(getApplicationContext(), Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
                ActivityCompat.requestPermissions(MainActivity.this, new String[]{Manifest.permission.ACCESS_COARSE_LOCATION, Manifest.permission.ACCESS_FINE_LOCATION}, 0x01);
            }
        }
    }

    private void checkStoragePermission() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            if (ContextCompat.checkSelfPermission(getApplicationContext(), Manifest.permission.WRITE_EXTERNAL_STORAGE) != PackageManager.PERMISSION_GRANTED || ContextCompat.checkSelfPermission(this, Manifest.permission.READ_EXTERNAL_STORAGE) != PackageManager.PERMISSION_GRANTED) {
                //未获得授权
                ActivityCompat.requestPermissions(this, new String[]{Manifest.permission.WRITE_EXTERNAL_STORAGE, Manifest.permission.WRITE_EXTERNAL_STORAGE}, 0x02);
            }
        }
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        Log.d("MainActivity","requestCode="+requestCode);
        if (requestCode == 0x02) {
            if (grantResults.length > 0) {
                if (grantResults[0] != PackageManager.PERMISSION_GRANTED) {
                    showToast("获取存储权限失败，无法执行升级，请手动开启");
                }else{
                    checkLocationPermission();
                }
            } else {
                showToast("获取存储权限失败，无法执行升级，请手动开启");
            }
        }
    }

    private void disConnect() {
        WristbandManager.getInstance(this).close();
        connectFlag = false;
        btn_scan.setText(getString(R.string.app_scan));
        appendLog("disconnect device");
        this.mac = "";
        ClsUtils.isConnect = false;
    }

    private void appendLog(String appendStr) {
        String content = tv_log.getText().toString();
        content += appendStr + "\n";
        tv_log.setText(content);
    }
}
