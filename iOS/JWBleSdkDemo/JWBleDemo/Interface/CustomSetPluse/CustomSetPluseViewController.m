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
    
    //1：check function support
    JWBleFunctionStatesEnum functionStatesEnum = [JWBleAction jwCheckCustomFunctionStates:JWBleCustomFunctionEnum_SetPulse];
    if (functionStatesEnum == JWBleFunctionStateEnum_Open) {
        
        //2: set
        bool open = true;
        int minute = 6;
        int level = 6;
        
        [JWBleAction jwCustomSetPulseAction:open minute:minute level:level callBack:^(JWBleCommunicationStatus status) {
            
        }];
        
    }
}

@end
