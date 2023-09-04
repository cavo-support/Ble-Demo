//
//  JWBlePublicHelp.h
//  JWBle
//
//  Created by Bo 黄 on 2019/5/5.
//  Copyright © 2019 wosmart. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JWBlePublicHelp : NSObject

/**
 步数换算距离

 @param height 身高 单位cm
 @param stepCount 步数
 @return 公里 单位公里
 
 Step conversion distance

 param height height in cm
 param stepCount step count
 return kilometers in kilometers
 */
+ (float)jw_step2DisWith:(int)height andStepCount:(int)stepCount;

/**
 距离换算卡路里
 
 @param weight 体重 单位kg
 @param dis 距离 单位千米
 @return 卡路里 单位千卡
 
 Calorie conversion
 
  param weight weight unit kg
  param dis distance in kilometers
  return Calories per kilocalorie
 */
+ (float)jw_dis2CalWith:(float)weight andDis:(float)dis;

@end

