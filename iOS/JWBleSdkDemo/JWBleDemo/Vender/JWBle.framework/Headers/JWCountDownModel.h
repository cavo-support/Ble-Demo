//
//  JWCountDownModel.h
//  JWBle
//
//  Created by Bo 黄 on 2019/10/22.
//  Copyright © 2019 wosmart. All rights reserved.
//

#import <Foundation/Foundation.h>

//状态枚举
typedef NS_ENUM (NSInteger, JWCountDownOptionEnum) {
    JWCountDownOptionEnum_Setting,
    JWCountDownOptionEnum_Start,
    JWCountDownOptionEnum_Stop,
};

@interface JWCountDownModel : NSObject

/**
 秒数
 
 范围：[1~86400]
 
 Seconds
 
 Range: [1~86400]
 */
@property(nonatomic, assign) int seconds;

/**
 操作
 如果是读取数据的话，当状态为JWCountDownOptionEnum_Start时，返回的seconds是剩余秒数
 
 operating
 If you are reading data, when the status is JWCountDownOptionEnum_Start, the returned seconds is the number of seconds remaining
 */
@property(nonatomic, assign) JWCountDownOptionEnum optionEnum;

/**
 是否显示在手环ui上
 
 Whether to show on the bracelet ui
 */
@property(nonatomic, assign) bool open;

@end
