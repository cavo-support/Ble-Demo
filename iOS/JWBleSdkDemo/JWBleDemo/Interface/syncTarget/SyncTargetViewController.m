//
//  SyncTargetViewController.m
//  JWBleDemo
//
//  Created by bobobo on 2023/6/21.
//  Copyright © 2023 wosmart. All rights reserved.
//

#import "SyncTargetViewController.h"

@interface SyncTargetViewController ()

@end

@implementation SyncTargetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"SyncTarget", nil);
    
}

- (IBAction)clickSyncBtn:(id)sender {
    
    /**
     设置计步目标 Set pedometer goal
     
     @param step 步数 1000~65000  Number of steps 1000~65000
     @param callBack 回调 Callback
     */
    [JWBleAction jwSetStepTargetAction:10000 callBack:^(JWBleCommunicationStatus status) {
        
    }];
    
    /**
     设置卡路里目标 Set calorie goal
     
     @param calorie 单位千卡  Unit kcal 100~9999
     @param callBack 回调 Callback
     */
    [JWBleAction jwSetCalorieTargetAction:1000 callBack:^(JWBleCommunicationStatus status) {
        
    }];
    
    /**
     设置睡眠目标 Set sleep goals
     
     @param minute 分钟 90~900 Min 90~900
     @param callBack 回调 Callback
     */
    [JWBleAction jwSetSleepTargetAction:480 callBack:^(JWBleCommunicationStatus status) {
        
    }];
    
}

@end
