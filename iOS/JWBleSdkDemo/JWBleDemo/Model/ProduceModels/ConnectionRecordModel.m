//
//  ConnectionRecordModel.m
//  JWBleDemo
//
//  Created by Bo 黄 on 2020/5/6.
//  Copyright © 2020 wosmart. All rights reserved.
//

#import "ConnectionRecordModel.h"

@implementation ConnectionRecordModel

+ (NSArray *)selectByNameAndNumber:(NSString *)name number:(NSInteger)number {
    if (!name || [name isEmpty]) {
        return [ConnectionRecordModel findAll];
    } else if (number == 0) {
        NSString *sql = [NSString stringWithFormat:@"WHERE %@ = '%@'",@"deviceName",name];
        return [ConnectionRecordModel findByCriteria:sql];
    } else {
        NSString *sql = [NSString stringWithFormat:@"WHERE %@ = '%@' and deviceNumber = '%ld'",@"deviceName",name,(long)number];
        return [ConnectionRecordModel findByCriteria:sql];
    }
}

+ (void)deleteMac:(JWBleDeviceModel *)connectionModel {
    NSString *sql = [NSString stringWithFormat:@" WHERE %@ = '%@'",@"mac",connectionModel.macAddress];
    NSArray *resultArr = [ConnectionRecordModel findByCriteria:sql];
    [ConnectionRecordModel deleteObjects:resultArr];  
}

+ (ConnectionRecordModel *)findByMac:(NSString *)mac {
    NSString *sql = [NSString stringWithFormat:@" WHERE %@ = '%@'",@"mac",mac];
    NSArray *resultArr = [ConnectionRecordModel findByCriteria:sql];
    if (resultArr.count > 0) {
        return resultArr.firstObject;
    }
    return nil;
}

@end
