//
//  JWBleProtocol.h
//  JWBleDemo
//
//  Created by bobobo on 2023/5/5.
//  Copyright © 2023 wosmart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JWBleProtocolDefine.h"
#import "JWBleProtocolConnectModel.h"

@interface JWBleProtocol : NSObject

+ (JWBleProtocol *)shareInstance;

@property (nonatomic, strong) ConnectStatusChangeCallBack connectStatusChangeCallBack;
@property (nonatomic, strong) JWBleProtocolConnectModel *connectionModel;

- (void)scanDeviceWithCallBack:(ScanningDeviceCallBack)callBack;

- (void)connectDevice:(JWBleProtocolModel *)model;

@end
