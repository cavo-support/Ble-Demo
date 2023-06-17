package com.wosmart.sdkdemo.util.v7_gt7d.action;

import android.os.Bundle;

import androidx.annotation.Nullable;

import com.wosmart.sdkdemo.App;
import com.wosmart.sdkdemo.common.BaseActivity;
import com.wosmart.ukprotocollibary.WristbandManager;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerFunctionPacket;
import com.wosmart.ukprotocollibary.model.enums.DeviceFunctionStatus;
import com.wosmart.ukprotocollibary.v2.JWCallback;
import com.wosmart.ukprotocollibary.v2.entity.JWWeatherInfo;

public class WeatherSetAction extends BaseActivity {


    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        // 天气仅支持设置，暂不支持读取

        ApplicationLayerFunctionPacket functionPacket = WristbandManager.getInstance(App.getInstance()).getFunctionPacket();
        if (functionPacket == null) {
            // 如果功能列表为空，必须先获取一次功能列表，然后用户可自行缓存该功能列表也可使用 SDK 缓存
            WristbandManager.getInstance(App.getInstance()).sendFunctionReq();
            return;
        }
        // 判断是否支持该功能
        boolean isSupport = functionPacket.getWeather() == DeviceFunctionStatus.SUPPORT;

        new Thread(new Runnable() {
            @Override
            public void run() {
                JWWeatherInfo weatherInfo = new JWWeatherInfo();
                // 多云，当前温度 25 度，最高温度 30 度，最低温度 20，湿度 86，当前紫外线强度 1 - 5，越高紫外线越强， 当前污染指数 1 - 6，越高污染越严重
                weatherInfo.setCurrentWeather(JWWeatherInfo.WEATHER_CODE_CLOUDY, 25, 30, 20, 86, 2, 3);
                weatherInfo.setNextOneDayWeather(JWWeatherInfo.WEATHER_CODE_CLOUDY, 30, 20);
                weatherInfo.setNextTwoDayWeather(JWWeatherInfo.WEATHER_CODE_CLOUDY, 30, 20);
                WristbandManager.getInstance(App.getInstance()).setWeather(weatherInfo, new JWCallback() {
                    @Override
                    public void onSuccess() {

                    }

                    @Override
                    public void onError(int code, String desc) {

                    }
                });
            }
        }).start();

    }
}
