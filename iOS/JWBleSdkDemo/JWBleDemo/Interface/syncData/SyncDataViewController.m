//
//  SyncDataViewController.m
//  JWBleDemo
//
//  Created by bobobo on 2023/6/21.
//  Copyright © 2023 wosmart. All rights reserved.
//

#import "SyncDataViewController.h"

@interface SyncDataViewController ()

@end

@implementation SyncDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"SyncData", nil);
    
//    // 1： 先将设备的数据，同步至sdk中
//    [JWBleDataAction jwSyncDataWithCallBack:^(JWBleCommunicationStatus status, JWBleSyncStateEnum syncStateEnum) {
//        //监听 JWBleSyncEnum_Complete 状态为成功后 进行 第二步
//    }];
//
//    // 2: 从sdk db 中获取数据
//
//    // 2.1: 抽象来说，所有数据类型，都提供了，根据天获取数据，如步数
//    // 2.2: 其它的数据会在下列方法中详细补充
//    [JWBleDataAction jwGetStepDataByYYYYMMDDStr:@"20180911" callBack:^(NSArray *dataArr) {
//
//    }];
}




@end
