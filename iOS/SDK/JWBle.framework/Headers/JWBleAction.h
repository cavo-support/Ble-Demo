//
//  JWBleAction.h
//  JWBle
//
//  Created by Bo 黄 on 2019/3/20.
//  Copyright © 2019 wosmart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JWBlePublicModelDefine.h"
#import "JWBleCustomizeMainInterfaceActionConfigModel.h"

@interface JWBleAction : NSObject

/**
 开始扫描设备 Start scanning device

 @param callBack 扫描设备回调  Scanning device callback
 */
+ (void)jwStartScanDeviceWithCallBack:(JWBleReceiveScanningDeviceCallBack)callBack;

/**
 停止扫描 Stop scanning
 */
+ (void)jwStopScanDevice;

/**
 连接设备 Connected devices

 @param deviceModel 设备model  Equipment model
 */
+ (void)jwConnectDevice:(JWBleDeviceModel *)deviceModel;

/**
 断开连接 Disconnect
 */
+ (void)jwDisConnect;

/**
 断开连接，但是不解绑  Disconnect, but do not unbind
 */
+ (void)jwDisConnectNotUnBond;

/**
 删除连接记录[会导致无法自动重连]  Delete the connection record [will cause automatic reconnection not possible]
 deviceUUID: 如果和最后一次连接的设备uuid一致，则删除，传”“则直接删除  If it is consistent with the uuid of the last connected device, delete it, and pass "" to delete it directly
 */
+ (void)jwRemoveConnectRecord:(NSString *)deviceUUID;

/**
 同步个人信息 Synchronize personal information
 
 @param age 年龄  0~127  Age 0~127
 @param isMan 是否是男的 Is it male
 @param height 身高cm 0.0~256 精确到0.5cm Height cm 0.0~256 accurate to 0.5cm
 @param weight 体重kg 0.0~512 精确到0.5kg Weight kg 0.0~512 accurate to 0.5kg
 @param callBack 回调 Callback
 */
+ (void)jwSynchronizePersonalInformation:(int)age
                                 isMan:(BOOL)isMan
                                height:(float)height
                                weight:(float)weight
                              callBack:(JWBleCommunicationCallBack)callBack;

/**
 设置计步目标 Set pedometer goal
 
 @param step 步数 1000~65000  Number of steps 1000~65000
 @param callBack 回调 Callback
 */
+ (void)jwSetStepTargetAction:(int)step callBack:(JWBleCommunicationCallBack)callBack;

/**
 设置卡路里目标 Set calorie goal
 
 @param calorie 单位千卡  Unit kcal
 @param callBack 回调 Callback
 */
+ (void)jwSetCalorieTargetAction:(int)calorie callBack:(JWBleCommunicationCallBack)callBack;

/**
 设置睡眠目标 Set sleep goals
 
 @param minute 分钟 90~900 Min 90~900
 @param callBack 回调 Callback
 */
+ (void)jwSetSleepTargetAction:(int)minute callBack:(JWBleCommunicationCallBack)callBack;

/**
 查找手环 Find bracelet
 */
+ (void)jwFindDeviceWithCallBack:(JWBleCommunicationCallBack)callBack;

/**
 遥控拍照 Take pictures remotely
 
 @param open 是否打开 Whether to open
 @param callBack 回调 Callback
 */
+ (void)jwRemotePhotography:(BOOL)open callBack:(JWBleCommunicationCallBack)callBack;

/**
 心率自动检测功能 Heart rate automatic detection function
 
 @param isGet 是否获取 Whether to get
 @param open 是否开启 Whether to open
 @param timeSpan 时间间隔 分钟 5-30-60-120 Interval minutes 5-30-60-120
 @param callBack 回调 Callback
 */
+ (void)jwHrAutomaticDetectionAction:(BOOL)isGet
                                open:(BOOL)open
                            timeSpan:(int)timeSpan callBack:(JWBleAutomaticDetectionActionCallBack)callBack;

/**
 血压自动检测功能 Heart rate automatic detection function
 
 @param isGet 是否获取 Whether to get
 @param open 是否开启 Whether to open
 @param timeSpan 时间间隔 分钟 5-30-60-120 Interval minutes 5-30-60-120
 @param callBack 回调 Callback
 */
+ (void)jwBPAutomaticDetectionAction_V3:(BOOL)isGet
                                open:(BOOL)open
                            timeSpan:(int)timeSpan callBack:(JWBleAutomaticDetectionActionCallBack)callBack;

/**
 转腕亮屏 Turn wrist bright screen
 
 @param isGet 是否获取 Whether to get
 @param open 是否开启 Whether to open
 @param sensitivity 灵敏度 Sensitivity
 @param startMinute 开始分钟 Start minute
 @param endMinute 结束分钟 End minute
 @param callBack 回调 Callback
 */
+ (void)jwTurnWristCreenActionWithIsGet:(BOOL)isGet
                                 open:(BOOL)open
                          sensitivity:(int)sensitivity
                          startMinute:(int)startMinute
                            endMinute:(int)endMinute
                             callBack:(JWBleTurnWristCreenActionCallBack)callBack;

/**
 久坐提醒 Sedentary reminder
 
 @param isGet 是否获取 Whether to get
 @param open 开启、关闭 switch on switch off
 @param startH 开始小时 Start hour
 @param endH 结束小时 End hour
 @param span 间隔【30~240】（分钟） Interval【30~240】(minutes)
 @param threshold 阈值（在设定的时间段内，没有 xxx 步数即提醒）【0~65535】 Threshold (in the set time period, there is no xxx steps to remind)【0~65535】
 @param dayFlagArr 周重复【周一,周二,周三,周四.....周日】重复为true，不重复为false  Week repeat [Monday, Tuesday, Wednesday, Thursday... Sunday] Repeat is true, not repeat is false
 @param callBack 回调 Callback
 */
+ (void)jwSedentaryReminder:(BOOL)isGet
                       open:(BOOL)open
                     startH:(int)startH
                       endH:(int)endH
                       span:(int)span
                  threshold:(int)threshold
                 dayFlagArr:(NSArray *)dayFlagArr
                   callBack:(JWBleSedentaryReminderActionCallBack)callBack;

/**
 获取 或 设置 通用功能 Get or set general functions
 
 @param functionEnum  目前支持功能： Currently supported features:
 JWBleFunctionEnum_Unit - 公英制  开是公制 Metric and imperial system
 JWBleFunctionEnum_TimeSystem,//时间 12、24进制  开是12小时  Time 12 and 24 are open 12 hours
 @param functionsState 状态 status
 @param callBack 回调 Callback
 */
+ (void)jwCommonFunction:(JWBleFunctionEnum)functionEnum
        functionsState:(JWBleCommonFunctionsStatus)functionsState
              callBack:(JWBleCommonFuctionReceiveCallBack)callBack;

/**
 亮屏控制功能 Bright screen control function
 
 @param isGet 是否获取 Whether to get
 @param timeLength 亮屏时长 3~30秒 Bright screen duration 3~30 seconds
 @param callBack 回调 Callback
 */
+ (void)jwbBrightScreenDuration:(BOOL)isGet
                  timeLength:(int)timeLength
                    callBack:(JWBleBrightScreenDurationCallBack)callBack;

/**
 亮度调节功能 Brightness adjustment function
 
 @param isGet 是否获取 Whether to get
 @param value 亮度[20,100] Brightness [20,100]
 @param callBack 回调  Callback
 */
+ (void)jwbBrightnessAdjustment:(BOOL)isGet
                  value:(int)value
                callBack:(void (^)(JWBleCommunicationStatus status,int value,int defalutValue))callBack;

/**
 语言操作 Language manipulation

 @param isGet 是否获取 Whether to get
 @param languageEnum 枚举 enumerate
 @param callBack 回调  Callback
 */
+ (void)jwLanguageAction:(BOOL)isGet
            languageEnum:(JWBleLanguageEnum)languageEnum
                callBack:(JWBleLanguageCallBack)callBack;

/**
 勿扰模式功能 Do not disturb mode function
 
 @param isGet 是否获取 Whether to get
 @param model 勿扰模式相关model Do not disturb mode related model
 @param callBack 回调 Callback
 */
+ (void)jwNotDisturbAction:(BOOL)isGet
                     model:(JWNotDisturbModel *)model
                  callBack:(JWBleNotDisturbActionCallBack)callBack;

/**
 更新通知开关 Update notification switch
 
 @param enumType 枚举类型 Enumeration type
 @param open 开启 Open
 @param callBack 回调 Callback
 */
+ (void)jwUpdateNotiStatus:(JWBleNotiEnum)enumType
                      open:(BOOL)open
                  callBack:(JWBleCommunicationCallBack)callBack;

/// 更改隐藏和显示的开关  Change hidden and displayed switches
/// @param enumType enumType description
/// @param open 是否打开 Whether to open
/// @param callBack 回调 Callback
+ (void)jwUpdateHideFunction:(JWBleFunctionEnum)enumType
                    open:(BOOL)open
                callBack:(JWBleCommunicationCallBack)callBack;

///  一次性更新消息通知  One-time update message notification
/// @param dic @{@(JWBleNotiEnum_Call):@(true)},@(JWBleNotiEnum_QQ):@(false)}}
/// @param callBack 回调
+ (void)jwOneTimeUpdateNotiStatus:(NSDictionary *)dic callBack:(JWBleCommunicationCallBack)callBack;

/**
 获取通知开关 Get notification switch
 
 @param callBack 回调
 */
+ (void)jwGetNotiStatusWithCallBack:(JWBleGetNoticeCallBack)callBack;

/**
 测试心率 Test heart rate
 
 @param callBack 回调
 */
+ (void)jwTestHRAction:(BOOL)start
              callBack:(JWBleTestHRCallBack)callBack;
/**
 测试血压 Test blood pressure
 
 @param callBack 回调
 */
+ (void)jwTestBPAction:(BOOL)start
              callBack:(JWBleTestBPCallBack)callBack;

/**
测试温度  test temperature

@param actionKey  0:关闭温度数据监测 1：开启温度数据监测 2：查询手环是否可以开启温度监测（因为依赖连续心率）  0: Turn off temperature data monitoring 1: Turn on temperature data monitoring 2: Query whether the bracelet can turn on temperature monitoring (because it depends on continuous heart rate)
@param callBack 回调
*/
+ (void)jwTestTemperatureAction:(int)actionKey
            callBack:(JWBleTestTemperatureCallBack)callBack;

/**
 检查功能状态 Check function status
 
 @param functionEnum 功能枚举  Function enumeration
 @return return 功能状态枚举  Functional state enumeration
 */
+ (JWBleFunctionStatesEnum)jwCheckFunctionStates:(JWBleFunctionEnum)functionEnum;

/**
 检查设备控制开关 Check the device control switch
 
 @param functionEnum 功能枚举  Function enumeration
 @return return 对应的值，详情查看JWBleDeviceSwitchFunctionEnum ，-1为手环不支持该设置   The corresponding value, see JWBleDeviceSwitchFunctionEnum for details, -1 means that the bracelet does not support this setting
 */
+ (int)jwCheckControlSwitchStates:(JWBleDeviceSwitchFunctionEnum)functionEnum;

/**
 检查隐藏功能状态  Check hidden function status
  
 @param functionEnum 功能枚举

     @(JWBleFunctionEnum_StopwatchTiming),
     @(JWBleFunctionEnum_FindPhone),
     @(JWBleFunctionEnum_AutomaticLockScreen),
     @(JWBleFunctionEnum_TwoButtonSliding),
     @(JWBleFunctionEnum_VoiceAssistant)
 
 @return return 隐藏功能状态枚举
 */
+ (JWBleHideFunctionStatesEnum)jwCheckHideFunctionStates:(JWBleFunctionEnum)functionEnum;

/**
 闹钟功能  Alarm clock function

 只需要设置打开的闹钟   Only need to set the open alarm
 
 @param get  是否获取 Whether to get
 @param alarmArr 闹钟数组（如果设置） Alarm clock array (if set)
 @param callBack 回调
 */
+ (void)jwAlarmAction:(BOOL)get
             alarmArr:(NSArray<JWBleAlarmClockModel *> *)alarmArr
             callBack:(JWBleAlarmActionCallBack)callBack;

/**
 获取手环mac地址  Get bracelet mac address

 @param callBack callBack description
 */
+ (void)jwGetMacAddressWithBlock:(void (^)(NSString *macAddr))callBack;

/**
 获取手环状态 Get bracelet status

 @param callBack callBack description
 
 status：0：关闭 1：匹配中 2：准备就绪 3：已连接
 status:  0: closed 1: matching 2: ready 3: connected
 */
+ (void)jwGetDeviceStatusWithBlock:(void (^)(int status))callBack;

/**
 主界面风格操作 Main interface style operation

 @param isGet 是否获取 Whether to get
 @param willShowIndex isGet == false，则需要设置显示的主界面    isGet == false, you need to set the main interface displayed
 @param callBack status 通信状态，curShowIndex 当前显示的主界面, count 手环有多少个主界面可以选择     Communication status, curShowIndex currently displayed main interface, count how many main interfaces the bracelet can choose
 */
+ (void)jwMainInterfaceAction:(BOOL)isGet
                willShowIndex:(int)willShowIndex
                     callBack:(void (^)(JWBleCommunicationStatus status,int curShowIndex, int count))callBack;

/**
 获取实时计步  Get real-time step counting
 
 @param callBack callBack description
 
     status: 通信状态  Communication status
     steps:11 (步数), (Step count),
     calory:22 (卡路里，单位卡), (Calories, unit card),
     distance:33(距离，单位 米)  (Distance, in meters)
 
 */
+ (void)jwGetRealTimeStepWithCallback:(void (^)(JWBleCommunicationStatus status, int step, int dis, int calories))callBack;

/**
 获取心率自动检测类型   Get automatic heart rate detection type

 @param callBack callBack description
            
        @{
             @"0":true,//支持连续   Support continuous
             @"5":true,//支持间隔5分钟  Support interval 5 minutes
             @"30":true,//间隔十分钟  Ten minutes apart
             @"60":true,  ...
             @"120":true, ...
        }
 */
+ (void)jwGetHRAutomaticDetectionType:(void (^)(JWBleCommunicationStatus status, NSDictionary *resultDic))callBack;

///  倒计时操作  Countdown operation
/// @param isGet 是否获取  Whether to get
/// @param countDownModel 倒计时model  Countdown model
/// @param callBack 回调
+ (void)jwCountDownAction:(BOOL)isGet model:(JWCountDownModel *)countDownModel callBack:(JWBleCountDownActionCallBack)callBack;

// 停止倒计时回调  Stop countdown callback
+ (void)jwStopCountDownCallBack;

/**
 自动锁屏操作 Automatic lock screen operation
 @param isGet 是否获取 Whether to get
 @param open 是否打开 Whether to open
 @param callBack 回调 Callback
 */
+ (void)jwAutomaticLockScreenAction:(BOOL)isGet open:(BOOL)open callBack:(void (^)(JWBleCommunicationStatus status, BOOL open))callBack;

/// 实时心率操作 Real-time heart rate operation
/// @param open 开启/关闭 switch on switch off
+ (void)jwRealTimeHeartRateAction:(BOOL)open callBack:(JWRealTimeHeartRateActionCallBack)callBack;

/// 运动实时心率操作  motion Real-time heart rate operation
///    注：需要功能列表支持 JWBleFunctionEnum_APP_MOTION_HR_V2
/// @param open 开启/关闭 switch on switch off
/// @param sportType 运动类型 Exercise type
///         0：户外跑步
///         1：爬山
///         3：户外骑行
///         8：室内跑步
///         10	：plank
///         11：户外健走
///         14：徒步
///
+ (void)jwRealTimeHeartRateAction:(BOOL)open sprotType:(int)sportType callBack:(JWRealTimeHeartRateActionCallBack)callBack;

/// 手环功能显示与隐藏的操作  Bracelet function display and hidden operation
/// @param isGet 是否获取
/// @param setDic @{@"findPhone":@(true),@"stopWatch":@(true)}
/// @param callBack @{@"findPhone":@(true),@"stopWatch":@(true)}
+ (void)jwDeviceFunctionShowOrHiddenAction:(BOOL)isGet setDic:(NSDictionary *)setDic callBack:(void (^)(JWBleCommunicationStatus status, NSDictionary *dic))callBack;

/// 发起耳机配对，回调在 监听耳机状态中   Headset pairing is initiated, the callback is in the state of monitoring the headset
+ (void)jwHeadphonePairing;

/// 取消  发起耳机配对，回调在 监听耳机状态中  Cancel Initiate headset pairing, callback is in monitor headset status
+ (void)jwCancelHeadphonePairing;

/**
 检查设备是否繁忙  Check if the device is busy
 */
+ (void)jwCheckDeviceBusyWithCallBack:(JwCheckDeviceBusyCallBack)callBack;

/**
 同步睡眠给手环
 level:睡眠质量 1~5
 deep:深睡分钟
 light:浅睡分钟
 startMinuteIndex: 入睡分钟下标
 endMinuteIndex: 苏醒分钟下标
 callBack:回调
 
 Simultaneous sleep to the bracelet
 level: sleep quality 1~5
 deep: deep sleep minutes
 light: light sleep minutes
 startMinuteIndex: Sleeping minute subscript
 endMinuteIndex: Wake up minute subscript
 callBack: callback
 */
+ (void)jwSyncSleep2Device:(int)level deep:(int)deep light:(int)light startMinuteIndex:(int)startMinuteIndex endMinuteIndex:(int)endMinuteIndex callBack:(JWBleCommunicationCallBack)callBack;

/**
 将手环数据下标，重置   Subscript the bracelet data, reset
 */
+ (void)jwDeviceDataReset;

/**
 温度开关操作
 @param isGet 是否获取
 @param unit true:摄氏度 false:华氏度
 @param compensate 温度补偿开关
 @param monitor 温度监测界面显示开关
 @param callBack 回调
 
 Temperature switch operation
 param isGet
 param unit true: Celsius false: Fahrenheit
 param compensate temperature compensation switch
 param monitor temperature monitoring interface display switch
 param callBack callback
 */
+ (void)jwTemperatureSwitchAction:(BOOL)isGet
                     unit:(BOOL)unit
               compensate:(BOOL)compensate
                  monitor:(BOOL)monitor
                 callBack:(void (^)(JWBleCommunicationStatus status, BOOL unit, BOOL compensate, BOOL monitor))callBack;

/**
 升级资源类型设置
 
 @param isGet 是否获取
 @param type JWUpdateResourceType
 @param callBack 回调
 
 Upgrade resource type settings
 
    @param isGet whether to get
    @param type JWUpdateResourceType
    @param callBack callback
 */
+ (void)jwUpdateResourceType:(BOOL)isGet type:(JWUpdateResourceType)type callBack:(void (^)(JWBleCommunicationStatus status, JWUpdateResourceType type))callBack;

/**
 血压2.0 （连续血压）操作
 
 @param isGet 是否获取
 @param open 是否开启
 @param callBack 回调
 
 Blood pressure 2.0 (continuous blood pressure) operation
 
  @param isGet whether to get
  @param open is open
  @param callBack callback
 */
+ (void)jwBPV2Action:(BOOL)isGet open:(BOOL)open callBack:(void (^)(JWBleCommunicationStatus status, BOOL open))callBack;

/**
 私人血压设置
 
 @param open 是否开启
 @param h 高压
 @param l 低压
 @param callBack 回调
 
 Private blood pressure setting
 
  @param open is open
  @param h high pressure
  @param l low pressure
  @param callBack callback
 
 */
+ (void)jwBPPrivateSet:(BOOL)open h:(NSInteger)h l:(NSInteger)l callBack:(void (^)(JWBleCommunicationStatus status))callBack;

/**
 闹钟功能V2  Alarm clock functionV2

 只需要设置打开的闹钟   Only need to set the open alarm
 
 @param get  是否获取 Whether to get
 @param alarmModel
    1、闹钟model（如果设置）
    2、月 和 日 同时为0，则为删除
 
    1、Alarm clock model (if set)
    2、Month and day are both 0, then delete
 @param callBack 回调
 */
+ (void)jwAlarmV2Action:(BOOL)get
               alarmModel:(JWBleAlarmClockModel *)alarmModel
               callBack:(JWBleAlarmActionCallBack)callBack;

+ (void)jwCustomizeMainInterfaceAction:(BOOL)get configModel:(JWBleCustomizeMainInterfaceActionConfigModel *)configModel;

+ (void)jwCustomizeRoundMainInterfaceAction:(BOOL)get configModel:(JWBleCustomizeMainInterfaceActionConfigModel *)configModel;

+ (void)jwCustomizeRectangleMainInterfaceAction:(BOOL)get configModel:(JWBleCustomizeMainInterfaceActionConfigModel *)configModel;

+ (void)wbSetCustomizeV102MainInterface:(BOOL)get configModel:(JWBleCustomizeMainInterfaceActionConfigModel *)configModel;

+ (void)jwCustomizeGT5MainInterfaceAction:(BOOL)get configModel:(JWBleCustomizeMainInterfaceActionConfigModel *)configModel;

+ (void)jwCustomize_1_47_MainInterfaceAction:(BOOL)get configModel:(JWBleCustomizeMainInterfaceActionConfigModel *)configModel;

+ (void)jwCustomize_238_MainInterfaceAction:(BOOL)get configModel:(JWBleCustomizeMainInterfaceActionConfigModel *)configModel;

+ (void)jwCustomizeMainInterfacePositionWithConfigModel:(JWBleCustomizeMainInterfaceActionConfigModel *)configModel;

/**
 同步总步数、总距离、总卡路里给手环
    
 Synchronize the total number of steps, total distance, and total calories to the bracelet
 */
+ (void)jwDialyDataSyncWithSteps:(UInt32)totalSteps andDistance:(UInt32)totalDistance andCalory:(UInt32)totalCalory;

/**
 OTA前检查手环状态
 callback：{
    deviceStatus:
            0：可以直接开始OTA静默升级
            1：手环设备正忙，提醒
            ...
 }
 
 Check the condition of the bracelet before OTA

 callback：{

 deviceStatus:

 0: you can start the OTA silent upgrade directly

 1: Bracelet device is busy, alert

 ...

 }
 */
+ (void)jwCheckOTAEnableWithCallBack:(void (^)(JWBleCommunicationStatus status, int deviceStatus))callBack;

/**
 运动不足提醒设置
 
 Insufficient exercise reminder settings
 */
+ (void)jwSettingCustomExerciseLack;

/**
 测试血氧
 */
+ (void)jwTestOxygen:(JWTestOxygenRequestType)requestType callBack:(void (^)(JWBleCommunicationStatus status, JWTestOxygenResultType resultType, JWOxygenModel *oxygenModel))callBack;

/**
 音频操作
 
 @param isGet 是否获取
 @param open 是否开启
 @param callBack 回调
 
 */
+ (void)jwAudioAction:(BOOL)isGet open:(BOOL)open callBack:(void (^)(JWBleCommunicationStatus status, BOOL open))callBack;

/**
 连续血氧开关操作
 */
+ (void)jwContinuousBloodOxygenAction:(BOOL)isGet open:(BOOL)open callBack:(void (^)(JWBleCommunicationStatus status, BOOL open))callBack;
/**
 ECG
 
 callBack - ecgStatus
     0: normal
     1: start
     2: end
     3: interrupt
     4:interrupt 10s after end
     999: data collection
 */
+ (void)jwECGAction:(BOOL)open callBack:(void (^)(JWBleCommunicationStatus status, int ecgStatus))callBack;

/**
 使手环关机
 
 Turn Off Bracelet
 */
+ (void)jwTurnOffBracelet;

/**
 检查手环繁忙状态
 
 Check device busy status
 
 statusArr: {
 JWBleBusyStatus....
 }
 */
+ (void)jwCheckDeviceBusyStatusWithCallBack:(void (^)(JWBleCommunicationStatus status, NSArray *statusArr))callBack;

/**
 同步通讯录
 
 addressBooks:
 @[
    @{
        @"name":@"xxxx", //最多15个UTF8
        @"phone":@"1368xxxxx", //最多19个UTF8
    }
 ]
 
 Sync Contacts
  
   addressBooks:
   @[
      @{
          @"name":@"xxxx", //Up to 15 UTF8
          @"phone":@"1368xxxxx", //Up to 19 UTF8
      }
   ]
 
 */
+ (void)jwSyncContacts:(NSArray<NSDictionary *> *)addressBooks callBack:(void (^)(JWBleCommunicationStatus status, int index))callBack;

/**
 更新界面颜色
 仅支持特殊手环固件
 
 Update interface colors
 Only supports special wristband firmware
 
 colorIndex：1-7
 */
+ (void)jwUpdateInterfaceColor:(int)colorIndex callBack:(void (^)(JWBleCommunicationStatus status))callBack;

/**
 连续血糖开关操作
 */
+ (void)jwContinuousBloodGlucoseAction:(BOOL)isGet open:(BOOL)open callBack:(void (^)(JWBleCommunicationStatus status, BOOL open))callBack;
/**
 测试血糖 Test BloodGlucose
 
 @param callBack 回调
 */
+ (void)jwTestBloodGlucoseAction:(BOOL)start callBack:(void (^)(JWBleCommunicationStatus status, JWBleTestBPStatus testStatus, int value))callBack;
/**
 私人血糖 PrivateBloodGlucose
 
 @param isGet 是否获取
 @param high 高值，传值需要乘以10，比如7.5，则传75 High value, the passed value needs to be multiplied by 10, such as 7.5, then pass 75
 @param low 低值，传值需要乘以10，比如7.5，则传75 Low value, the passed value needs to be multiplied by 10, such as 7.5, then pass 75
 @param callBack 回调
 */
+ (void)jwPrivateBloodGlucoseAction:(BOOL)isGet high:(int)high low:(int)low callBack:(void (^)(JWBleCommunicationStatus status, int high, int low))callBack;

/**
 用户偏好设置
 
 @param isGet 是否获取  User Preferences
 @param values
        [
            @{
              type:@(JWUserPreferenceType),
              value:@(0)
            },
            ...
        ]
 @param callBack 回调
 */
+ (void)jwUserPreferencesAction:(BOOL)isGet values:(NSArray *)values callBack:(void (^)(JWBleCommunicationStatus status, NSArray *values))callBack;

/**
 低氧提醒 LowOxygenReminder
 */
+ (void)jwLowOxygenReminderAction:(BOOL)isGet open:(BOOL)open callBack:(void (^)(JWBleCommunicationStatus status, BOOL open))callBack;

/**
 心率上限 HighHeartRateReminder
 
 maxValue:  最大值（40-220） Maximum (40-220)
 */
+ (void)jwHighHeartRateReminderAction:(BOOL)isGet open:(BOOL)open maxValue:(int)maxValue callBack:(void (^)(JWBleCommunicationStatus status, BOOL open, int maxValue))callBack;

/**
 全天睡眠 SleepAllDay
 */
+ (void)jwSleepAllDayAction:(BOOL)isGet open:(BOOL)open callBack:(void (^)(JWBleCommunicationStatus status, BOOL open))callBack;

/**
 表盘日期格式 DialDateFormat
 
 open：false:(MM-DD) true:(DD-MM)
 */
+ (void)jwDialDateFormatAction:(BOOL)isGet open:(BOOL)open callBack:(void (^)(JWBleCommunicationStatus status, BOOL open))callBack;

#pragma mark - 以下是生产测试方法  The following is the production test method
/**
 修改设备名称

 @param name  名称
 
 设备名称长度限制（中文*4 如：哈哈哈，英文数字*12 如：ABCDEFGH1234）
 
 Modify device name

  param name name
 
  Device name length limit (Chinese *4 eg: hahaha, English digits *12 eg: ABCDEFGH1234)
 */
+ (void)jwModifyDeviceName:(NSString *)name;

/**
 发送消息通知给手环显示，主要用于生产工具

 @param type type description
    0：其它APP类型
    1： QQ
    2: WECHAT
    3:TIM
    4:SMS
    5:GMAIL
    6:DINGTALK
    。。。。。
 
 @param value 要显示的信息
 
 Send a message notification to the bracelet display, mainly used for production tools

  param type type description
     0: Other APP types
     1: QQ
     2: WECHAT
     3:TIM
     4: SMS
     5: GMAIL
     6:DINGTALK
     . . . . .
 
  param value Information to be displayed
 */
+ (void)jwSendNotiWithType:(int)type andValue:(NSString *)value;

//获取电池电压   Get battery voltage
+ (void)jwGeBATTERT_VOLTAGEWithBlock:(void (^)(JWBleCommunicationStatus status, int value))callBack;

//获取PATCH版本  Get PATCH version
+ (void)jwGetPATCH_VERSIONWithBlock:(void (^)(JWBleCommunicationStatus status, NSString *version))callBack;

//获取Gsensor ID数据  Get Gsensor ID data
+ (void)jwGetGSENSOR_IDWithBlock:(void (^)(JWBleCommunicationStatus status, NSDictionary *result))callBack;

//获取心率IC ID 数据  Get heart rate IC ID data
+ (void)jwGetHR_IC_IDWithBlock:(void (^)(JWBleCommunicationStatus status, BOOL correct, int chipID))callBack;

//获取HALL状态  0舱内 1舱外   Get HALL status 0 inside 1 outside
+ (void)jwGetHALLWithBlock:(void (^)(JWBleCommunicationStatus status, BOOL open))callBack;

//默认功能设置  Default function settings
+ (void)jwDefaultFunctionSettings:(BOOL)bpOpen temperatureOpen:(BOOL)temperatureOpen pressureOpen:(BOOL)pressureOpen sceneControl:(BOOL)sceneControl alexa:(BOOL)alexa;
+ (void)jwGetDefaultFunctionSettings:(void (^)(JWBleCommunicationStatus status, BOOL bpOpen, BOOL temperatureOpen, BOOL pressureOpen, BOOL sceneControl, BOOL alexa))callBack;

//生产测试结束  End of production test
+ (void)jwProduceEnd:(void (^)(JWBleCommunicationStatus status))callBack;

//读取已连接的手环rssi   Read the connected bracelet rssi
+ (void)jwReadConnectedRssi:(void (^)(NSNumber *rssi))callBack;

/**
 常驻显示文本
 @param show 显示 or 隐藏
 @param content 文本
 
 Permanent display text
 param show show or hide
 param content text
 */
+ (void)jwShowText:(BOOL)show content:(NSString *)content;

/**
  是否开启马达
  @param open 开启 or 关闭
 
 Whether to turn on the motor
 param open on or off
 */
+ (void)jwShowMotor:(BOOL)open;

/// 获取手环目前的uid
/// @param callBack uid
///
/// Get the current uid of the bracelet
/// @param callBack uid
//+ (void)jwGetDeviceUid:(void (^)(JWBleCommunicationStatus status, NSString *uid))callBack;

/// 获取设备的SN ID
/// @param callBack callBack description
///
/// Get the SN ID of the device
/// param callBack callBack description
+ (void)jwGetDeviceSNIDWithBlock:(void (^)(JWBleCommunicationStatus status, NSString *snID))callBack;

// 设置温度 36.5 则传365
// Set the temperature 36.5, then pass 365
+ (void)jwSetTemperature:(int)value callBack:(void (^)(JWBleCommunicationStatus status, BOOL success))callBack;

// 请求 心率漏光值
// Request heart rate light leakage value
+ (void)jwGetDeviceHeartRateLightLeakage:(BOOL)open callBack:(void (^)(JWBleCommunicationStatus status, NSInteger ps, NSInteger pre, NSInteger current, NSInteger pass))callBack;

// 设置手环MAC地址更新
// Set the bracelet MAC address update
+ (void)jwUpdateMacAddress:(NSString *)macStr callBack:(void (^)(JWBleCommunicationStatus status, BOOL success))callBack;

// 设置手环SN更新
// Set the bracelet SN update
+ (void)jwUpdateSN:(NSString *)sn callBack:(void (^)(JWBleCommunicationStatus status, BOOL success))callBack;

// 设置手环SN更新v2，仅数字
// Set the bracelet SN update v2 numbers only
+ (void)jwUpdateSN_V2:(NSString *)sn callBack:(void (^)(JWBleCommunicationStatus status, BOOL success))callBack;

// reset指令(恢复出厂)
// reset command (restore factory)
+ (void)jwReset;

//获取温度标定返回
//Get temperature calibration
+ (void)jwGetTemperatureWithCallBack:(void (^)(JWBleCommunicationStatus status, BOOL already, NSInteger frequency, NSInteger temperatureInital))callBack;

//获取手环history数据地址
//Get the wristband history data address
+ (void)jwGetHistoryAddress:(void (^)(JWBleCommunicationStatus status, NSData *step, NSData *sleep, NSData *hr, NSData *bp ,NSData *motion))callBack;

//进行LE广播
//Conduct LE broadcast
+ (void)doLEBroadcast;

//进入DUT模式
//Enter DUT mode
+ (void)enterDUT;

//获取生产测试功能
//Get production test capabilities
+ (void)jwGetFactoryFunctionWithCallBack:(JwFactoryFunctionCallBack)callBack;

//获取生产测试功能
//Get production test capabilities
+ (void)jwGetFactoryFunctionWithCallBack222:(JwFactoryFunctionCallBack)callBack;

//打开、关闭 手环TP功能
+ (void)jwUpdateTpModel:(BOOL)open callBack:(void (^)(JWBleCommunicationStatus status, int x, int y))callBack;

//license相关
+ (void)jwGetLicense:(void (^)(JWBleCommunicationStatus status, NSString *uuid, NSString *key, NSString *licenseTargetPId))callBack;
+ (void)jwSetLicense:(NSString *)uuid key:(NSString *)key mac:(NSString *)mac sn:(NSString *)sn callBack:(void (^)(JWBleCommunicationStatus status, BOOL success))callBack;

//opus相关
+ (void)jwOpenOpus:(BOOL)open;

//tp信息
+ (void)jwGetTpInfoWithCallBack:(void (^)(JWBleCommunicationStatus status, int info1, int info2, int info3))callBack;

// uv 紫外
// Request uv value
+ (void)jwGetDeviceUV:(BOOL)open callBack:(void (^)(JWBleCommunicationStatus status, NSInteger level))callBack;

/**
 PID操作
 */
+ (void)jwPIDAction:(BOOL)isGet pid:(NSString *)pid callBack:(void (^)(JWBleCommunicationStatus status, NSString *pid))callBack;

/**
 获取睡眠原数据
 */
+ (void)jwGetOriSleepDataWithCallBack:(void (^)(JWBleCommunicationStatus status, NSData *data))callBack;

/**
 获取手环测试结果
 */
+ (void)jwGetDeviceTestResultWithCallBack:(void (^)(JWBleCommunicationStatus status, NSData *data))callBack;

/**
 固件烧录配置
 */
+ (void)jwSteFirmwareBurningConfiguration:(NSString *)resultStr callBack:(void (^)(JWBleCommunicationStatus status, BOOL success))callBack;
+ (void)jwGetFirmwareBurningConfigurationWithCallBack:(void (^)(JWBleCommunicationStatus status, NSString *resultStr))callBack;

/**
 DVT检查
 */
+ (void)jwDvtCheckAction:(BOOL)isGet index:(int)showIndex callBack:(void (^)(JWBleCommunicationStatus status, int count))callBack;

@end

