//
//  JWBleProtocolMethod.h
//  JWBleDemo
//
//  Created by bobobo on 2023/5/5.
//  Copyright © 2023 wosmart. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JWBleProtocolMethod : NSObject

@property (nonatomic, strong) CBCentralManager *centralManager;
@property (nonatomic, strong) CBPeripheral *peripheral;
@property (nonatomic, strong) CBCharacteristic *writeCharacteristic, *notifyCharacteristic;

- (void)wBLoginWithID:(UInt8 *)loginID isBond:(BOOL)bBond;
- (void)analysisNotifyData:(NSData *)data;

@end
