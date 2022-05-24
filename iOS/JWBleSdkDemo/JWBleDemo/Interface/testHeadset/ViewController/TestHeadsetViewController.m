//
//  TestHeadsetViewController.m
//  JWBleDemo
//
//  Created by Bo 黄 on 2019/9/9.
//  Copyright © 2019 wosmart. All rights reserved.
//

#import "TestHeadsetViewController.h"

@interface TestHeadsetViewController ()
@property (weak, nonatomic) IBOutlet UILabel *mac;
@property (weak, nonatomic) IBOutlet UILabel *status;

@end

@implementation TestHeadsetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)clickMacBtn:(id)sender {
    __weak __typeof(self)weakSelf = self;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:true];
    [JWBleAction jwGetMacAddressWithBlock:^(NSString *macAddr) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:true];
        weakSelf.mac.text = [NSString stringWithFormat:@"mac: %@",macAddr];
    }];
}

- (IBAction)clickStatusBtn:(id)sender {
    
    __weak __typeof(self)weakSelf = self;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:true];
    [JWBleAction jwGetDeviceStatusWithBlock:^(int status) {
        
        [MBProgressHUD hideHUDForView:weakSelf.view animated:true];
        NSString *statusStr = @"关闭";
        if (status == 1) {
            statusStr = @"匹配中";
        } else if (status == 2) {
            statusStr = @"准备就绪";
        } else if (status == 3) {
            statusStr = @"已连接";
        }
        
        weakSelf.status.text = [NSString stringWithFormat:@"status: %@",statusStr];
    }];
    
    
}


@end
