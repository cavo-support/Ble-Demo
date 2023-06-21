//
//  FindPhoneViewController.m
//  JWBleDemo
//
//  Created by bobobo on 2023/6/21.
//  Copyright © 2023 wosmart. All rights reserved.
//

#import "FindPhoneViewController.h"

@interface FindPhoneViewController ()

@end

@implementation FindPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"FindPhone";
    self.view.backgroundColor = [UIColor whiteColor];
    
    JWBleManager.findPhoneV2CallBack = ^(BOOL start) {
        if (start) {
            NSLog(@"device find phone : start");
        } else {
            NSLog(@"device find phone : end");
        }
    };
}


@end
