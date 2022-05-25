//
//  DemoAlarmClockModel.h
//  CoreBluetoothDemo
//
//  Created by Bo 黄 on 2019/3/6.
//  Copyright © 2019 Jone. All rights reserved.
//

#import "JKDBModel.h"
#import <JWBle/JWBle.h>

NS_ASSUME_NONNULL_BEGIN

@interface DemoAlarmClockModel : JKDBModel


/**
 是否开启
 */
@property(nonatomic, assign) bool isOpen;

/**
 是否重复
 */
@property(nonatomic, assign) bool repeat;

/**
 重复的周字符串
 
 (星期日，星期一...周六，必须设置固定七个数据数组，传0(未选中)或1(选中))
 
 如：[0,0,0,0,0,0,1] 表示每周六提醒
 */
@property(nonatomic, strong) NSArray *repeatWeekArr;

/**
 闹钟类型
 
 0：闹钟 1：事件
 */
@property(nonatomic, assign) int clockType;

/**
 事件内容描述
 
 不能超过十个字符
 */
@property(nonatomic, strong) NSString *eventDesc;

/**
 UTC时间
 */
@property(nonatomic, assign) NSTimeInterval utcTime;

/**
 时区
 */
@property(nonatomic, assign) int timeZone;

#pragma mark - help
@property(nonatomic, strong) NSString *repeatWeekArrStr;

#pragma mark - static
/**
 将demo的闹钟，转换为 蓝牙通信支持的闹钟

 @param clockArr clockArr description
 @return return value description
 */
+ (NSArray<JWBleAlarmClockModel *> *)converstion2DeviceAlarmClock:(NSArray<DemoAlarmClockModel *> *)clockArr;

/**
 设置device 闹钟
 
 @param clockArr clockArr description
 @param block block description
 */
+ (void)setDeviceAlarmClock:(NSArray<DemoAlarmClockModel *> *)clockArr callBack:(JWBleCommunicationCallBack)callBack;

/**
 储存，并且将数据同步给手环

 @param clockModel clockModel description
 @param block block description
 */
+ (void)saveAndSynchronize:(DemoAlarmClockModel *)clockModel callBack:(JWBleCommunicationCallBack)callBack;

+ (void)synchronization2DeviceWithCallBack:(JWBleCommunicationCallBack)callBack;

@end

NS_ASSUME_NONNULL_END
