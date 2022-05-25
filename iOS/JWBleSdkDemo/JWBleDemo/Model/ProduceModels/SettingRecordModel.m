//
//  SettingRecordModel.m
//  JWBleDemo
//
//  Created by Bo 黄 on 2019/9/24.
//  Copyright © 2019 wosmart. All rights reserved.
//

#import "SettingRecordModel.h"

@implementation SettingRecordModel

+ (SettingRecordModel *)findByDeviceNum:(int)deviceNum {
    NSString *sql = [NSString stringWithFormat:@" WHERE %@ = '%d' ",@"deviceNum",deviceNum];
    NSArray *arr = [SettingRecordModel findByCriteria:sql];
    if (arr.count > 0) {
        return arr.firstObject;
    } else {
        SettingRecordModel *model = [SettingRecordModel new];
        model.deviceNum = deviceNum;
        return model;
    }
}

+ (SettingRecordModel *)findByCurConnectionModel {
   return [SettingRecordModel findByDeviceNum:JWBleManager.connectionModel.deviceNumber];
}

@end
