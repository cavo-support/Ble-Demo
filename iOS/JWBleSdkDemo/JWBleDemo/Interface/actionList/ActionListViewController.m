//
//  ActionListViewController.m
//  CoreBluetoothDemo
//
//  Created by Bo 黄 on 2019/2/15.
//  Copyright © 2019 Jone. All rights reserved.
//

#import "ActionListViewController.h"
#import "ActionListViewControllerTableViewCell.h"
#import "TimeActionViewController.h"
#import "ContinuousHRViewController.h"
#import "TurnWristViewController.h"
#import "SedentaryReminderViewController.h"
#import "TimeThemeViewController.h"
#import "LanguageViewController.h"
#import "NotDisturbViewController.h"
#import "NoticeViewController.h"
#import "AlarmClockViewController.h"
#import "TestHRViewController.h"
#import "TestHeadsetViewController.h"
#import "GetDeviceDataViewController.h"
#import "CheckFunctionViewController.h"
#import "TestTemperatureViewController.h"
#import "HiddenFunctionActionViewController.h"
#import "HRSwitchViewController.h"
#import "ContinuousBPViewController.h"
#import "CustomizeMainInterfaceViewController.h"
#import "UpdateInterfaceColorViewController.h"
#import "OtaActionViewController.h"
#import "ImageOtaViewController.h"
#import "CustomSetPluseViewController.h"

@interface ActionListViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource
>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSArray *functionArr;

@end

@implementation ActionListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"function list", nil);
    [self.view addSubview:self.tableView];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.functionArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ActionListViewControllerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActionListViewControllerTableViewCell"];
    cell.titleLB.text = NSLocalizedString(self.functionArr[indexPath.row], nil);
    return cell;
}

/**
 @param tableView tableView description
 @param indexPath indexPath description
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *actionStr = NSLocalizedString(self.functionArr[indexPath.row], nil);
    
    __weak __typeof(self)weakSelf = self;
    if ([actionStr isEqualToString:NSLocalizedString(@"Synchronize personal information", nil)]) {
        
        [self.view makeToast:NSLocalizedString(@"Setting Gender: Male, Age: 18, Height: 60.5cm, Weight: 75.5kg", nil)];
        
        [MBProgressHUD showHUDAddedTo:self.view animated:true];
        [JWBleAction jwSynchronizePersonalInformation:18 isMan:true height:60.5 weight:75.5 callBack:^(JWBleCommunicationStatus status) {
            [MBProgressHUD hideHUDForView:weakSelf.view animated:true];
            [weakSelf.view makeToast:[JWBleDemoHelp communication2Str:status]];
        }];
        
    } else if ([actionStr isEqualToString:NSLocalizedString(@"Set step goal", nil)]) {
        
        [self.view makeToast:NSLocalizedString(@"Setting goals: 1000 steps", nil)];
        
        [MBProgressHUD showHUDAddedTo:self.view animated:true];
        [JWBleAction jwSetStepTargetAction:10000 callBack:^(JWBleCommunicationStatus status) {
            [MBProgressHUD hideHUDForView:weakSelf.view animated:true];
            [weakSelf.view makeToast:[JWBleDemoHelp communication2Str:status]];
        }];
        
    } else if ([actionStr isEqualToString:NSLocalizedString(@"Set sleep goals", nil)]) {
        
        [self.view makeToast:NSLocalizedString(@"Setting goal: 6 hours", nil)];
        
        [MBProgressHUD showHUDAddedTo:self.view animated:true];
        [JWBleAction jwSetSleepTargetAction:6*60 callBack:^(JWBleCommunicationStatus status) {
            [MBProgressHUD hideHUDForView:weakSelf.view animated:true];
            [weakSelf.view makeToast:[JWBleDemoHelp communication2Str:status]];
        }];
        
    } else if ([actionStr isEqualToString:NSLocalizedString(@"Find bracelet", nil)]) {
        [JWBleAction jwFindDeviceWithCallBack:^(JWBleCommunicationStatus status) {
            [weakSelf.view makeToast:[JWBleDemoHelp communication2Str:status]];
        }];
    } else if ([actionStr isEqualToString:NSLocalizedString(@"Open the remote camera", nil)]) {
        [MBProgressHUD showHUDAddedTo:self.view animated:true];
        
        [JWBleAction jwRemotePhotography:true callBack:^(JWBleCommunicationStatus status) {
            [MBProgressHUD hideHUDForView:weakSelf.view animated:true];
        }];
        
        [self.view makeToast:NSLocalizedString(@"If shaking the bracelet has no effect, do some other operations first", nil)];

        JWBleManager.remotePhotographyCallBack = ^(JWBleRemotePhotographyStatus remotePhotographyStatus) {
            if (remotePhotographyStatus == JWBleRemotePhotographyStatus_TakePhoto) {
                [weakSelf.view makeToast:NSLocalizedString(@"Photo callback", nil)];
            }
        };
    } else if ([actionStr isEqualToString:NSLocalizedString(@"Turn off the remote camera", nil)]) {
        [MBProgressHUD showHUDAddedTo:self.view animated:true];
        [JWBleAction jwRemotePhotography:false callBack:^(JWBleCommunicationStatus status) {
            [MBProgressHUD hideHUDForView:weakSelf.view animated:true];
            [weakSelf.view makeToast:[JWBleDemoHelp communication2Str:status]];
        }];
    } else if ([actionStr isEqualToString:NSLocalizedString(@"Continuous heart rate monitoring", nil)]) {
        [self.navigationController pushViewController:[ContinuousHRViewController new] animated:true];
    } else if ([actionStr isEqualToString:NSLocalizedString(@"Turn the wrist bright screen-bright screen duration", nil)]) {
        [self.navigationController pushViewController:[TurnWristViewController new] animated:true];
    } else if ([actionStr isEqualToString:NSLocalizedString(@"Sedentary reminder", nil)]) {
        [self.navigationController pushViewController:[SedentaryReminderViewController new] animated:true];
    } else if ([actionStr isEqualToString:NSLocalizedString(@"Hour System-Metric and Imperial", nil)]) {
        [self.navigationController pushViewController:[TimeThemeViewController new] animated:true];
    } else if ([actionStr isEqualToString:NSLocalizedString(@"Language", nil)]) {
        [self.navigationController pushViewController:[LanguageViewController new] animated:true];
    } else if ([actionStr isEqualToString:NSLocalizedString(@"Do not disturb mode", nil)]) {
        [self.navigationController pushViewController:[NotDisturbViewController new] animated:true];
    } else if ([actionStr isEqualToString:NSLocalizedString(@"notification", nil)]) {
        [self.navigationController pushViewController:[NoticeViewController new] animated:true];
    } else if ([actionStr isEqualToString:NSLocalizedString(@"Alarm setting", nil)]) {
        [self.navigationController pushViewController:[AlarmClockViewController new] animated:true];
    } else if ([actionStr isEqualToString:NSLocalizedString(@"Test heart rate", nil)]) {
        [self.navigationController pushViewController:[TestHRViewController new] animated:true];
    } else if ([actionStr isEqualToString:NSLocalizedString(@"Test blood pressure", nil)]) {
        TestHRViewController *vc = [TestHRViewController new];
        vc.testBP = true;
        [self.navigationController pushViewController:vc animated:true];
    } else if ([actionStr isEqualToString:NSLocalizedString(@"Test headphones", nil)]) {
        [self.navigationController pushViewController:[TestHeadsetViewController new] animated:true];
    } else if ([actionStr isEqualToString:NSLocalizedString(@"Get bracelet data", nil)]) {
        [self.navigationController pushViewController:[GetDeviceDataViewController new] animated:true];
    } else if ([actionStr isEqualToString:NSLocalizedString(@"Check if there is a function", nil)]) {
        [self.navigationController pushViewController:[CheckFunctionViewController new] animated:true];
    } else if ([actionStr isEqualToString:NSLocalizedString(@"Temperature correlation", nil)]) {
        [self.navigationController pushViewController:[TestTemperatureViewController new] animated:true];
    } else if ([actionStr isEqualToString:NSLocalizedString(@"Bracelet function display and hide", nil)]) {
        [self.navigationController pushViewController:[HiddenFunctionActionViewController new] animated:true];
    } else if ([actionStr isEqualToString:NSLocalizedString(@"Heart rate switch", nil)]) {
        [self.navigationController pushViewController:[HRSwitchViewController new] animated:true];
    } else if ([actionStr isEqualToString:NSLocalizedString(@"Continuous blood pressure", nil)]) {
        [self.navigationController pushViewController:[ContinuousBPViewController new] animated:true];
    } else if ([actionStr isEqualToString:NSLocalizedString(@"Customize the main interface", nil)]) {
        [self.navigationController pushViewController:[CustomizeMainInterfaceViewController new] animated:true];
    } else if ([actionStr isEqualToString:NSLocalizedString(@"Update Interface Color", nil)]) {
        [self.navigationController pushViewController:[UpdateInterfaceColorViewController new] animated:true];
    } else if ([actionStr isEqualToString:NSLocalizedString(@"OTA", nil)]) {
        [self.navigationController pushViewController:[OtaActionViewController new] animated:true];
    } else if ([actionStr isEqualToString:NSLocalizedString(@"Image OTA", nil)]) {
        [self.navigationController pushViewController:[ImageOtaViewController new] animated:true];
    } else if ([actionStr isEqualToString:NSLocalizedString(@"Custom Set Pulse/SleepAid", nil)]) {
        [self.navigationController pushViewController:[CustomSetPluseViewController new] animated:true];
    }
}

#pragma mark - getter
- (NSArray *)functionArr {
    if (!_functionArr) {
        _functionArr = @[
                    @"Customize the main interface",
                    @"Alarm setting",
                    @"Synchronize personal information",
                    @"Test headphones",
                    @"Set step goal",
                    @"Set sleep goals",
                    @"Find bracelet",
                    @"Open the remote camera",
                    @"Turn off the remote camera",
                    @"Continuous heart rate monitoring",
                    @"Turn the wrist bright screen-bright screen duration",
                    @"Sedentary reminder",
                    @"Hour System-Metric and Imperial",
                    @"Language",
                    @"Do not disturb mode",
                    @"notification",
                    @"Test heart rate",
                    @"Test blood pressure",
                    @"Temperature correlation",
                    @"Check if there is a function",
                    @"Bracelet function display and hide",
                    @"Heart rate switch",
                    @"Temperature correlation",
                    @"Continuous blood pressure",
                    @"Get bracelet data",
                    @"Update Interface Color",
                    @"OTA",
                    @"Image OTA",
                    @"Custom Set Pulse/SleepAid"
                 ];
    }
    return _functionArr;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        [_tableView registerNib:[UINib nibWithNibName:@"ActionListViewControllerTableViewCell" bundle:nil] forCellReuseIdentifier:@"ActionListViewControllerTableViewCell"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 50;
    }
    return _tableView;
}

@end
