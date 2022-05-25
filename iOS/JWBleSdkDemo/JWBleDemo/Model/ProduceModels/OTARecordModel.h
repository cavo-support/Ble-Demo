//
//  OTARecordModel.h
//  JWBleDemo
//
//  Created by huang bo on 2020/3/17.
//  Copyright © 2020 wosmart. All rights reserved.
//

#import "JKDBModel.h"

@interface OTARecordModel : JKDBModel

@property(nonatomic, assign) NSInteger deviceNumber;
@property(nonatomic, strong) NSString *fileName;

+ (OTARecordModel *)getByDeviceNumber:(NSInteger)deviceNumber;

@end

