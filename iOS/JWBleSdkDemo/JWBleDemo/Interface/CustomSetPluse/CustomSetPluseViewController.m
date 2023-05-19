//
//  CustomSetPluseViewController.m
//  JWBleDemo
//
//  Created by bobobo on 2023/5/11.
//  Copyright © 2023 wosmart. All rights reserved.
//

#import "CustomSetPluseViewController.h"

@interface CustomSetPluseViewController ()

@end

@implementation CustomSetPluseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self pulseAction];
    [self sleepAidAction];
}

- (void)pulseAction {
    
    JWBleManager.showLog = false;
    
    //1：check function support
    JWBleFunctionStatesEnum functionStatesEnum = [JWBleAction jwCheckCustomFunctionStates:JWBleCustomFunctionEnum_SetPulse];
    if (functionStatesEnum == JWBleFunctionStateEnum_Open) {
        
        //2: listen callback
        JWBleManager.endOfPulseCallBack = ^(int value) {
            NSLog(@"device pulseAction end \t value:%d",value);
        };
        
        JWBleManager.pulseDataCallBack = ^(int status, int length, int timestamp, int value) {
            if (status == 0) {
                NSLog(@"pull data end");
            } else if (status == 1) {
                NSLog(@"pull data start \t length: %d",length);
            } else if (status == 2) {
                NSLog(@"pull data receiving \t timestamp:%d \t value:%d",timestamp,value);
            }
        };
        
        //3: set
        bool open = true;
        int minute = 6;
        int level = 6;
        
        [JWBleAction jwCustomSetPulseAction:open minute:minute level:level callBack:^(JWBleCommunicationStatus status) {
            
        }];
        
        //4: get data
        [JWBleDataAction jwGetPulseDataByYYYYDDStr:@"20230519" callBack:^(NSArray *dataArr) {
            NSLog(@"db data length : %ld", dataArr.count);
        }];
                              //2023-05-19 17:51:00  2024-05-19 17:52:51
        [JWBleDataAction jwGetPulseDataByStartT:1684489860 endT:1716112371 callBack:^(NSArray *dataArr) {
            NSLog(@"db data length : %ld", dataArr.count);
        }];
    }
    
}

- (void)sleepAidAction {
    
    //1：check function support
    JWBleFunctionStatesEnum functionStatesEnum = [JWBleAction jwCheckCustomFunctionStates:JWBleCustomFunctionEnum_SleepAid];
    if (functionStatesEnum == JWBleFunctionStateEnum_Open) {
        
        //2: set
        bool open = true;
        int time = 15;
        int effectTime = 10;
        int level = 6;
        
        [JWBleAction jwCustomSleepAidAction:open time:time effectTime:effectTime level:level callBack:^(JWBleCommunicationStatus status) {
            
        }];
        
    }
}

@end
