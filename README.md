# Wo-Smart Technologies Bluetooth SDK and Demo 



## iOS  Version Description

| Version |                         Description                          |
| :-----: | :----------------------------------------------------------: |
| 1.0.15  | 1: Add the current resource version number and return to JWBleDeviceModel.resourceVersionCode;<br/>2: Optimize the sleep data duplication problem; |
| 1.0.14  | 1: Fix [JWBleDataAction jwTemperatureCalibration:xx]; abnormal value;<br/>2: Message notification, add full open example; |
| 1.0.13  | 1) Fix: When JWBleManager.isProduce = true; The device is connected to the system and automatically reconnects the device;<br/><br/>2) Fix: sleep data returns abnormal value |
| 1.0.12  | 1.sleep add filter method <br />[JWBleDataAction jwGetFilterSleepDataByYYYYMMDDStr:dateString callBack:^(NSArray *dataArr) { }]; |
| 1.0.11  | 1.Weather function optimization<br />2.Added 【uric acid】function |
| 1.0.10  |        }];1. Fix sedentary reminder weekly repeat bug        |
|  1.0.9  | 1.optimize heart rate data storage, adapt to different firmware versions |
|  1.0.8  | 1. Added female and weather functions;<br/>2. Delete the abnormal value of heart rate; |
|  1.0.7  |              1：sdk and demo【sauna function】               |
|  1.0.6  |         1：sdk and demo【customized pulse function】         |
|  1.0.5  | 1：Added【customized pulse function】in SDK<br />2：DEMO implements 【customized pulse function】 |
|  1.0.4  | Add Temperature data calibration:<br />[JWBleDataAction jwTemperatureCalibration:(float)]; |
|  1.0.3  | Added log fine-grained control configuration:<br/>1: JWBleManager. shareInstance. saveLog<br/>2: JWBleManager. shareInstance. cacheLogCount |
|  1.0.2  |                                                              |



## Android  Version Description

| Version |                         Description                          |
| :-----: | :----------------------------------------------------------: |
| 1.2.25  | 1：fix database upgrade bugs  |
| 1.2.24  | 1：fix print log bugs  |
| 1.2.23  | 1：Added [uric acid], [blood fat], [blood sugar cycle] function  |
| 1.2.22  | 1：fix spo2 storage error  |
| 1.2.21  | 1：support delete health data [JWHealthDataManager.getInstance().deleteHealthData()]  |
| 1.2.20  | 1：add code note  |
| 1.2.19  | 1. optimize heart rate data storage, adapt to different firmware versions<br/>2. optimize sync health data speed <br/>3. add function JWHealthDataManager to get health data  from db, such as step, sleep, sport, blood pressure, blood sugar,<br/> heart rate, heart rate variability, pulse, sauna, spo2, temperature |
| 1.2.18  | 1. Added female and weather functions;<br/>2. Delete the abnormal value of heart rate |
| 1.2.17  | 1：fix parse ble protocol error  |
| 1.2.16  | 1：sdk and demo [SaunaActivity]  |
| 1.2.15  | 1：sdk and demo [PulseActivity]  |
| 1.2.14  | 1：Added[set pulse] and [setSleepHelp] function】in SDK<br />2：DEMO implements [setPulse] [setSleepHelp] function |
| 1.2.13  |     1. remove invalid attr from AndroidManifest<br /> 2. optimize connection speed|
| 1.2.12  |     1. support sos function[setSOSNumberToDevice]<br /> 2. support [getGluContinuous]|
| 1.2.11  |     1. update device info attr [ApplicationLayerDeviceInfoPacket] |
| 1.2.10  |     1. fix SDK error 2. add code annotation and sdk info [WristbandManager.getSDKInfo()]    |
|  1.2.9  | support filter sleep data SleepFilter.filterByData(int year, int month, int day); |
|  1.2.8  | 1. fix SDK init error 2. fix sync end callback method not triggered 3. add new functions(setSleepAllSwitch, setHypoxiaSwitch, setHighHrvSwitch, setDeviceDateFormat) |
|         |                                                              |
|         |                                                              |
|         |                                                              |
