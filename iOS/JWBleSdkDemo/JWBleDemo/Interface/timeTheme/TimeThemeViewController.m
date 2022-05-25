//
//  TimeThemeViewController.m
//  JWBleDemo
//
//  Created by Bo 黄 on 2019/8/7.
//  Copyright © 2019 wosmart. All rights reserved.
//

#import "TimeThemeViewController.h"

@interface TimeThemeViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *switchView;
@property (weak, nonatomic) IBOutlet UISwitch *unitSwitchView;

@end

@implementation TimeThemeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Hour System-Metric and Imperial", nil);
    
    __weak __typeof(self)weakSelf = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:true];
    [JWBleAction jwCommonFunction:JWBleFunctionEnum_TimeSystem functionsState:JWBleCommonFunctionsStatus_Read callBack:^(JWBleCommunicationStatus communicationStatus, JWBleCommonFunctionsStatus functionStatus) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:true];
        [weakSelf.view makeToast:[JWBleDemoHelp communication2Str:communicationStatus]];
        if (communicationStatus == JWBleCommunicationStatus_Success) {
            weakSelf.switchView.on = functionStatus == JWBleCommonFunctionsStatus_Open;
        }
    }];
    
    [JWBleAction jwCommonFunction:JWBleFunctionEnum_Unit functionsState:JWBleCommonFunctionsStatus_Read callBack:^(JWBleCommunicationStatus communicationStatus, JWBleCommonFunctionsStatus functionStatus) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:true];
        [weakSelf.view makeToast:[JWBleDemoHelp communication2Str:communicationStatus]];
        if (communicationStatus == JWBleCommunicationStatus_Success) {
            weakSelf.unitSwitchView.on = functionStatus == JWBleCommonFunctionsStatus_Open;
        }
    }];
}

- (IBAction)clickSetBtn:(id)sender {
    [MBProgressHUD showHUDAddedTo:self.view animated:true];
    __weak __typeof(self)weakSelf = self;
    [JWBleAction jwCommonFunction:JWBleFunctionEnum_TimeSystem
                   functionsState:self.switchView.on?JWBleCommonFunctionsStatus_Open:JWBleCommonFunctionsStatus_Close
                         callBack:^(JWBleCommunicationStatus communicationStatus, JWBleCommonFunctionsStatus functionStatus) {
                             [MBProgressHUD hideHUDForView:weakSelf.view animated:true];
                             [weakSelf.view makeToast:[JWBleDemoHelp communication2Str:communicationStatus]];
    }];
}

- (IBAction)clickUnitSetBtn:(id)sender {
    [MBProgressHUD showHUDAddedTo:self.view animated:true];
    __weak __typeof(self)weakSelf = self;
    [JWBleAction jwCommonFunction:JWBleFunctionEnum_Unit
                   functionsState:self.unitSwitchView.on?JWBleCommonFunctionsStatus_Open:JWBleCommonFunctionsStatus_Close
                         callBack:^(JWBleCommunicationStatus communicationStatus, JWBleCommonFunctionsStatus functionStatus) {
                             [MBProgressHUD hideHUDForView:weakSelf.view animated:true];
                             [weakSelf.view makeToast:[JWBleDemoHelp communication2Str:communicationStatus]];
                         }];
}


@end
