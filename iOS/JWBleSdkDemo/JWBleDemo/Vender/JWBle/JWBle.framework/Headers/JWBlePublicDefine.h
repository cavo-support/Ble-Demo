//
//  JWBlePublicDefine.h
//  JWBle
//
//  Created by Bo 黄 on 2019/3/20.
//  Copyright © 2019 wosmart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JWBleDeviceModel.h"
#import "JWBleAlarmClockModel.h"
#import "JWBleMedicationReminderModel.h"
#import "JWNotDisturbModel.h"
#import "JWCountDownModel.h"
#import "JWOxygenModel.h"

#pragma mark - 状态枚举 State enumeration
//蓝牙连接状态枚举 Bluetooth connection status enumeration
typedef NS_ENUM (NSInteger, JWBleDeviceConnectStatus) {
    JWBleDeviceConnectStatus_DisConnect = 0,//断开连接 Disconnect
    JWBleDeviceConnectStatus_Connect,//已经连接 Already connected
    JWBleDeviceConnectStatus_BondSuccess,//绑定成功 Bind successfully
    JWBleDeviceConnectStatus_BondFailure,//绑定失败 Bind failed
    JWBleDeviceConnectStatus_SyncSuccess,//同步信息成功 Information synchronization succeeded
    JWBleDeviceConnectStatus_SyncFailure,//同步信息失败 Sync information failed
    JWBleDeviceConnectStatus_DiscoverNewUpdateFirm,//发现可以升级的新固件 Discover new firmware that can be upgraded
    JWBleDeviceConnectStatus_BatteryUpdate,//电量改变了 The battery has changed
    JWBleDeviceConnectStatus_ChargeStatusChanged,//充电状态改变 Change in state of charge
    JWBleDeviceConnectStatus_HeadphoneDeviceStatusChanged,//耳机状态改变 Headphone status changes
    JWBleDeviceConnectStatus_TimeOutDisconnect,//通信超时，已主动断开连接 Communication timed out and disconnected actively
    JWBleDeviceConnectStatus_DeviceStatusChanges,//设备状态改变（省点模式、飞行模式等） Device status changes (point-saving mode, flight mode, etc.)
    JWBleDeviceConnectStatus_BondConfirm_NotAllowed,//绑定失败，用户点击不允许 Binding failed, user click is not allowed
    JWBleDeviceConnectStatus_BondConfirm_TimeOut,//绑定失败，用户不操作设备 The binding fails, the user does not operate the device
    JWBleDeviceConnectStatus_BleRemovedPairingInformation,//系统绑定的蓝牙设备缓存被删除，一般是被其它手机也系统绑定了 The bluetooth device cache bound by the system is deleted, usually it is bound by other mobile phones
    JWBleDeviceConnectStatus_Temp
};

//通信的通用状态 General status of communication
typedef NS_ENUM (NSInteger, JWBleCommunicationStatus) {
    JWBleCommunicationStatus_Faild = 0,//通信 失败  Communication failed
    JWBleCommunicationStatus_Success = 1,//通信 成功 Communication success
    JWBleCommunicationStatus_PWDError = 3,//通信 密码错误 Communication password error
    JWBleCommunicationStatus_IsDFUModel = 4,//通信 手环是DFU模式 Communication bracelet is DFU mode
    JWBleCommunicationStatus_Busy = 5,//手环正忙，同步数据中 Bracelet is busy, synchronizing data
};

//系统蓝牙状态改变  System Bluetooth status changed
typedef NS_ENUM (NSInteger, JWBleCentralManagerState) {
    JWBleCentralManagerState_Unknown = 0,//未知 unknown
    JWBleCentralManagerState_Resetting,//正在重置 Resetting
    JWBleCentralManagerState_Unsupported,//设备不支持 Device does not support
    JWBleCentralManagerState_Unauthorized,//设备未授权 Device is not authorized
    JWBleCentralManagerState_PoweredOff,//系统蓝牙关闭 System Bluetooth is off
    JWBleCentralManagerState_PoweredOn,//系统蓝牙开启 System Bluetooth is on
};

//修改密码枚举 Change password enumeration
typedef NS_ENUM (NSInteger, JWBleUpdatePWDStatus) {
    JWBleUpdatePWDStatus_Success,//修改密码成功 successfully change password
    JWBleUpdatePWDStatus_OldPwdError,//原密码不一致 The original password is inconsistent
    JWBleUpdatePWDStatus_DeviceBusy,//手环正在通信中 The bracelet is communicating
    JWBleUpdatePWDStatus_Faild,//修改密码失败 Password change failed
};

//遥控拍照枚举 Remote photo enumeration
typedef NS_ENUM (NSInteger, JWBleRemotePhotographyStatus) {
    JWBleRemotePhotographyStatus_Success,//遥控拍照，设置成功 Take pictures remotely, set up successfully
    JWBleRemotePhotographyStatus_TakePhoto,//遥控拍照 设备摇晃回调 Remote control camera device shake callback
    JWBleRemotePhotographyStatus_DeviceBusy,//遥控拍照 设备繁忙 Remote control camera is busy
    JWBleRemotePhotographyStatus_Faild,//遥控拍照 设置失败 Remote camera setting failed
};

//简单的功能状态枚举 Simple functional state enumeration
typedef NS_ENUM (NSInteger, JWBleCommonFunctionsStatus) {
    JWBleCommonFunctionsStatus_Read,//读 read
    JWBleCommonFunctionsStatus_Open,//开 open
    JWBleCommonFunctionsStatus_Close//关 turn off
};

//固件升级回调 Firmware upgrade callback
typedef NS_ENUM(NSInteger, JWBleDeviceDFUStatus) {
    JWBleDeviceDFUStatus_FileNotExist = 0, //升级文件不存在 Upgrade file does not exist
    JWBleDeviceDFUStatus_Start,//开始升级 Start upgrading
    JWBleDeviceDFUStatus_Updating,//升级中 during upgrade
    JWBleDeviceDFUStatus_Success,//升级成功 update successed
    JWBleDeviceDFUStatus_Failure,//升级失败 Upgrade failed
    JWBleDeviceDFUStatus_PeripheralIsNull,//设备为null Device is null
};

//测试心率状态 Test heart rate status
typedef NS_ENUM(NSInteger, JWBleTestHRStatus) {
    JWBleTestHRStatus_TestStart = 0, //测试开始，等待手环的响应  The test starts, waiting for the bracelet's response
    JWBleTestHRStatus_DeviceResponse,//手环响应中  Bracelet responding
    JWBleTestHRStatus_TestEnd,//测试结束 End of test
    JWBleTestHRStatus_TestField,//测试失败 Test failed
};

//测试血压状态 Test blood pressure status
typedef NS_ENUM(NSInteger, JWBleTestBPStatus) {
    JWBleTestBPStatus_TestStart = 0, //测试开始，等待手环的响应 The test starts, waiting for the bracelet's response
    JWBleTestBPStatus_DeviceResponse,//手环响应中 Bracelet responding
    JWBleTestBPStatus_TestEnd,//测试结束 End of test
    JWBleTestBPStatus_TestField,//测试失败 Test failed
    JWBleTestBPStatus_TestInterrupt,//测试中断 Test interrupt
};

//测试温度状态 Test temperature status
typedef NS_ENUM(NSInteger, JWBleTestTemperatureStatus) {
    JWBleTestTemperatureStatus_TestEnd = 0,//实时心率上传功能关闭返回 Real-time heart rate upload function closed and returned
    JWBleTestTemperatureStatus_DeviceResponse = 1,//实时心率上传功能开启返回 Real-time heart rate upload function turned on
    JWBleTestTemperatureStatus_NotOpen = 2,//手环设备连续心率没有开启，温度数据监测功能不开启 The continuous heart rate of the bracelet device is not turned on, and the temperature data monitoring function is not turned on
    JWBleTestTemperatureStatus_Open = 3,//手环设备连续心率已经开启，温度监测功能可以开启 The continuous heart rate of the bracelet device has been turned on, and the temperature monitoring function can be turned on
    JWBleTestTemperatureStatus_BUSY = 4,//手环设备连续心率已经开启，但是因为设备正在忙碌状态，温度数据监测功能不开启 The continuous heart rate of the bracelet device has been turned on, but the temperature data monitoring function is not turned on because the device is busy
    JWBleTestTemperatureStatus_TestField
};

//手环繁忙状态枚举 Bracelet busy status enumeration
typedef NS_ENUM(NSInteger, JWBleBusyStatus) {
    JWBleBusyStatus_Heart_Rate_Manual_Test = 0, //心率手动测量
    JWBleBusyStatus_Heart_Rate_Silent_Measurement, //心率静默测量
    JWBleBusyStatus_Manual_Blood_Pressure_Measurement, //血压手动测量
    JWBleBusyStatus_Blood_Pressure_Silent_Measurement, //血压静默测量
    JWBleBusyStatus_Manual_Blood_Oxygen_Measurement, //血氧手动测量
    JWBleBusyStatus_Silent_Measurement_Of_Blood_Oxygen, //血氧静默测量
    JWBleBusyStatus_Manual_Pressure_Measurement, //压力手动测量
    JWBleBusyStatus_Silent_Measurement_Of_Pressure, //压力静默测量
    JWBleBusyStatus_In_Motion, //运动中
    JWBleBusyStatus_ECG_Testing,//ECG测试中
    JWBleBusyStatus_Manual_Blood_Glucose_Measurement, //血糖手动测量
    JWBleBusyStatus_Silent_Measurement_Of_Blood_Glucose, //血糖静默测量
    JWBleBusyStatus_Pulsed_Magnetic_Therapy, //脉冲磁疗测试中
};

#pragma mark - 功能枚举 Function enumeration
//手环运动枚举 Bracelet sports enumeration
typedef NS_ENUM (NSInteger, JWBleDeviceMotionEnum) {
    JWBleDeviceMotionEnum_Run = 0,
    JWBleDeviceMotionEnum_Climb,
    JWBleDeviceMotionEnum_Football,
    JWBleDeviceMotionEnum_Cycle,
    JWBleDeviceMotionEnum_Rope,
    JWBleDeviceMotionEnum_RunOutDoor,
    JWBleDeviceMotionEnum_RideOutDoor,
    JWBleDeviceMotionEnum_WalkOutDoor,
    JWBleDeviceMotionEnum_RunInDoor,
    JWBleDeviceMotionEnum_FreeTrain,
    JWBleDeviceMotionEnum_Plank,
    
    JWBleDeviceMotionEnum_Walk,
    JWBleDeviceMotionEnum_Pranayama,
    JWBleDeviceMotionEnum_Yoga,
    JWBleDeviceMotionEnum_Hiking,
    JWBleDeviceMotionEnum_Spinning,
    JWBleDeviceMotionEnum_Rowing,
    JWBleDeviceMotionEnum_Stepper,
    JWBleDeviceMotionEnum_Elliptical,
    
    JWBleDeviceMotionEnum_Basketball,
    JWBleDeviceMotionEnum_Tennis,
    JWBleDeviceMotionEnum_Badminton,
    JWBleDeviceMotionEnum_Baseball,
    JWBleDeviceMotionEnum_Rugby,
};

//实时数据枚举 Real-time data enumeration
typedef NS_ENUM (NSInteger, JWBleImmediateDataEnum) {
    JWBleImmediateDataEnum_Step,//记步 Step
    JWBleImmediateDataEnum_HR,//心率 Heart rate
};

//功能枚举 Function enumeration
typedef NS_ENUM (NSInteger, JWBleFunctionEnum) {
    JWBleFunctionEnum_Error = -1,//占位符 Placeholder
    
    JWBleFunctionEnum_HeadphoneCall,//耳机通话 Headset call
    JWBleFunctionEnum_BloodPressureTest,//血压测试 Blood pressure test
    JWBleFunctionEnum_HR,//心率监测 Heart rate monitoring
    JWBleFunctionEnum_DoNotDisturbMode,//勿扰模式 Do not disturb mode
    JWBleFunctionEnum_Step,//计步 Step count
    JWBleFunctionEnum_Sleep,//睡眠监测 Sleep monitoring
    JWBleFunctionEnum_WeChatRun,//微信运动Airsync WeChat Sports Airsync
    JWBleFunctionEnum_BrightScreenDuration,//亮屏时长 Bright screen duration
    JWBleFunctionEnum_Noti,//消息提醒 message notification
    JWBleFunctionEnum_MainInterfaceStyle,//主界面风格 Main interface style
    JWBleFunctionEnum_LiftTheWristScreen,//抬手亮屏 Raise your hand to brighten the screen
    JWBleFunctionEnum_MoreLanguage,//多语言 multi-language
    JWBleFunctionEnum_TimeSystem,//时间 12、24进制 Time 12, 24
    JWBleFunctionEnum_Unit,//公英制 Metric
    JWBleFunctionEnum_OTA,//空中升级 Upgrade in the air
    JWBleFunctionEnum_NFC,//NFC
    JWBleFunctionEnum_ExerciseMore,//多运动 exercise more
    JWBleFunctionEnum_StopwatchTiming,//秒表计时，需要查询 隐藏功能菜单 Stopwatch timing, need to query hidden function menu
    JWBleFunctionEnum_Countdown,//倒计时 Countdown
    JWBleFunctionEnum_HeartRateReminder,//心率提醒 Heart rate reminder
    JWBleFunctionEnum_RemotePhotography,//遥控拍照 Take pictures remotely
    JWBleFunctionEnum_FindPhone,//查找手机，需要查询 隐藏功能菜单 To find the phone, you need to check the hidden function menu
    JWBleFunctionEnum_FindBracelet,//查找手环 Find bracelet
    JWBleFunctionEnum_BrightnessControl,//亮度控制 Brightness control
    JWBleFunctionEnum_MusicControl,//音乐控制 Music control
    JWBleFunctionEnum_VolumeControl,//音量控制 volume control
    JWBleFunctionEnum_SmartAlarmClock,//智能闹钟 Smart alarm clock
    JWBleFunctionEnum_SedentaryReminder,//久坐提醒 Sedentary reminder
    
    JWBleFunctionEnum_EventReminder,//事件提醒 Event reminder
    JWBleFunctionEnum_AutomaticLockScreen,//自动锁屏，sdk是长按解锁，需要查询 隐藏功能菜单 Automatic screen lock, sdk is long press to unlock, need to query hidden function menu
    JWBleFunctionEnum_RealTimeHeartRate,//实时心率 Real-time heart rate
    JWBleFunctionEnum_HideFunctionMenu,//隐藏功能菜单 Hide function menu
    JWBleFunctionEnum_TwoButtonSliding,//双按键滑动 Double button slide
    JWBleFunctionEnum_VoiceAssistant,//语音助手 Voice Assistant
    
    JWBleFunctionEnum_DataCalibration = 63,//数据校准 Data calibration
    JWBleFunctionEnum_SyncSleep = 62,//同步睡眠给手环 Simultaneous sleep to the bracelet
    JWBleFunctionEnum_Temperature = 61,//温度 temperature
    JWBleFunctionEnum_BloodPressureV2 = 60,//血压2.0 blood pressure2.0
    JWBleFunctionEnum_SmartAlarmClockV2 = 59,//智能闹钟2.0 Smart alarm clock2.0
    JWBleFunctionEnum_MainInterfaceStyle_Customize = 58,//自定义主界面风格 Customize the main interface style.
    JWBleFunctionEnum_MainInterfaceStyle_Download = 57,//下载主界面 Download main interface
    JWBleFunctionEnum_Blood_Oxygen = 56,//血氧 Blood oxygen
    
    JWBleFunctionEnum_DisplayFontUpgrade = 55,//显示字库升级 Display font upgrade
    JWBleFunctionEnum_SleepQualityJudgment_V2 = 54,//睡眠质量判断2.0 Sleep quality judgment 2.0
    JWBleFunctionEnum_APP_MOTION_HR_V2 = 53,//APP运动心率 SAPP_MOTION_HR 2.0
    
    JWBleFunctionEnum_ContinuousBloodOxygen = 51,//连续血氧检测 Continuous blood oxygen
    JWBleFunctionEnum_ECG = 50,//ecg
    JWBleFunctionEnum_Status_Check = 49,//状态检查 Status check
    JWBleFunctionEnum_Address_Book = 48,//通讯录 address book
    
    JWBleFunctionEnum_HRV = 47,
    JWBleFunctionEnum_DeviceBPMonitoring = 46, // 设备血压监测  Equipment blood pressure monitoring
    JWBleFunctionEnum_BloodGlucose = 45, // 血糖 BloodGlucose
    JWBleFunctionEnum_LowOxygenReminder = 44, // 低氧提醒 Low oxygen reminder
    JWBleFunctionEnum_HighHeartRateReminder = 43, // 心率过高提醒 High heart rate reminder
    JWBleFunctionEnum_SleepAllDay = 42, // 全天睡眠 sleep all day
    JWBleFunctionEnum_DialDateFormat = 41, // 表盘日期格式 Dial date format
    
#pragma mark - Device Function 2
    JWBleFunctionEnum_DevicePrivateBloodPressure = 10001, // 设备私人血压  Device private blood pressure
    JWBleFunctionEnum_SOS = 10002, // sos
    JWBleFunctionEnum_DrinkWaterReminder = 10003, // 喝水提醒 drink water reminder
    JWBleFunctionEnum_TemperatureReminder = 10004, // 体温提醒 Temperature reminder
    JWBleFunctionEnum_MedicationReminder = 10005, // 吃药提醒 Medication reminder
};

//客户功能枚举 Custom Function enumeration
typedef NS_ENUM (NSInteger, JWBleCustomFunctionEnum) {
    JWBleCustomFunctionEnum_Error = -1,//占位符 Placeholder
    
    JWBleCustomFunctionEnum_SetPulse = 0,//设置脉冲 set pulse
    JWBleCustomFunctionEnum_SleepAid,//辅助睡眠 sleep aid
    
};

//手环可设置开关枚举 The device can be set to switch enumeration
typedef NS_ENUM (NSInteger, JWBleDeviceSwitchFunctionEnum) {
    JWBleDeviceSwitchFunctionEnum_Error = -1,//占位符 Placeholder
    
    JWBleDeviceSwitchFunctionEnum_Time_Format,//时间制式， 返回值（0:24小时制，1:12小时制）  time format, return value (0:24 hour format, 1:12 hour format)
    JWBleDeviceSwitchFunctionEnum_Language,//语言选择， 返回值（JWBleLanguageEnum）   language selection, return value (JWBleLanguageEnum)
    JWBleDeviceSwitchFunctionEnum_Heart_Rate_Monitoring,//心率监测开关，返回值（0：关闭， 1：开启）  Heart rate monitor switch, return value (0: off, 1: on)
    JWBleDeviceSwitchFunctionEnum_Blood_Pressure_Monitoring,//血压监测开关，返回值（0：关闭， 1：开启）  Blood pressure monitoring switch, return value (0: off, 1: on)
    JWBleDeviceSwitchFunctionEnum_Blood_Oxygen_Monitoring,//血氧监测开关，返回值（0：关闭， 1：开启）  Blood oxygen monitoring switch, return value (0: off, 1: on)
    JWBleDeviceSwitchFunctionEnum_Temperature_Monitoring,//温度监测开关，返回值（0：关闭， 1：开启）   Temperature monitoring switch, return value (0: off, 1: on)
    JWBleDeviceSwitchFunctionEnum_Temperature_Compensation,//温度补偿开关，返回值（0：关闭， 1：开启）  Temperature compensation switch, return value (0: off, 1: on)
    JWBleDeviceSwitchFunctionEnum_Temperature_Function_Independent,//温度功能独立，返回值（0：关闭， 1：开启）  Temperature function independent, return value (0: off, 1: on)
    JWBleDeviceSwitchFunctionEnum_BloodGlucose_Monitoring,//血糖功能独立，返回值（0：关闭， 1：开启）  BloodGlucose function independent, return value (0: off, 1: on)
    JWBleDeviceSwitchFunctionEnum_Gesture_Bright_Screen,//手势亮屏，返回值（0：关闭， 1：开启） Gesture bright screen, return value (0: off, 1: on)
    
};

//通知枚举 Notification enumeration
typedef NS_ENUM (NSInteger, JWBleNotiEnum) {
    JWBleNotiEnum_Error = -1,
    JWBleNotiEnum_Call = 1,
    JWBleNotiEnum_QQ = 3,
    JWBleNotiEnum_WeChat = 5,
    JWBleNotiEnum_SMS = 7,
    JWBleNotiEnum_Line = 9,
    JWBleNotiEnum_Twitter = 11,
    JWBleNotiEnum_Facebook = 14,
    JWBleNotiEnum_Messenger = 16,
    JWBleNotiEnum_WhatsApp = 18,
    JWBleNotiEnum_LinkedIn = 20,
    JWBleNotiEnum_Instagram = 22,
    JWBleNotiEnum_Skype = 24,
    JWBleNotiEnum_Viber = 26,
    JWBleNotiEnum_KakaoTalk = 28,
    JWBleNotiEnum_VKontakte = 30,
    JWBleNotiEnum_AppleMail = 32,
    JWBleNotiEnum_AppleCalendar = 34,
    JWBleNotiEnum_AppleFacetime = 36,
    JWBleNotiEnum_Tim = 38,
    JWBleNotiEnum_Gmail = 40,
    JWBleNotiEnum_DingTalkPlus = 42,
    JWBleNotiEnum_WorkWechat = 44,
    JWBleNotiEnum_APlus = 46,
    JWBleNotiEnum_LINK = 48,
    JWBleNotiEnum_Beike = 50,
    JWBleNotiEnum_Lianjia = 52,
    JWBleNotiEnum_Other = 54
};

//功能状态枚举 Functional state enumeration
typedef NS_ENUM (NSInteger, JWBleFunctionStatesEnum) {
    JWBleFunctionStateEnum_NotSupport = 0 | 2,//不支持 not support
    JWBleFunctionStateEnum_Close = 1,//关闭 shut down
    JWBleFunctionStateEnum_Open = 3//开启 Open
};

//隐藏功能状态枚举 Hidden function status enumeration
typedef NS_ENUM (NSInteger, JWBleHideFunctionStatesEnum) {
    JWBleHideFunctionStatesEnum_NotSupport,//不支持 not support
    JWBleHideFunctionStatesEnum_Show,//关闭(显示) Close (show)
    JWBleHideFunctionStatesEnum_Hidden,//开启(隐藏) Open (hide)
};

//语言枚举 Language enumeration
typedef NS_ENUM (NSInteger, JWBleLanguageEnum) {
    JWBleLanguageEnum_ChineseSimplified = 1,
    JWBleLanguageEnum_Traditional_Chinese = 2,
    JWBleLanguageEnum_English = 0,
    JWBleLanguageEnum_Spanish = 87,
    JWBleLanguageEnum_French = 20,
    JWBleLanguageEnum_German = 18,
    JWBleLanguageEnum_Italian = 96,
    JWBleLanguageEnum_Japanese = 65,
    JWBleLanguageEnum_Swedish = 66,
    JWBleLanguageEnum_Korean = 29,
    JWBleLanguageEnum_Portuguese = 62,
    JWBleLanguageEnum_Russian = 19,
    JWBleLanguageEnum_Turkey = 82,
};

//运动操作枚举 Motion enumeration
typedef NS_ENUM (NSInteger, JWBleMotionActionEnum) {
    JWBleMotionActionEnum_Stop = 0,//停止 stop
    JWBleMotionActionEnum_Start = 1,//开始运动 Start exercise
    JWBleMotionActionEnum_Pause = 3//暂停 pause
};
 
//同步数据状态 Synchronized data status
typedef NS_ENUM (NSInteger, JWBleSyncStateEnum) {
    JWBleSyncEnum_Start = 0,//开始 Start
    JWBleSyncEnum_Interrupt, //中断 Interrupt
    JWBleSyncEnum_InconsistentTotals, //总数不一致 Inconsistent totals
    JWBleSyncEnum_Complete //完成
};

//实时心率状态返回 Real-time heart rate status return
typedef NS_ENUM (NSInteger, JWBleRealTimeHeartRateStateEnum) {
    JWBleRealTimeHeartRateStateEnum_Close = 0,//关闭 shut down
    JWBleRealTimeHeartRateStateEnum_Open, //开启 Open
    JWBleRealTimeHeartRateStateEnum_Busy, //手环繁忙 Bracelet busy
    JWBleRealTimeHeartRateStateEnum_TimeOut //超时 time out
};

//手环繁忙状态判断 Bracelet busy status judgment
typedef NS_ENUM (NSInteger, JWBleBusyStateEnum) {
    JWBleBusyStateEnum_Busy = 2, //手环繁忙 Bracelet busy
    JWBleBusyStateEnum_Idle = 3, //手环空闲 Bracelet idle
    JWBleBusyStateEnum_TimeOut = 4 //超时 time out
};

//资源升级类型 Resource upgrade type
typedef NS_ENUM (NSInteger, JWUpdateResourceType) {
    JWUpdateResourceType_Main_display_resource = 0, //主显示资源 Main display resource
    JWUpdateResourceType_Display_font, //显示字库 Display font
    JWUpdateResourceType_Font_libraries_involved_in_the_main_interface, //主界面涉及到的字库 Font libraries involved in the main interface
    JWUpdateResourceType_Custom_interface_resources, //自定义界面资源 Custom interface resources
    JWUpdateResourceType_Dial_market_resources, //表盘市场资源 Dial market resources
};

//设备状态（省点模式、飞行模式等） Device status (point-saving mode, flight mode, etc.)
typedef NS_ENUM (NSInteger, JWDeviceStatusType) {
    JWDeviceStatusType_Power_Saving_Mode = 63, //省电模式   Power saving mode
    JWDeviceStatusType_Temp
};

//测试血氧请求枚举  Test blood oxygen request enumeration
typedef NS_ENUM (NSInteger, JWTestOxygenRequestType) {
    JWTestOxygenRequestType_End = 0,
    JWTestOxygenRequestType_Start,
    JWTestOxygenRequestType_Check,
};

//测试血氧返回枚举  Test blood oxygen returns enumeration
typedef NS_ENUM (NSInteger, JWTestOxygenResultType) {
    JWTestOxygenResultType_End = 0,
    JWTestOxygenResultType_Start,
    JWTestOxygenResultType_Disable,
    JWTestOxygenResultType_Available,
};

//用户偏好设置枚举 User preference enumeration
typedef NS_ENUM (NSInteger, JWUserPreferenceType) {
    JWUserPreferenceType_BloodGlucose_Unit = 0, //0:mmol；1:mg
};

//删除数据枚举 delete data enumeration
typedef NS_ENUM (NSInteger, JWDeleteDataType) {
    JWDeleteDataType_Step = 0,
    JWDeleteDataType_HeartRate,
    JWDeleteDataType_BloodPressure,
    JWDeleteDataType_Oxygen,
    JWDeleteDataType_Temperature,
    JWDeleteDataType_BloodGlucose,
    JWDeleteDataType_Hrv,
    JWDeleteDataType_Sports
};

#pragma mark - CallBack

//接收扫描到的设备 Receive scanned device
typedef void(^JWBleReceiveScanningDeviceCallBack)(JWBleDeviceModel* deviceModel);

//连接设备成功 Device connected successfully
typedef void (^JWBleConnectStatusChangeCallBack)(JWBleDeviceConnectStatus deviceConnectStatus);

//系统蓝牙状态回调 System Bluetooth status callback
typedef void (^JWCentralManagerStateChangeBlock)(JWBleCentralManagerState centralManagerState);

//遥控拍照回调 Remote control camera callback
typedef void (^JWBleRemotePhotographyCallBack)(JWBleRemotePhotographyStatus remotePhotographyStatus);

//同步数据回调 Synchronous data callback
typedef void (^JWBleSynchronousDataProgressCallBack)(int curPackageIndex, int packageCount);

//LANGCO 翻译回调 LANGCO translation callback
typedef void (^JWBleLangCoTranslationCallBack)(int value);

//查找手机回调 Find phone callback
typedef void (^JWBleFindPhoneCallBack)(void);

//查找手机回调V2 Find phone callback
typedef void (^JWBleFindPhoneV2CallBack)(BOOL start);

/**
 实时心率回调
 Real-time heart rate callback
  
 如果hrValue为-999，则是手环主动停止的
 If hrValue is -999, the bracelet is actively stopped
 */
typedef void (^JWBleRealTimeHeartRateCallBack)(NSInteger hrValue);

/**
 脉冲结束回调 Pulse end callback
 */
typedef void (^JWBleEndOfPulseCallBack)(int value);

/**
 脉冲数据回调 Pulse data callback
 
 status:
    0:end
    1: start
    2:receiving
 length: How many pieces of data exist，（only status == 1）
 timestamp：timestamp，（only status == 2）
 value：value，（only status == 2）
 */
typedef void (^JWBlePulseDataCallBack)(int status, int length ,int timestamp, int value);

/**
 实时温度回调
 Real-time temperature callback
  
 value:温度值 Temperature value
 gradientStatus: 是否是渐变状态（如果是渐变状态，一般不会储存） Whether it is a gradual change state (if it is a gradual change state, it is generally not saved)
 wearingState：是否佩戴 Whether to wear
 compensationStatus：是否补偿 Whether to compensate
 如果value为-999，则是手环主动停止的 If the value is -999, the bracelet is actively stopped

 */
typedef void (^JWBleRealTimeTemperatureCallBack)(float value, BOOL gradientStatus, BOOL wearingState, BOOL compensationStatus);

//通用通信回调 General communication callback
typedef void (^JWBleCommunicationCallBack)(JWBleCommunicationStatus status);

//通用通信回调 -- 存在Respnonse  General Communication Callback - Response exists
typedef void (^JWBleCommunicationReceiveCallBack)(JWBleCommunicationStatus status, NSData *responData);

//通用功能回调 General function callback
typedef void (^JWBleCommonFuctionReceiveCallBack)(JWBleCommunicationStatus communicationStatus, JWBleCommonFunctionsStatus functionStatus);

//修改密码回调 Change password callback
typedef void (^JWBleUpdatePWDCallBack)(JWBleUpdatePWDStatus status);

//Opus数据回调 -- Opus数据回调
typedef void (^JWBleOpusDataCallBack)(NSData *responData);

//固件升级回调 Firmware upgrade callback
typedef void (^JWBleDFUCallBack)(NSInteger didSend, NSInteger totalLength, JWBleDeviceDFUStatus deviceDFUStatus);

//检查手环运动类型 是否支持回调 Check if the movement type of the bracelet supports callback
typedef void (^JWBleCheckMotionSupportCallBack)(JWBleCommunicationStatus communicationStatus, BOOL support);

/**
 获取电量回调
 Get battery callback

 @param communicationStatus 通信状态 Communication status
 @param power 电量 Power
 @param charging 是否正在充电 Is charging
 */
typedef void (^JWBleGetPowerCallBack)(JWBleCommunicationStatus communicationStatus, int power, bool charging);

//获取实时数据回调 Get real-time data callback
//immediateDic:{
    //JWImmediateDataEnum_Step:{step:xx,cal:xx,dis:xx}
    //JWImmediateDataEnum_HR:{hr:xx}
//}
typedef void (^JWBleGetImmediateDataCallBack)(JWBleCommunicationStatus status, NSDictionary *immediateDic);

/**
 心率上限操作回调 Heart rate upper limit operation callback

 @param status 通信状态 Communication status
 @param open 是否开启 Whether to open
 @param value 提醒的值 Reminder value
 */
typedef void (^JWBleHRReminderActionCallBack)(JWBleCommunicationStatus status, BOOL open, int value);

/**
 久坐提醒回调 Sedentary reminder callback

 @param status 通信状态 Communication status
 @param open 开启、关闭 switch on switch off
 @param startH 开始小时 Start hour
 @param endH 结束小时 End hour
 @param span 间隔（分钟）【30~240】Interval (minutes)【30~240】
 @param threshold 阈值（在设定的时间段内，没有 xxx 步数即提醒）【0~65535】 Threshold (in the set time period, there is no xxx steps to remind)【0~65535】
 @param dayFlagArr 周重复【周一,周二,周三,周四.....周日】重复为true，不重复为false  Week repeat [Monday, Tuesday, Wednesday, Thursday... Sunday] Repeat is true, not repeat is false
 */
typedef void (^JWBleSedentaryReminderActionCallBack)(JWBleCommunicationStatus status, BOOL open, int startH, int endH, int span, int threshold, NSArray *dayFlagArr);

/**
 时间格式回调 Time format callback

 @param status 状态 status
 @param is12 是否12小时制 Whether 12 hours
 */
typedef void (^JWBleTimeThemeActionCallBack)(JWBleCommunicationStatus status, BOOL is12);

/**
 主界面风格通信回调 Main interface style communication callback
 
 @param status 状态 status
 @param curStyle 当前风格 Current style
 @param styleCount 风格数 Style number
 */
typedef void (^JWBleMainInterfaceStyleBlock)(JWBleCommunicationStatus status, int curStyle, int styleCount);

/**
 转腕亮屏回调 Turn the wrist bright screen callback

 @param open 是否开启 Whether to open
 @param sensitivity 灵敏度 Sensitivity
 @param startMinute 开始分钟 Start minute
 @param endMinute 结束分钟 End minute
 */
typedef void (^JWBleTurnWristCreenActionCallBack)(JWBleCommunicationStatus status, BOOL open, int sensitivity, int startMinute, int endMinute);

/**
 秒表回调 Stopwatch callback

 @param status 状态 status
 @param start 是否开始计时 Whether to start timing
 @param showInDevice 是否显示在界面 Whether to display on the interface
 */
typedef void (^JWBleStopwatchTimingActionCallBack)(JWBleCommunicationStatus status, BOOL start, BOOL showInDevice);

/**
 测试心率回调 Test heart rate callback

 @param status 状态 status
 @param testStatus 测试状态回调 Test status callback
 @param hrValue 心率值 Heart rate
 */
typedef void (^JWBleTestHRCallBack)(JWBleCommunicationStatus status, JWBleTestHRStatus testStatus ,int hrValue);

/**
 测试血压回调 Test blood pressure callback
 
 @param status 状态 status
 @param testStatus 测试状态回调 Test status callback
 @param high 高压 high pressure
 @param low 低压 Low pressure
 */
typedef void (^JWBleTestBPCallBack)(JWBleCommunicationStatus status, JWBleTestBPStatus testStatus ,int high, int low);

/**
 测试温度回调 Test temperature callback
 
 @param status 状态 status
 @param testStatus 测试状态回调 Test status callback
 */
typedef void (^JWBleTestTemperatureCallBack)(JWBleCommunicationStatus status, JWBleTestTemperatureStatus testStatus);

/**
 闹钟事件回调 Alarm event callback

 @param status 状态 status
 @param alarmArr 闹钟数组 Alarm clock array
 */
typedef void (^JWBleAlarmActionCallBack)(JWBleCommunicationStatus status, NSArray<JWBleAlarmClockModel *> *alarmArr);

/**
 吃药提醒 Alarm event callback

 @param status 状态 status
 @param alarmArr 提醒数组 Alarm clock array
 */
typedef void (^JWBleMedicationReminderActionCallBack)(JWBleCommunicationStatus status, NSArray<JWBleMedicationReminderModel *> *alarmArr);

/**
 查找手机回调 Find phone callback
 
 @param status 状态 status
 @param showInDevice 是否显示在界面 Whether to display on the interface
 */
typedef void (^JWBleFindPhoneActionCallBack)(JWBleCommunicationStatus status, BOOL showInDevice);

/**
 心率自动检测回调 Heart rate automatic detection callback

 @param status 状态 status
 @param open 是否开启 Whether to open
 @param timeSpan 间隔时间 Intervals
 */
typedef void (^JWBleAutomaticDetectionActionCallBack)(JWBleCommunicationStatus status, BOOL open, int timeSpan);

/**
 亮屏时长回调 Bright screen duration callback
 
 @param status 状态 status
 @param timeLength 亮屏时长 Bright screen duration
 
 间隔是3~30s The interval is 3~30s
 */
typedef void (^JWBleBrightScreenDurationCallBack)(JWBleCommunicationStatus status, int timeLength, int defalut);

/**
 语言操作回调 Language operation callback

 @param status 状态 status
 @param languageEnum 语言枚举 Language enumeration
 */
typedef void (^JWBleLanguageCallBack)(JWBleCommunicationStatus status, JWBleLanguageEnum languageEnum);

/**
 勿扰模式回调 Do not disturb mode callback

 @param status 状态 status
 @param model model信息 model information
 */
typedef void (^JWBleNotDisturbActionCallBack)(JWBleCommunicationStatus status, JWNotDisturbModel *model);

/**
 倒计时回调 Countdown callback

 @param status 状态 status
 @param countingDown 正在倒计时 Counting down
 @param showInDevice 手环是否显示 Whether the bracelet is displayed
 @param deviceTime 手环常用时长 Bracelet duration
 @param timeCount 剩余时长 Remaining time
 */
typedef void (^JWBleTimerActionCallBack)(JWBleCommunicationStatus status, BOOL countingDown, BOOL showInDevice, int deviceTime, int timeCount);

/**
 运动操作回调 Motion operation callback

 @param status 状态 status
 @param actionType 运动状态 Movement state
 @param motionType 运动类型 Type of exercise
 */
typedef void (^JWBleMotionActionCallBack)(JWBleCommunicationStatus status, JWBleMotionActionEnum actionType, JWBleDeviceMotionEnum motionType);

/**
 获取通知回调 Get notification callback

 @param status 状态 status
 @param dic
 key：@[
 @"Call",
 @"QQ",
 @"WeChat",
 @"SMS",
 @"Line",
 @"Twitter",
 @"Facebook",
 @"Messenger",
 @"WhatsApp",
 @"LinkedIn",
 @"Instagram",
 @"Skype",
 @"Viber",
 @"KakaoTalk",
 @"VKontakte",
 @"AppleMail",
 @"AppleCalendar",
 @"AppleFacetime",
 ]
 value： true/false
 */
typedef void (^JWBleGetNoticeCallBack)(JWBleCommunicationStatus status, NSDictionary *dic);

/**
 同步数据回调 Synchronous data callback

 @param status 通信状态 status
 @param syncStateEnum 同步状态 Synchronization status
 */
typedef void (^JWBleSyncCallBack)(JWBleCommunicationStatus status, JWBleSyncStateEnum syncStateEnum);

/**
 倒计时回调 Countdown callback
 
 @param status 通信状态 status
 @param countDownModel 倒计时model Countdown model
 */
typedef void (^JWBleCountDownActionCallBack)(JWBleCommunicationStatus status, JWCountDownModel *countDownModel);

/**
 实时心率回调 Real-time heart rate callback
 */
typedef void (^JWRealTimeHeartRateActionCallBack)(JWBleCommunicationStatus status, JWBleRealTimeHeartRateStateEnum realTimeHRStatus);

/**
 检查繁忙状态回调 Check busy status callback
 */
typedef void (^JwCheckDeviceBusyCallBack)(JWBleCommunicationStatus status, JWBleBusyStateEnum jWBleBusyStateEnum);

/**
 生产测试功能列表返回 List of production test functions
 */
typedef void (^JwFactoryFunctionCallBack)(JWBleCommunicationStatus status, NSData *data);

/**
 ECG data callback
 */
typedef void (^JwECGDataCallBack)(NSArray *originalSignals, NSArray *filterSignals);

/**
 Device Test ECG data callback
 */
typedef void (^JwDeviceTestECGCallBack)(NSDictionary *dic);
/**
 ECG value data callback
 */
typedef void (^JwECGValueDataCallBack)(int bpm, int qt, int hrv, int rri, int progress);

/**
 Device switch change callback
 
 Please use the following method to get the changed value
  [JWBleAction jwGetDeviceSNIDWithBlock]
 */
typedef void (^JwDeviceSwitchChangeCallBack)(NSData *deviceSwitchData);
