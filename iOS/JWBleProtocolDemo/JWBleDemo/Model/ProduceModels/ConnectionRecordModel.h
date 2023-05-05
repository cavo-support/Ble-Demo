//
//  ConnectionRecordModel.h
//  JWBleDemo
//
//  Created by Bo 黄 on 2020/5/6.
//  Copyright © 2020 wosmart. All rights reserved.
//

#import "JKDBModel.h"
    
@interface ConnectionRecordModel : JKDBModel

@property(nonatomic, strong) NSString *deviceName;
@property(nonatomic, assign) NSInteger deviceNumber;
@property(nonatomic, strong) NSString *version;
@property(nonatomic, strong) NSString *patchVersion;
@property(nonatomic, strong) NSString *mac;
@property(nonatomic, assign) NSInteger battery;
@property(nonatomic, strong) NSString *snid;
@property(nonatomic, strong) NSString *barCode;
@property(nonatomic, assign) BOOL temperatureAlready;//温度是否已经标定过
@property(nonatomic, assign) NSInteger temperatureFrequency;//温度频率
@property(nonatomic, strong) NSString *temperatureTemperatureInital;//温度标定值
@property(nonatomic, assign) NSTimeInterval t;

+ (NSArray *)selectByNameAndNumber:(NSString *)name number:(NSInteger)number;
+ (void)deleteMac:(JWBleDeviceModel *)connectionModel;
+ (ConnectionRecordModel *)findByMac:(NSString *)mac;

@end

