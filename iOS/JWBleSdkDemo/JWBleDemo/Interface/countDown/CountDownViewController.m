//
//  CountDownViewController.m
//  JWBleDemo
//
//  Created by bobobo on 2023/6/21.
//  Copyright © 2023 wosmart. All rights reserved.
//

#import "CountDownViewController.h"

@interface CountDownViewController ()

@property (weak, nonatomic) IBOutlet UILabel *statusLB;

@end

@implementation CountDownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"CountDown";
    
    [self clickGetStatus:nil];
}

- (IBAction)clickGetStatus:(id)sender {
    
    JWBleHideFunctionStatesEnum functionStatesEnum = [JWBleAction jwCheckHideFunctionStates:JWBleFunctionEnum_Countdown];
    if (functionStatesEnum == JWBleHideFunctionStatesEnum_NotSupport) {
        [self.view makeToast:@"device no function"];
        return;
    }
    
    __weak __typeof(self)weakSelf = self;
    [JWBleAction jwCountDownAction:true model:nil callBack:^(JWBleCommunicationStatus status, JWCountDownModel *countDownModel) {
        if (status == JWBleCommunicationStatus_Success) {
            if (countDownModel.optionEnum == JWCountDownOptionEnum_Start) {
                weakSelf.statusLB.text = [NSString stringWithFormat:@"status: Counting down second:%d",countDownModel.seconds];
            } else if (countDownModel.optionEnum == JWCountDownOptionEnum_Setting) {
                
            }
        }
    }];
   
}

- (IBAction)clickSetBtn:(id)sender {
    
    JWBleHideFunctionStatesEnum functionStatesEnum = [JWBleAction jwCheckHideFunctionStates:JWBleFunctionEnum_Countdown];
    if (functionStatesEnum == JWBleHideFunctionStatesEnum_NotSupport) {
        [self.view makeToast:@"device no function"];
        return;
    }
    
    __weak __typeof(self)weakSelf = self;
    
    JWCountDownModel *model = [JWCountDownModel new];
    model.optionEnum = JWCountDownOptionEnum_Setting;
    model.open = true;
    model.seconds = 30;
    [JWBleAction jwCountDownAction:false model:model callBack:^(JWBleCommunicationStatus status, JWCountDownModel *countDownModel) {
        
    }];
}

- (IBAction)clickStartBtn:(id)sender {
    
    JWBleHideFunctionStatesEnum functionStatesEnum = [JWBleAction jwCheckHideFunctionStates:JWBleFunctionEnum_Countdown];
    if (functionStatesEnum == JWBleHideFunctionStatesEnum_NotSupport) {
        [self.view makeToast:@"device no function"];
        return;
    }
    
    __weak __typeof(self)weakSelf = self;
    
    JWCountDownModel *model = [JWCountDownModel new];
    model.optionEnum = JWCountDownOptionEnum_Start;
    model.open = true;// must true
    model.seconds = 30;
    [JWBleAction jwCountDownAction:false model:model callBack:^(JWBleCommunicationStatus status, JWCountDownModel *countDownModel) {
        
    }];
}

@end
