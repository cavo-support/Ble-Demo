//
//  ScanFilterRecordModel.h
//  JWBleDemo
//
//  Created by Bo 黄 on 2019/9/21.
//  Copyright © 2019 wosmart. All rights reserved.
//

#import "JKDBModel.h"

@interface ScanFilterRecordModel : JKDBModel

@property(nonatomic, assign) int rssi;
@property(nonatomic, strong) NSString *name;

@end
