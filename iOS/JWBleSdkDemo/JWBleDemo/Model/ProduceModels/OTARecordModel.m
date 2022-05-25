//
//  OTARecordModel.m
//  JWBleDemo
//
//  Created by huang bo on 2020/3/17.
//  Copyright © 2020 wosmart. All rights reserved.
//

#import "OTARecordModel.h"

@implementation OTARecordModel

+ (OTARecordModel *)getByDeviceNumber:(NSInteger)deviceNumbe {
    NSString *sql = [NSString stringWithFormat:@" WHERE %@ = %ld ",@"deviceNumber",deviceNumbe];
    NSArray *resultArr = [OTARecordModel findByCriteria:sql];
    if (resultArr.count > 0) {
        return resultArr.firstObject;
    }
    return nil;
}

@end
