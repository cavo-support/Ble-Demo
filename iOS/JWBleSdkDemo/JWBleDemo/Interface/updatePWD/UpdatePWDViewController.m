//
//  UpdatePWDViewController.m
//  CoreBluetoothDemo
//
//  Created by Bo 黄 on 2019/3/8.
//  Copyright © 2019 Jone. All rights reserved.
//

#import "UpdatePWDViewController.h"

@interface UpdatePWDViewController ()

@property (weak, nonatomic) IBOutlet UITextField *oldField;
@property (weak, nonatomic) IBOutlet UITextField *willSetField;

@end

@implementation UpdatePWDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"修改密码";
}

- (IBAction)clickChangeBtn:(id)sender {
    if (self.oldField.text.length != 4 || self.willSetField.text.length != 4) {
        [self.view makeToast:@"密码为4为纯数字"];
        return;
    }
    
//    [self.view makeToastActivity:self];
//    __weak __typeof(self)weakSelf = self;
//    [JWBleAction updatePassword:[self.oldField.text intValue]
//                             newPwd:[self.willSetField.text intValue]
//                           callBack:^(JWBleUpdatePWDStatus status) {
//                               [weakSelf.view hideToastActivity];
//                               if (status == JWBleUpdatePWDStatus_OldPwdError) {
//                                   [weakSelf.view makeToast:@"原密码错误"];
//                               } else if (status == JWBleUpdatePWDStatus_DeviceBusy) {
//                                   [weakSelf.view makeToast:@"蓝牙正在通信中，请稍后"];
//                               } else if (status == JWBleUpdatePWDStatus_Faild) {
//                                   [weakSelf.view makeToast:@"设置失败"];
//                               } else if (status == JWBleUpdatePWDStatus_Success) {
//                                   [weakSelf.view makeToast:@"设置成功"];
//                               }
//    }];
}

@end
