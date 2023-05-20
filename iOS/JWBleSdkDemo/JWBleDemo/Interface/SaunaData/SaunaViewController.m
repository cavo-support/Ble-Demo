//
//  SaunaViewController.m
//  JWBleDemo
//
//  Created by bobobo on 2023/5/20.
//  Copyright © 2023 wosmart. All rights reserved.
//

#import "SaunaViewController.h"

@interface SaunaViewController ()

@end

@implementation SaunaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self saunaAction];
}

- (void)saunaAction {
    
    JWBleManager.showLog = false;
    
    //1：check function support
    JWBleFunctionStatesEnum functionStatesEnum = [JWBleAction jwCheckCustomFunctionStates:JWBleCustomFunctionEnum_Sauna];
    if (functionStatesEnum == JWBleFunctionStateEnum_Open) {
        
        [JWBleDataAction jwSyncDataWithCallBack:^(JWBleCommunicationStatus status, JWBleSyncStateEnum syncStateEnum) {
            
        }];
        
        //2: listen callback
        __block int receiveCount = 0;
        JWBleManager.saunaDataCallBack = ^(int status, int length, int time, int hr, int tem, int label, int move) {
            if (status == 0) {
                NSLog(@"pull data end");
            } else if (status == 1) {
                NSLog(@"pull data start \t length: %d",length);
            } else if (status == 2) {
                receiveCount ++;
                NSLog(@"pull data receiving \t time:%d \t hr:%d \t tem:%d \t label:%d \t move:%d \t receiveCount:%d",time,hr,tem,label,move,receiveCount);
            }
        };
        
        //3: get data
        [JWBleDataAction jwGetSaunaDataByYYYYDDStr:@"20230520" callBack:^(NSArray *dataArr) {
            NSLog(@"db data length : %ld", dataArr.count);
        }];
                              //2023-05-19 17:51:00  2023-05-21 16:17:53
        [JWBleDataAction jwGetSaunaDataByStartT:1684489860 endT:1716112371 callBack:^(NSArray *dataArr) {
            NSLog(@"db data length : %ld", dataArr.count);
        }];
        
    }
    
}

@end
