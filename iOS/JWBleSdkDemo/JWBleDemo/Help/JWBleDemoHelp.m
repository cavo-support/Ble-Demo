//
//  JWBleDemoHelp.m
//  JWBleDemo
//
//  Created by Bo 黄 on 2019/3/20.
//  Copyright © 2019 wosmart. All rights reserved.
//

#import "JWBleDemoHelp.h"

@implementation JWBleDemoHelp

+ (NSString *)communication2Str:(JWBleCommunicationStatus)status {
    NSString *str = @"";
    if (status == JWBleCommunicationStatus_Faild) {
        str = NSLocalizedString(@"Bluetooth communication failed", nil);
    } else if (status == JWBleCommunicationStatus_Success) {
        str = NSLocalizedString(@"success", nil);
    } else if (status == JWBleCommunicationStatus_PWDError) {
        str = NSLocalizedString(@"Password is wrong, please re-verify the password", nil);
    } else if (status == JWBleCommunicationStatus_IsDFUModel) {
        str = NSLocalizedString(@"The device is in DFU mode", nil);
    }
    
    return str;
}

+ (NSString *)motionEnumStr:(JWBleDeviceMotionEnum)status {
    NSString *str = @"";
//    if (status == JWBleDeviceMotionEnum_Walk) {
//        str = @"步行";
//    } else if (status == JWBleDeviceMotionEnum_RunningOutdoors) {
//        str = @"户外跑步";
//    } else if (status == JWBleDeviceMotionEnum_OutdoorRiding) {
//        str = @"户外骑行";
//    } else if (status == JWBleDeviceMotionEnum_OutdoorWalking) {
//        str = @"户外健走";
//    } else if (status == JWBleDeviceMotionEnum_IndoorRunning) {
//        str = @"室内跑步";
//    } else if (status == JWBleDeviceMotionEnum_Hit) {
//        str = @"高强度间隙训练";
//    } else if (status == JWBleDeviceMotionEnum_Plank) {
//        str = @"平板支撑";
//    }
    return str;
}

+ (int)getZoneInt {
    NSTimeZone *zone = [NSTimeZone localTimeZone];
    NSString *zoneAbbreviation1 = [zone abbreviation];
    return [[zoneAbbreviation1 substringWithRange: NSMakeRange(3, 2)] intValue];
}

// 将JSON串转化为字典或者数组  数组转换字符串
+ (id)toArrayOrNSDictionary:(NSData *)jsonData {
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:NSJSONReadingMutableContainers
                                                      error:&error];
    
    if (jsonObject != nil && error == nil) {
        return jsonObject;
    }else{
        // 解析错误
        return nil;
    }
    
}

// 将字典或者数组转化为JSON串
+ (NSData *)toJSONData:(id)theData {
    if (theData) {
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData
                                                           options:NSJSONWritingPrettyPrinted
                                                             error:&error];
        
        if ([jsonData length] != 0 && error == nil){
            return jsonData;
        }else{
            return nil;
        }
    } else {
        return nil;
    }
}

+ (long long)dataToLong:(NSData *)data {
    long long datatemplength;

    [data getBytes:&datatemplength length:sizeof(datatemplength)];

    long long result = CFSwapInt64BigToHost(datatemplength);//大小端不一样，需要转化

    return result;
}


+ (NSData *)int2Data:(int)value {
    return [NSData dataWithBytes:&value length:1];
}


@end
