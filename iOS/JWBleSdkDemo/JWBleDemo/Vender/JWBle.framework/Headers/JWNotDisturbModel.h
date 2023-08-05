//
//  JWNotDisturbModel.h
//  JWBle
//  勿扰模式model
//  Created by Bo 黄 on 2019/8/8.
//  Copyright © 2019 wosmart. All rights reserved.
//

#import <Foundation/Foundation.h>

//勿扰模式枚举  Do not disturb mode enumeration
typedef NS_ENUM (NSInteger, JWBleNotDisturbEnum) {
    JWBleNotDisturbEnum_AllDay,//全天勿扰  Do not disturb all day
    JWBleNotDisturbEnum_NotWorn,//未佩戴勿扰  Do not disturb without wearing
    JWBleNotDisturbEnum_Timing//定时勿扰  Do not disturb
};

@interface JWNotDisturbModel : NSObject

/**
 是否打开
 
 Whether to open
 */
@property(nonatomic, assign) BOOL open;

/**
 情景枚举
 
 Scenario enumeration
 */
@property(nonatomic, assign) JWBleNotDisturbEnum enumType;

/**
 开始小时 0~23
 
 Start hour 0~23
 */
@property(nonatomic, assign) UInt32 startHour;

/**
 开始分钟 0~59
 
 Start minute 0~59
 */
@property(nonatomic, assign) UInt32 startMinute;

/**
 结束小时 0~23
 
 End hour 0~23
 */
@property(nonatomic, assign) UInt32 endHour;

/**
 结束分钟 0~59
 
 End minute 0~59
 */
@property(nonatomic, assign) UInt32 endMinute;

@end

