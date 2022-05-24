//
//  CheckFunctionViewController.m
//  JWBleDemo
//
//  Created by Bo 黄 on 2020/7/10.
//  Copyright © 2020 wosmart. All rights reserved.
//

#import "CheckFunctionViewController.h"

@interface CheckFunctionViewController ()

@end

@implementation CheckFunctionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Check if there is a function", nil);
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)checkFunction:(JWBleFunctionEnum)functionEnum {
    JWBleFunctionStatesEnum statesEnum = [JWBleAction jwCheckFunctionStates:JWBleFunctionEnum_TwoButtonSliding];
}

@end
