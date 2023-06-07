//
//  JWBleAlarmClockModel.h
//  JWBle
//
//  Created by Bo 黄 on 2019/3/21.
//  Copyright © 2019 wosmart. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JWBleAlarmClockModel : NSObject

/**
 年
 
 有效值 0-63，从 2000 年开始，13 表示 2013 年。
 
 year
 
  Valid values are 0-63, starting in 2000, 13 means 2013.
 */
@property(nonatomic, assign) int year;

/**
 月
 
 1-12
 */
@property(nonatomic, assign) int month;

/**
 日
 
 1-31
 */
@property(nonatomic, assign) int day;

/**
 小时
 
 0-23
 */
@property(nonatomic, assign) int hour;

/**
 分钟
 
 0-59
 */
@property(nonatomic, assign) int minute;

/**
 重复的周字符串数组
 
 (星期一，星期二...星期日，必须设置固定七个数据数组，传0(未选中)或1(选中))
 
 如：[1,0,0,0,0,0,1] 表示每周一、周日提醒
   [0,0,0,0,0,0,0]  或者 nil  或者 []  或者 不足七位  表示当次有效
 
 Array of repeated week strings
 
 (Sunday, Saturday...Monday, you must set a fixed seven data array, pass 0 (unselected) or 1 (selected))
 
  For example: [1,0,0,0,0,0,1] means reminder every Sunday and Monday
    [0,0,0,0,0,0,0] or nil or [] or less than seven digits means it is valid at the time
 */
@property(nonatomic, strong) NSArray *repeatWeekArr;


#pragma mark - V2

/**
 id（闹钟V2.0）
 
 id (alarm clock V2.0)
 */
@property(nonatomic, assign) int idd;

/**
 是否开启（闹钟V2.0）
 
 Whether to open (alarm clock V2.0)
 */
@property(nonatomic, assign) bool isOpen;

/**
 显示文本（闹钟V2.0）
 
 Display text (Alarm Clock V2.0)
 */
@property(nonatomic, strong) NSString *content;

@end

NS_ASSUME_NONNULL_END
