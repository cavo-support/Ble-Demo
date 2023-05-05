//
//  JWBleProtocolModel.h
//  JWBleDemo
//
//  Created by bobobo on 2023/5/5.
//  Copyright © 2023 wosmart. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JWBleProtocolModel : NSObject

@property (nonatomic, strong) CBPeripheral *per;
@property (nonatomic, strong) NSDictionary<NSString *, id> *advertisementData;
@property (nonatomic, strong) NSNumber *RSSI;

@end
