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

+ (NSString *)version;

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
 是否是生产模式
 决定是否回连手环
 
 默认: false
 
 Is it in production mode
 Decide whether to return to the bracelet
 
 Default: false
 */
@property(nonatomic, assign) BOOL isProduce;
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

//Opus数据回调 -- Opus数据回调
@property(nonatomic, copy) JWBleOpusDataCallBack opusDataCallBack;

// ecg 数据回调
@property(nonatomic, copy) JwECGDataCallBack ecgDataCallBack;
// ecg 数据回调
@property(nonatomic, copy) JwDeviceTestECGCallBack deviceTestECGCallBack;

// ecg 数据回调
@property(nonatomic, copy) JwECGValueDataCallBack ecgValueDataCallBack;

// Device switch change callback
@property(nonatomic, copy) JwDeviceSwitchChangeCallBack deviceSwitchChangeCallBack;


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
