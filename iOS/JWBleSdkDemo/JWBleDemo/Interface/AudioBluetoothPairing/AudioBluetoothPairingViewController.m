//
//  AudioBluetoothPairingViewController.m
//  JWBleDemo
//
//  Created by bobobo on 2023/6/21.
//  Copyright © 2023 wosmart. All rights reserved.
//

#import "AudioBluetoothPairingViewController.h"

@interface AudioBluetoothPairingViewController ()

@end

@implementation AudioBluetoothPairingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"AudioBluetoothPairing";
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 1: 音频蓝牙状态监听
    JWBleManager.connectStateChangeCallBack = ^(JWBleDeviceConnectStatus deviceConnectStatus) {
        if (deviceConnectStatus == JWBleDeviceConnectStatus_HeadphoneDeviceStatusChanged) {
            //耳机状态
            int headphoneDeviceStatus = JWBleManager.connectionModel.headphoneDeviceStatus;
            //配对状态
            int headsetPaired = JWBleManager.connectionModel.headsetPaired;
        }
    };
    
    // 2: 弹出 仿苹果弹窗，30秒可认为超时
    [JWBleAction jwHeadphonePairing];
    
    // 3: 取消 仿苹果弹窗
//    [JWBleAction jwCancelHeadphonePairing];
}

@end
