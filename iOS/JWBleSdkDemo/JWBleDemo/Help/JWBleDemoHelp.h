//
//  JWBleDemoHelp.h
//  JWBleDemo
//
//  Created by Bo 黄 on 2019/3/20.
//  Copyright © 2019 wosmart. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JWBleDemoHelp : NSObject

+ (NSString *)communication2Str:(JWBleCommunicationStatus)status;

+ (NSString *)motionEnumStr:(JWBleDeviceMotionEnum)status;

+ (int)getZoneInt;

// 将JSON串转化为字典或者数组  数组转换字符串
+ (id)toArrayOrNSDictionary:(NSData *)jsonData;

// 将字典或者数组转化为JSON串
+ (NSData *)toJSONData:(id)theData;

+ (long long)dataToLong:(NSData *)data;

+ (NSData *)int2Data:(int)value;

@end

NS_ASSUME_NONNULL_END
