//
//  JWBleMyMainInterfaceAction.h
//  JWBle
//
//  Created by bobobo on 2024/5/21.
//  Copyright © 2024 wosmart. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^JWBleMyMainInterfaceActionCallBack)(NSData *data);

@interface JWBleMyMainInterfaceAction : NSObject

+ (JWBleMyMainInterfaceAction *)shareInstance;

/**
 获取设备自定义表盘配置
 */
- (void)getDeviceInterfaceConf;

- (void)testSendData:(NSData *)data;
- (void)testSendImageData:(NSData *)data;

- (void)deviceRespnseData:(NSData *)data;

@property(nonatomic, copy) JWBleMyMainInterfaceActionCallBack callBack;

@end
