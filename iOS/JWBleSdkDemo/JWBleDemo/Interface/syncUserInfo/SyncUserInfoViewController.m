//
//  SyncUserInfoViewController.m
//  JWBleDemo
//
//  Created by bobobo on 2023/6/21.
//  Copyright © 2023 wosmart. All rights reserved.
//

#import "SyncUserInfoViewController.h"

@interface SyncUserInfoViewController ()

@end

@implementation SyncUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"同步个人信息", nil);
}

- (IBAction)clickSyncBtn:(id)sender {
    
    /**
     同步个人信息 Synchronize personal information
     
     @param age 年龄  0~127  Age 0~127
     @param isMan 是否是男的 Is it male
     @param height 身高cm 0.0~256 精确到0.5cm Height cm 0.0~256 accurate to 0.5cm
     @param weight 体重kg 0.0~512 精确到0.5kg Weight kg 0.0~512 accurate to 0.5kg
     @param callBack 回调 Callback
     */
    __weak __typeof(self)weakSelf = self;
    [JWBleAction jwSynchronizePersonalInformation:18 isMan:true height:175.5 weight:180 callBack:^(JWBleCommunicationStatus status) {
        [weakSelf.view makeToast:NSLocalizedString(@"sync success", nil)];
    }];
}


@end
