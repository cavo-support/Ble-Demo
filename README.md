# Wo-Smart Technologies Bluetooth SDK and Demo 

The Android and iOS repositories have now been separated. The new repository addresses are as follows:

For Android: https://github.com/cavo-support/Ble-Demo-Android

For iOS: https://github.com/cavo-support/Ble-Demo-iOS

These repositories are now maintained independently, with separate links for each platform.


## iOS  Version Description

| Version |                         Description                          |
| :-----: | :----------------------------------------------------------: |
|  1.3.2  |      1：hrv-rmssd time zone 2:fixed setting sleep goal       |
|  1.3.1  |                       1：add hrv-rmssd                       |
|  1.3.0  |                    1：fix hrv time zone;                     |
|  1.1.0  | 1: New data function, body fat;<br/>2: Added data exception cleaning function;<br/>3: Optimize known issues; |
| 1.0.18  | Fix the problem of sending a large number of steps to the device abnormally |
| 1.0.17  | 1: Three cycle data optimization;<br/>2: Repair synchronization timeout does not work;<br/>3: Custom dial added to return data callback;<br/>4: Add ecgoridatacallback; |
| 1.0.16  |                   1:Optimize 3 cycle data                    |
| 1.0.15  | 1: Add the current resource version number and return to JWBleDeviceModel.resourceVersionCode;<br/>2: Optimize the sleep data duplication problem; |
| 1.0.14  | 1: Fix [JWBleDataAction jwTemperatureCalibration:xx]; abnormal value;<br/>2: Message notification, add full open example; |
| 1.0.13  | 1) Fix: When JWBleManager.isProduce = true; The device is connected to the system and automatically reconnects the device;<br/><br/>2) Fix: sleep data returns abnormal value |
| 1.0.12  | 1.sleep add filter method <br />[JWBleDataAction jwGetFilterSleepDataByYYYYMMDDStr:dateString callBack:^(NSArray *dataArr) { }]; |
| 1.0.11  | 1.Weather function optimization<br />2.Added 【uric acid】function |
| 1.0.10  |        }];1. Fix sedentary reminder weekly repeat bug        |
|  1.0.9  | 1.optimize heart rate data storage, adapt to different firmware versions |
|  1.0.8  | 1. Added female and weather functions;<br/>2. Delete the abnormal value of heart rate; |



## Android  Version Description

| Version |                                                                                                                                                       Description                                                                                                                                                        |
|:-------:|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:|
| 1.2.36  |                                                                                                                                  1：fix connect bug  <br/> 2. add [setDefaultFunction]  Added default function switch settings (blood pressure, temperature, pressure, scene control, Alexa, light sensitivity)       |
| 1.2.35  |                                                                                                                                                   1：support hrv rmssd                                                                                                                                                    |
| 1.2.34  |                                                                                                                                       1：fix JWHeartRateVariabilityInfo time error                                                                                                                                        |
| 1.2.33  |                                                                                                           1：delete DfuService <br/>  2. add [onScreenLightDuration(int currentDuration, int defaultDuration)]                                                                                                            |
| 1.2.32  |                                                                                                                                                1：Added [Vietnam] language                                                                                                                                                |
| 1.2.31  |                                                                                                                                                1：Added [BodyFat] function                                                                                                                                                |
| 1.2.30  |                                                                                                                                           1：Added [getGluContinuous] function                                                                                                                                            |
| 1.2.29  |                                                                                                                                      1：fix log;<br/> 2: fix save blood pressure bug                                                                                                                                      |
| 1.2.28  |                                                                                    1：change the temperature attribute unit of JWSaunaInfo;<br/> 2: support [UricAcidContinuousMonitoring] and [BloodFatContinuousMonitoring] function                                                                                    |
| 1.2.27  |                                                                                                                                                 1：fix get sauna data bug                                                                                                                                                 |
| 1.2.26  |                                                                                         1：fix set watch face code<br/>  2.fix get sauna data bug<br/>  3. add initSDK method [WristbandManager.getInstance().initSDK(context)];                                                                                          |
| 1.2.25  |                                                                                                                                               1：fix database upgrade bugs                                                                                                                                                |
| 1.2.24  |                                                                                                                                                   1：fix print log bugs                                                                                                                                                   |
| 1.2.23  |                                                                                                                              1：Added [uric acid], [blood fat], [blood sugar cycle] function                                                                                                                              |
| 1.2.22  |                                                                                                                                                 1：fix spo2 storage error                                                                                                                                                 |
| 1.2.21  |                                                                                                                   1：support delete health data [JWHealthDataManager.getInstance().deleteHealthData()]                                                                                                                    |
| 1.2.20  |                                                                                                                                                     1：add code note                                                                                                                                                      |
| 1.2.19  | 1. optimize heart rate data storage, adapt to different firmware versions<br/>2. optimize sync health data speed <br/>3. add function JWHealthDataManager to get health data  from db, such as step, sleep, sport, blood pressure, blood sugar,<br/> heart rate, heart rate variability, pulse, sauna, spo2, temperature |
| 1.2.18  |                                                                                                                  1. Added female and weather functions;<br/>2. Delete the abnormal value of heart rate                                                                                                                   |
| 1.2.17  |                                                                                                                                              1：fix parse ble protocol error                                                                                                                                              |
| 1.2.16  |                                                                                                                                              1：sdk and demo [SaunaActivity]                                                                                                                                              |
| 1.2.15  |                                                                                                                                              1：sdk and demo [PulseActivity]                                                                                                                                              |
| 1.2.14  |                                                                                                     1：Added[set pulse] and [setSleepHelp] function】in SDK<br />2：DEMO implements [setPulse] [setSleepHelp] function                                                                                                      |
| 1.2.13  |                                                                                                                      1. remove invalid attr from AndroidManifest<br /> 2. optimize connection speed                                                                                                                      |
| 1.2.12  |                                                                                                                    1. support sos function[setSOSNumberToDevice]<br /> 2. support [getGluContinuous]                                                                                                                     |
| 1.2.11  |                                                                                                                              1. update device info attr [ApplicationLayerDeviceInfoPacket]                                                                                                                               |
| 1.2.10  |                                                                                                                   1. fix SDK error 2. add code annotation and sdk info [WristbandManager.getSDKInfo()]                                                                                                                   |
|  1.2.9  |                                                                                                                    support filter sleep data SleepFilter.filterByData(int year, int month, int day);                                                                                                                     |
|  1.2.8  |                                                                           1. fix SDK init error 2. fix sync end callback method not triggered 3. add new functions(setSleepAllSwitch, setHypoxiaSwitch, setHighHrvSwitch, setDeviceDateFormat)                                                                           |
|         |                                                                                                                                                                                                                                                                                                                          |
|         |                                                                                                                                                                                                                                                                                                                          |
|         |                                                                                                                                                                                                                                                                                                                          |
