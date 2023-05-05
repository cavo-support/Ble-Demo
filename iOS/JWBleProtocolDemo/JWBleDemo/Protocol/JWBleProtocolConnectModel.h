//
//  JWBleProtocolConnectModel.h
//  JWBleDemo
//
//  Created by bobobo on 2023/5/5.
//  Copyright © 2023 wosmart. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JWBleProtocolConnectModel : NSObject

/**
 信号
 signal
 */
@property(nonatomic, strong) NSNumber *rssi;

/**
 已经绑定的手环，mac地址会不一样
 Bracelet already bound, mac address will be different
 */
@property(nonatomic, strong) NSString *systemMacAddress;

/**
 版本字符串
 Version string
 */
@property(nonatomic, strong) NSString *versionName;

/**
 版本号
 version number
 */
@property(nonatomic, assign) int versionCode;

/**
 字库版本号
 font version number
 */
@property(nonatomic, assign) int fontVersionCode;

/**
 字库版本号字符串
 font version number string
 */
@property(nonatomic, strong) NSString *fontVersionCodeStr;

/**
 mac地址
 mac address
 */
@property(nonatomic, strong) NSString *macAddress;


/**
 电量
 Power
 */
@property(nonatomic, assign) int power;

/**
 设备号
 
 Device No
 */
@property(nonatomic, assign) int deviceNumber;

/**
 设备名称
 Device name
 */
@property(nonatomic, strong) NSString *deviceName;

/**
 可用功能data
 Available functions data
 */
@property(nonatomic, strong) NSData *functionData;

/**
 可用功能data v2
 Available functions data
 */
@property(nonatomic, strong) NSArray *functionDataV2;

/**
 隐藏功能菜单data
 Hide function menu data
 */
@property(nonatomic, strong) NSData *hideFunctionMenu;

/**
 可用通知data
 Available notification data
 */
@property(nonatomic, strong) NSData *notiData;

/**
 外设
 Peripherals
 */
@property (nonatomic, strong) CBPeripheral *per;

/**
 是否是dfu设备
 Whether it is a dfu device
 */
@property(nonatomic, assign) BOOL isDFU;

/**
 是否正在OTA
 Are you on OTA
 */
@property(nonatomic, assign) BOOL otaIng;

/// 是否在充电中  Whether it is charging
@property(nonatomic, assign) BOOL chargIng;

/// 耳机是否配对过 Has the headset been paired
@property(nonatomic, assign) BOOL headsetPaired;

/**
 耳机状态
  0: 关机
  1：配对中
  2：准备就绪
  3：已连接
  4：耳机被手机连接中
 
 Headphone status
 0: shutdown
 1: Pairing
 2: ready
 3: connected
 4: The headset is connected with the mobile phone
 */
@property(nonatomic, assign) int headphoneDeviceStatus;

/**
 设备状态（省点模式、飞行模式等） 具体查看 JWDeviceStatusType 这个枚举
 
 Device status (point-saving mode, flight mode, etc.) See the enumeration JWDeviceStatusType for details
 */
@property(nonatomic, strong) NSArray *deviceStatusTypeArr;

// 芯片类型 chip type
@property(nonatomic, assign) int chipType;

@property (nonatomic, strong) NSDictionary<NSString *, id> *advertisementData;

//手环可控制的开关数据  The switch data that the bracelet can control
@property(nonatomic, strong) NSData *deviceSwitchData;


@end
