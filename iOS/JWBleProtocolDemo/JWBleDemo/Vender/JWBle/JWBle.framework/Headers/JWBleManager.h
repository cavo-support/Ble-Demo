//
//  JWBleManager.h
//  JWBle
//
//  Created by Bo 黄 on 2019/3/20.
//  Copyright © 2019 wosmart. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JWBleDeviceModel.h"
#import "JWBlePublicDefine.h"

NS_ASSUME_NONNULL_BEGIN

@interface JWBleManager : NSObject

+ (JWBleManager *)shareInstance;

- (NSString *)sdkInfo;
- (NSDictionary *)sdkInfoDic;

/**
 初始化
 
 @param uid 标志id （
    使用场景：
        1、A账号连接了，B账号再连接会连接失败，需要A账号解绑
        2、A账号在A手机上连接，使用B手机登录A账号，也可以连接
 ）
 
 initialization
 
  param uid logo id (
     scenes to be used:
         1. The A account is connected, and the B account will fail to connect again, and the A account needs to be unbound
         2. The A account is connected to the A phone. Use the B phone to log in to the A account, and you can also connect
  )
 */
- (void)setUpWithUid:(NSString *)uid;

/**
 是否显示日志
 
 默认: false
 
 Whether to display the log
 
  Default: false
 */
@property(nonatomic, assign) BOOL showLog;
/**
 是否保存日志
     默认：false
     描述：
        1：前提showLog必须为true，否则无效
        2：获取log方式为[JWLogModel getLog];
        3：开启保存日志，会影响性能
 
 Whether to save the log
    Default: false
    describe:
      1:  The premise showLog must be true, otherwise it is invalid
      2:  The way to get the log is [JWLogModel getLog];
      3：Turning on saving logs will affect performance
 */
@property(nonatomic, assign) BOOL saveLog;
/**
 保存日志的缓存条数
    默认：30条
    描述：缓存到达设置的值后，才会批量保存日志，值越小影响性能越明显，值越大可能会丢失一些日志
 
 The number of cache entries for saving logs
      Default: 30
      Description: After the cache reaches the set value, the logs will be saved in batches. The smaller the value, the more obvious the impact on performance, and the larger the value may lose some logs
 */
@property(nonatomic, assign) int cacheLogCount;


/**
 是否是生产模式
 决定是否回连手环
 
 默认: false
 
 Is it in production mode
 Decide whether to return to the bracelet
 
 Default: false
 */
@property(nonatomic, assign) BOOL isProduce;
@property(nonatomic, assign) BOOL checkSpecialOtaShutdown;
@property(nonatomic, strong) NSMutableArray *cacheLogArr;

/**
 是否已连接，但是不包括登录成功和绑定成功
 
 Whether it is connected, but does not include the successful login and successful binding
 */
@property(nonatomic, assign) BOOL isConnected;
@property (nonatomic, assign) BOOL isConnecing;

/**
 链接状态
 
 Link status
 */
@property(nonatomic, assign) JWBleDeviceConnectStatus deviceConnectStatus;

/**
 已连接的model
 
 Connected model
 */
@property(nonatomic, strong) JWBleDeviceModel *connectionModel;

/**
 链接状态回调
 
 Link status callback
 */
@property(nonatomic, copy) JWBleConnectStatusChangeCallBack connectStateChangeCallBack;

/**
 遥控拍照回调
 
 Remote control camera callback
 */
@property(nonatomic, copy) JWBleRemotePhotographyCallBack remotePhotographyCallBack;

/**
 同步数据进度回调
 
 Synchronous data progress callback
 */
@property(nonatomic, copy) JWBleSynchronousDataProgressCallBack synchronousDataProgressCallBack;

/**
 LANGCO 翻译回调
 
 LANGCO translation callback
 */
@property(nonatomic, copy) JWBleLangCoTranslationCallBack langCoTranslationCallBack;

/**
 查找手机回调
 
 Find phone callback
 */
@property(nonatomic, copy) JWBleFindPhoneCallBack findPhoneCallBack;
/**
 查找手机回调V2
 
 Find phone callback V2
 */
@property(nonatomic, copy) JWBleFindPhoneV2CallBack findPhoneV2CallBack;

/**
 手机蓝牙状态回调
 
 Phone Bluetooth status callback
 */
@property(nonatomic, copy) JWCentralManagerStateChangeBlock centralManagerStateChangeBlock;

/**
 实时心率回调
 
 Real-time heart rate callback
 */
@property(nonatomic, copy) JWBleRealTimeHeartRateCallBack realTimeHeartRateCallBack;

/**
 实时体温回调
 
 Real-time temperature callback
 */
@property(nonatomic, copy) JWBleRealTimeTemperatureCallBack realTimeTemperatureCallBack;

/**
 脉冲结束回调 Pulse end callback
 */
@property(nonatomic, copy) JWBleEndOfPulseCallBack endOfPulseCallBack;

/**
 脉冲数据回调 Pulse data callback
 */
@property(nonatomic, copy) JWBlePulseDataCallBack pulseDataCallBack;

/**
 脉冲数据回调 sauna data callback
 */
@property(nonatomic, copy) JWBleSaunaDataCallBack saunaDataCallBack;

//Opus数据回调 -- Opus数据回调
@property(nonatomic, copy) JWBleOpusDataCallBack opusDataCallBack;

// ecg 数据回调
@property(nonatomic, copy) JwECGDataCallBack ecgDataCallBack;
@property(nonatomic, copy) JwECGOriDataCallBack ecgOriDataCallBack;

// ecg 数据回调
@property(nonatomic, copy) JwDeviceTestECGCallBack deviceTestECGCallBack;

// ecg 数据回调
@property(nonatomic, copy) JwECGValueDataCallBack ecgValueDataCallBack;

// belt
@property(nonatomic, copy) JwBeltValueDataCallBack beltValueDataCallBack;
@property(nonatomic, copy) JwBeltDataCallBack beltDataCallBack;

// Device switch change callback
@property(nonatomic, copy) JwDeviceSwitchChangeCallBack deviceSwitchChangeCallBack;

// 尿酸状态改变回调 uricAcid status callback
@property(nonatomic, copy) JWBleUricAcidStatusCallBack uricAcidStatusCallBack;

//血脂状态改变回调 bloodFat status callback
@property(nonatomic, copy) JWBleBloodFatStatusCallBack bloodFatStatusCallBack;

//周期血糖状态改变回调 bloodGlucoseCycle status callback
@property(nonatomic, copy) JWBleBloodGlucoseCycleStatusCallBack bloodGlucoseCycleStatusCallBack;

//设备结束点测回调 Device end Measurement callback
@property(nonatomic, copy) JWBleEndMeasurementStatusCallBack endMeasurementStatusCallBack;

//设备体脂数据回调 Device body fat data callback
@property(nonatomic, copy) JWBleBodyFatDataCallBack bodyFatDataCallBack;


/**
 连接后是否弹出系统配对窗口，默认YES
 
 Whether to pop up the system pairing window after connection, default YES
 */
@property(nonatomic, assign) BOOL isAutoShowPair;

/**
 检查用户绑定，默认YES
 同一个手环被“A”uid用户连接，在不解绑情况下，使用“B”uid用户去连接，是否能被连接上
 
 Check User Binding, default YES
 The same bracelet is connected by the "A" uid user, if the "B" uid user is used to connect without unbinding, can it be connected?
 */
@property(nonatomic, assign) BOOL checkUserBinding;

@end

NS_ASSUME_NONNULL_END
