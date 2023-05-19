//
//  JWBleDataAction.h
//  JWBle
//
//  Created by Bo 黄 on 2019/8/30.
//  Copyright © 2019 wosmart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JWBlePublicModelDefine.h"

@interface JWBleDataAction : NSObject

/**
 同步数据
 
 Synchronous Data
 
 @param callBack 回调
 */
+ (void)jwSyncDataWithCallBack:(JWBleSyncCallBack)callBack;

/**
 读取记步数据

 @param yyyymmddStr  获取的日期 如：20180911
 @param callBack
 
 1、dataArr会有96个，从00：00~23：45 间隔15分钟 一个
 2、如果获取失败，则dataArr为@[]
 3、手环显示 卡路里取整数（小数直接抛弃），公里数四舍五入
 
 dataArr:
 [
     {
         offset:0(第几个15分钟)
         steps:11 (步数),
         calory:22 (卡路里，单位卡),
         distance:33(距离，单位 米)
     }
 ]
 
 
 Read step data

  param yyyymmddStr The date obtained is as follows: 20180911
  param callBack
 
  1. There will be 96 dataArr, from 00:00 to 23:45, every 15 minutes
  2. If the acquisition fails, the dataArr is @[]
  3. Bracelet display Calories are rounded (decimal numbers are directly discarded), kilometers are rounded
 
  dataArr:
  [
      {
          offset:0 (the first 15 minutes)
          steps:11 (number of steps),
          calory:22 (calories, unit card),
          distance: 33 (distance, unit m)
      }
  ]
 */
+ (void)jwGetStepDataByYYYYMMDDStr:(NSString *)yyyymmddStr callBack:(void (^)(NSArray *dataArr))callBack;

/**
 获取某天的计步数据

 @param yyyymmddStr  获取的日期 如：20180911
 @param callBack callBack description
 
 steps:11 (步数),
 calory:22 (卡路里，单位卡),
 distance:33(距离，单位 米)
 
 Get step count data for a day

  param yyyymmddStr The date obtained is as follows: 20180911
  param callBack callBack description
 
  steps:11 (number of steps),
  calory:22 (calories, unit card),
  distance: 33 (distance, unit m)
 */
+ (void)jwGetDayStepTotalValue:(NSString *)yyyymmddStr callback:(void (^)(JWBleCommunicationStatus status, int step, int dis, int calories))callBack;
/**
 设置某天的具体步数
 
 yyyymmddStr： The date obtained is as follows: 20180911
 arr:[
        {
         NSInteger time;
         NSInteger steps;
         NSInteger calory;
         NSInteger distance;
        },
        {
        ...
        }
 ]
 */
+ (void)jwSetTodayStepData:(NSString *)yyyymmddStr arr:(NSArray<NSDictionary *> *)arr;

/**
 获取睡眠数据

 @param yyyymmddStr  获取的日期 如：20180911
 @param callBack
 
 1、返回的是每分钟数据 即每日有1440分钟。
 
 dataArr:
 [
     {
         minute:1386 （第几分钟）
         status:  1 （1：浅睡，2：深睡，3：清醒）
         yyyyMMdd: 20190901
     },
     {
     minute:36 （第几分钟）
     status:  3 （1：浅睡，2：深睡，3：清醒）
     yyyyMMdd: 20190902
     }
 ]
 
 
 Get sleep data

  param yyyymmddStr The date obtained is as follows: 20180911
  param callBack
 
  1. The data returned per minute is 1440 minutes per day.
 
  dataArr:
  [
      {
          minute:1386 (the first few minutes)
          status: 1 (1: light sleep, 2: deep sleep, 3: sober)
          yyyyMMdd: 20190901
      },
      {
      minute:36 (the first few minutes)
      status: 3 (1: light sleep, 2: deep sleep, 3: sober)
      yyyyMMdd: 20190902
      }
  ]
 
 */
+ (void)jwGetSleepDataByYYYYMMDDStr:(NSString *)yyyymmddStr callBack:(void (^)(NSArray *dataArr))callBack;
/**
 计算睡眠质量 sleep quality calculation
 @param firstSleepMinute 第一段睡眠的时长
 @param deepMinute 深睡分钟数
 @param totalMinute 总睡眠分钟数
 @param wakeUpCount 属性次数
 
 return:
    0：较差     poor
    1：较差     poor
    2：一般    generally
    3：好        good
    4：很好    very good
    5：完美    Perfect
 */
+ (int)jwSleepQualityCalculation:(NSInteger)firstSleepMinute deepMinute:(NSInteger)deepMinute totalMinute:(NSInteger)totalMinute wakeUpCount:(NSInteger)wakeUpCount;

/**
 获取心率数据

 @param yyyymmddStr 获取的日期 如：20180911
 @param callBack
 
 返回的数据按照time排序 从小到大 返回
 
 dataArr:
 [
    {
         time:1567576122 (时间戳),
         value:123 (心率值)
    }，
     {
     time:1567576122 (时间戳),
     value:123 (心率值)
     }
 ]
 
 Get heart rate data

  param yyyymmddStr The date obtained is as follows: 20180911
  param callBack
 
  The returned data is sorted by time, from small to large. Back
 
  dataArr:
  [
     {
          time:1567576122 (timestamp),
          value:123 (heart rate value)
     },
      {
      time:1567576122 (timestamp),
      value:123 (heart rate value)
      }
  ]
 */
+ (void)jwGetHRDataByYYYYMMDDStr:(NSString *)yyyymmddStr callBack:(void (^)(NSArray *dataArr))callBack;
+ (void)jwGetHRDataByStartT:(NSInteger)startT endT:(NSInteger)endT callBack:(void (^)(NSArray *dataArr))callBack;

/**
 获取血压数据

 @param yyyymmddStr 获取的日期 如：20180911
 @param callBack
 
 返回的数据按照time排序 从小到大 返回

 dataArr:
 [
    {
         time:1567576122 (时间戳),
         high:123(高压)
         low:56(低压)
    }，
     {
         time:1567576122 (时间戳),
         high:123(高压)
         low:56(低压)
     }
 ]
 
 
 Get blood pressure data

  @param yyyymmddStr Date obtained such as: 20180911
  @param callBack
 
  The returned data is sorted by time, from small to large.
 
  dataArr:
  [
     {
          time:1567576122 (time stamp),
          high: 123 (high pressure)
          low: 56 (low pressure)
     },
      {
          time:1567576122 (time stamp),
          high: 123 (high pressure)
          low: 56 (low pressure)
      }
  ]
 */
+ (void)jwGetBpDataByYYYYMMDDStr:(NSString *)yyyymmddStr callBack:(void (^)(NSArray *dataArr))callBack;
+ (void)jwGetBpDataByStartT:(NSInteger)startT endT:(NSInteger)endT callBack:(void (^)(NSArray *dataArr))callBack;

/**
 获取温度数据
 
 @param yyyymmddStr 获取的日期 如：20180911
 @param callBack
 dataArr:
 [
    {
        time:1567576122 (时间戳),
        value:123 (温度值),
        wearingState:0/1(佩戴状态),
        compensationStatus:0/1(补偿状态)
    }，
    {
        time:1567576122 (时间戳),
        value:123 (温度值),
        wearingState:0/1(佩戴状态),
        compensationStatus:0/1(补偿状态)
    }
 ]
 
 
 Get temperature data
 
  param yyyymmddStr The date obtained is as follows: 20180911
  param callBack
  dataArr:
  [
     {
         time:1567576122 (timestamp),
         value:123 (temperature value),
         wearingState:0/1 (wearing state),
         compensationStatus:0/1 (compensation status)
     },
     {
         time:1567576122 (timestamp),
         value:123 (temperature value),
         wearingState:0/1 (wearing state),
         compensationStatus:0/1 (compensation status)
     }
  ]
 
 */
+ (void)jwGetTemperatureDataByYYYYMMDDStr:(NSString *)yyyymmddStr callBack:(void (^)(NSArray *dataArr))callBack;
+ (void)jwGetTemperatureDataByStartT:(NSInteger)startT endT:(NSInteger)endT callBack:(void (^)(NSArray *dataArr))callBack;
/**
 温度数据校准
 
 value: 设备返回来的数据
 注意：设备返回compensationStatus时才需要校准
 
 Temperature data calibration
 Value: Data returned by the device
 Note: Calibration is only required when the device returns to the compensationStatus
 */
+ (float)jwTemperatureCalibration:(float)value;

/**
 获取 设备血氧数据
 @param yyyymmddStr 获取的日期 如：20180911
 @param callBack
 dataArr:
 [
    JWOxygenModel,JWOxygenModel,JWOxygenModel,JWOxygenModel...
 ]
 
 Get device blood oxygen data
   The date obtained by @param yyyymmddStr such as: 20180911
   @param callBack
   dataArr:
   [
      JWOxygenModel, JWOxygenModel, JWOxygenModel, JWOxygenModel...
   ]
 */
+ (void)jwGetOxygenDataByYYYYDDStr:(NSString *)yyyymmddStr callBack:(void (^)(NSArray *dataArr))callBack;
+ (void)jwGetOxygenDataByStartT:(NSInteger)startT endT:(NSInteger)endT callBack:(void (^)(NSArray *dataArr))callBack;

/**
 获取 设备HRV数据
 @param yyyymmddStr 获取的日期 如：20180911
 @param callBack
 dataArr:
 [
    {
     @"hrvValue": // HRV 值
     @"time": //时间戳
    }
 ]
 
 Get equipment HRV data
   The date obtained by @param yyyymmddStr such as: 20180911
   @param callBack
   dataArr:
   [
      {
       @"hrvValue": // HRV value
       @"time": //time stamp
      }
   ]
 */
+ (void)jwGetHrvDataByYYYYDDStr:(NSString *)yyyymmddStr callBack:(void (^)(NSArray *dataArr))callBack;
+ (void)jwGetHrvDataByStartT:(NSInteger)startT endT:(NSInteger)endT callBack:(void (^)(NSArray *dataArr))callBack;


/**
 获取 设备血糖数据
 @param yyyymmddStr 获取的日期 如：20180911
 @param callBack
 dataArr:
 [
    {
     @"value": // 血糖 值
     @"time": //时间戳
    }
 ]
 
 Get equipment BloodGlucose data
   The date obtained by @param yyyymmddStr such as: 20180911
   @param callBack
   dataArr:
   [
      {
       @"value": // BloodGlucose value
       @"time": //time stamp
      }
   ]
 */
+ (void)jwGetBloodGlucoseDataByYYYYDDStr:(NSString *)yyyymmddStr callBack:(void (^)(NSArray *dataArr))callBack;
+ (void)jwGetBloodGlucoseDataByStartT:(NSInteger)startT endT:(NSInteger)endT callBack:(void (^)(NSArray *dataArr))callBack;

/**
 获取 设备脉冲数据
 @param yyyymmddStr 获取的日期 如：20180911
 @param callBack
 dataArr:
 [
    {
     @"value": //  值
     @"time": //时间戳
    }
 ]
 
 Get device pulse data
   The date obtained by @param yyyymmddStr such as: 20180911
   @param callBack
   dataArr:
   [
      {
       @"value": //  value
       @"time": //time stamp
      }
   ]
 */
+ (void)jwGetPulseDataByYYYYDDStr:(NSString *)yyyymmddStr callBack:(void (^)(NSArray *dataArr))callBack;
+ (void)jwGetPulseDataByStartT:(NSInteger)startT endT:(NSInteger)endT callBack:(void (^)(NSArray *dataArr))callBack;

/**
 获取运动数据

 @param yyyymmddStr 获取的日期 如：20180911
 @param callBack
 
 @[
    @{
         @"pk"  //主键
         @"year": 2019
         @"month": 9
         @"day": 7
         @"minuteIndex": 995
         @"seconds": 19
         @"motionType": 运动类型 （JWBleDeviceMotionEnum）
         @"sportsMinute": 运动时长分钟数
         @"sportsSeconds": 运动时长秒数
         @"pauseCount": 暂停次数
         @"pauseMinute": 暂停分钟数
         @"pauseSeconds": 暂停秒数
         @"stepCount": 运动步数
         @"distance": 运动距离 单位 米
         @"uid": 所属用户id
         @"calories": 消耗卡路里 单位卡
     },
    @{
        ......
    }
 ]
 
 
 Get sports data

  param yyyymmddStr The date obtained is as follows: 20180911
  param callBack
 
  @[
     @{
          @"pk" //Primary key
          @"year": 2019
          @"month": 9
          @"day": 7
          @"minuteIndex": 995
          @"seconds": 19
          @"motionType": sports type (JWBleDeviceMotionEnum)
          @"sportsMinute": minutes of exercise time
          @"sportsSeconds": the number of seconds of exercise time
          @"pauseCount": number of pauses
          @"pauseMinute": Pause minutes
          @"pauseSeconds": Pause seconds
          @"stepCount": number of exercise steps
          @"distance": Movement distance in meters
          @"uid": user id
          @"calories": calories burned per unit card
      },
     @{
         ...
     }
  ]
 
 */
+ (void)jwGetMotionDataByYYYYMMDDStr:(NSString *)yyyymmddStr callBack:(void (^)(NSArray *dataArr))callBack;

+ (void)jwRemoveMotionDataWithPK:(int)pk;

/**
 删除某个时间戳之前的数据
 
 Delete data before a certain timestamp
 
 t: 小于该时间戳的时间 time less than this timestamp
 */
+ (void)jwRemoveDataTimeLessThan:(NSInteger)t;

/**
 删除某个时间戳之前的数据
 
 Delete data before a certain timestamp
 
 t: 小于该时间戳的时间 time less than this timestamp
 dataType: JWDeleteDataType
    
 */
+ (void)jwRemoveDataTimeLessThan:(NSInteger)t dataType:(JWDeleteDataType)dataType;


@end

