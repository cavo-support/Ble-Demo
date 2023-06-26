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
#import "SaunaViewController.h"
#import "V7_GT7D_ActionListViewController.h"

#import "ScanViewController.h"
#import "SyncTimeViewController.h"
#import "SyncUserInfoViewController.h"
#import "SyncUnitViewController.h"
#import "SyncTargetViewController.h"
#import "SyncDataViewController.h"
#import "SyncAutomaticMonitoringViewController.h"
#import "CountDownViewController.h"
#import "FindPhoneViewController.h"
#import "WeatherViewController.h"
#import "RemotePhotographyViewController.h"
#import "AddressBookViewController.h"
#import "AudioBluetoothPairingViewController.h"

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
   NSString *actionStr = NSLocalizedString(self.functionArr[indexPath.row], nil);
   
   if ([actionStr isEqualToString:NSLocalizedString(@"蓝牙搜索", nil)]) {
       [self.navigationController pushViewController:[ScanViewController new] animated:true];
   } else if ([actionStr isEqualToString:@"设备连接"]) {
       [self.navigationController pushViewController:[ScanViewController new] animated:true];
   } else if ([actionStr isEqualToString:@"断开连接"]) {
       //解绑、会清除设备数据
       [JWBleAction jwDisConnect];
       
       //断开链接，不会清除设备数据
       [JWBleAction jwDisConnectNotUnBond];
   } else if ([actionStr isEqualToString:@"同步时间"]) {
       [self.navigationController pushViewController:[SyncTimeViewController new] animated:true];
   } else if ([actionStr isEqualToString:@"用户信息"]) {
       [self.navigationController pushViewController:[SyncUserInfoViewController new] animated:true];
   } else if ([actionStr isEqualToString:@"语言"]) {
       [self.navigationController pushViewController:[LanguageViewController new] animated:true];
   } else if ([actionStr isEqualToString:@"单位设置"]) {
       [self.navigationController pushViewController:[SyncUnitViewController new] animated:true];
   } else if ([actionStr isEqualToString:@"目标设定"]) {
       [self.navigationController pushViewController:[SyncTargetViewController new] animated:true];
   } else if ([actionStr isEqualToString:@"同步数据"]) {
       [self.navigationController pushViewController:[SyncDataViewController new] animated:true];
   } else if ([actionStr isEqualToString:@"查询电量"]) {
       //1: 设备当前电量
       int power = JWBleManager.connectionModel.power;
       
       [self.view makeToast:[NSString stringWithFormat:@"power:%d",power]];
       
       //2: 监听电量改变
       //JWBleManager.connectStateChangeCallBack 回调中，监听 JWBleDeviceConnectStatus_BatteryUpdate，然后再以第一步方式获取
   } else if ([actionStr isEqualToString:@"通知开关"]) {
       [self.navigationController pushViewController:[NoticeViewController new] animated:true];
   } else if ([actionStr isEqualToString:@"闹钟"]) {
       [self.navigationController pushViewController:[AlarmClockViewController new] animated:true];
   } else if ([actionStr isEqualToString:@"自动监测开关"]) {
       [self.navigationController pushViewController:[SyncAutomaticMonitoringViewController new] animated:true];
   } else if ([actionStr isEqualToString:@"久坐提醒"]) {
       [self.navigationController pushViewController:[SedentaryReminderViewController new] animated:true];
   } else if ([actionStr isEqualToString:@"亮屏设置"]) {
       [self.navigationController pushViewController:[TurnWristViewController new] animated:true];
   } else if ([actionStr isEqualToString:@"倒计时"]) {
       [self.navigationController pushViewController:[CountDownViewController new] animated:true];
   } else if ([actionStr isEqualToString:@"查找手机"]) {
       [self.navigationController pushViewController:[FindPhoneViewController new] animated:true];
   } else if ([actionStr isEqualToString:@"天气"]) {
       [self.navigationController pushViewController:[WeatherViewController new] animated:true];
   } else if ([actionStr isEqualToString:@"遥控拍照"]) {
       [self.navigationController pushViewController:[RemotePhotographyViewController new] animated:true];
   } else if ([actionStr isEqualToString:@"通讯录"]) {
       [self.navigationController pushViewController:[AddressBookViewController new] animated:true];
   } else if ([actionStr isEqualToString:@"音频蓝牙配对"]) {
       [self.navigationController pushViewController:[AudioBluetoothPairingViewController new] animated:true];
   } else if ([actionStr isEqualToString:@"固体升级"]) {
       [self.navigationController pushViewController:[OtaActionViewController new] animated:true];
   } else if ([actionStr isEqualToString:@"内置/下载/自定义表盘"]) {
       [self.navigationController pushViewController:[CustomizeMainInterfaceViewController new] animated:true];
   }
}

//
///**
// @param tableView tableView description
// @param indexPath indexPath description
// */
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    NSString *actionStr = NSLocalizedString(self.functionArr[indexPath.row], nil);
//
//    __weak __typeof(self)weakSelf = self;
//    if ([actionStr isEqualToString:NSLocalizedString(@"Synchronize personal information", nil)]) {
//
//        [self.view makeToast:NSLocalizedString(@"Setting Gender: Male, Age: 18, Height: 60.5cm, Weight: 75.5kg", nil)];
//
//        [MBProgressHUD showHUDAddedTo:self.view animated:true];
//        [JWBleAction jwSynchronizePersonalInformation:18 isMan:true height:60.5 weight:75.5 callBack:^(JWBleCommunicationStatus status) {
//            [MBProgressHUD hideHUDForView:weakSelf.view animated:true];
//            [weakSelf.view makeToast:[JWBleDemoHelp communication2Str:status]];
//        }];
//
//    } else if ([actionStr isEqualToString:NSLocalizedString(@"Set step goal", nil)]) {
//
//        [self.view makeToast:NSLocalizedString(@"Setting goals: 1000 steps", nil)];
//
//        [MBProgressHUD showHUDAddedTo:self.view animated:true];
//        [JWBleAction jwSetStepTargetAction:10000 callBack:^(JWBleCommunicationStatus status) {
//            [MBProgressHUD hideHUDForView:weakSelf.view animated:true];
//            [weakSelf.view makeToast:[JWBleDemoHelp communication2Str:status]];
//        }];
//
//    } else if ([actionStr isEqualToString:NSLocalizedString(@"Set sleep goals", nil)]) {
//
//        [self.view makeToast:NSLocalizedString(@"Setting goal: 6 hours", nil)];
//
//        [MBProgressHUD showHUDAddedTo:self.view animated:true];
//        [JWBleAction jwSetSleepTargetAction:6*60 callBack:^(JWBleCommunicationStatus status) {
//            [MBProgressHUD hideHUDForView:weakSelf.view animated:true];
//            [weakSelf.view makeToast:[JWBleDemoHelp communication2Str:status]];
//        }];
//
//    } else if ([actionStr isEqualToString:NSLocalizedString(@"Find bracelet", nil)]) {
//        [JWBleAction jwFindDeviceWithCallBack:^(JWBleCommunicationStatus status) {
//            [weakSelf.view makeToast:[JWBleDemoHelp communication2Str:status]];
//        }];
//    } else if ([actionStr isEqualToString:NSLocalizedString(@"Open the remote camera", nil)]) {
//        [MBProgressHUD showHUDAddedTo:self.view animated:true];
//
//        [JWBleAction jwRemotePhotography:true callBack:^(JWBleCommunicationStatus status) {
//            [MBProgressHUD hideHUDForView:weakSelf.view animated:true];
//        }];
//
//        [self.view makeToast:NSLocalizedString(@"If shaking the bracelet has no effect, do some other operations first", nil)];
//
//        JWBleManager.remotePhotographyCallBack = ^(JWBleRemotePhotographyStatus remotePhotographyStatus) {
//            if (remotePhotographyStatus == JWBleRemotePhotographyStatus_TakePhoto) {
//                [weakSelf.view makeToast:NSLocalizedString(@"Photo callback", nil)];
//            }
//        };
//    } else if ([actionStr isEqualToString:NSLocalizedString(@"Turn off the remote camera", nil)]) {
//        [MBProgressHUD showHUDAddedTo:self.view animated:true];
//        [JWBleAction jwRemotePhotography:false callBack:^(JWBleCommunicationStatus status) {
//            [MBProgressHUD hideHUDForView:weakSelf.view animated:true];
//            [weakSelf.view makeToast:[JWBleDemoHelp communication2Str:status]];
//        }];
//    } else if ([actionStr isEqualToString:NSLocalizedString(@"Continuous heart rate monitoring", nil)]) {
//        [self.navigationController pushViewController:[ContinuousHRViewController new] animated:true];
//    } else if ([actionStr isEqualToString:NSLocalizedString(@"Turn the wrist bright screen-bright screen duration", nil)]) {
//        [self.navigationController pushViewController:[TurnWristViewController new] animated:true];
//    } else if ([actionStr isEqualToString:NSLocalizedString(@"Sedentary reminder", nil)]) {
//        [self.navigationController pushViewController:[SedentaryReminderViewController new] animated:true];
//    } else if ([actionStr isEqualToString:NSLocalizedString(@"Hour System-Metric and Imperial", nil)]) {
//        [self.navigationController pushViewController:[TimeThemeViewController new] animated:true];
//    } else if ([actionStr isEqualToString:NSLocalizedString(@"Language", nil)]) {
//        [self.navigationController pushViewController:[LanguageViewController new] animated:true];
//    } else if ([actionStr isEqualToString:NSLocalizedString(@"Do not disturb mode", nil)]) {
//        [self.navigationController pushViewController:[NotDisturbViewController new] animated:true];
//    } else if ([actionStr isEqualToString:NSLocalizedString(@"notification", nil)]) {
//        [self.navigationController pushViewController:[NoticeViewController new] animated:true];
//    } else if ([actionStr isEqualToString:NSLocalizedString(@"Alarm setting", nil)]) {
//        [self.navigationController pushViewController:[AlarmClockViewController new] animated:true];
//    } else if ([actionStr isEqualToString:NSLocalizedString(@"Test heart rate", nil)]) {
//        [self.navigationController pushViewController:[TestHRViewController new] animated:true];
//    } else if ([actionStr isEqualToString:NSLocalizedString(@"Test blood pressure", nil)]) {
//        TestHRViewController *vc = [TestHRViewController new];
//        vc.testBP = true;
//        [self.navigationController pushViewController:vc animated:true];
//    } else if ([actionStr isEqualToString:NSLocalizedString(@"Test headphones", nil)]) {
//        [self.navigationController pushViewController:[TestHeadsetViewController new] animated:true];
//    } else if ([actionStr isEqualToString:NSLocalizedString(@"Get bracelet data", nil)]) {
//        [self.navigationController pushViewController:[GetDeviceDataViewController new] animated:true];
//    } else if ([actionStr isEqualToString:NSLocalizedString(@"Check if there is a function", nil)]) {
//        [self.navigationController pushViewController:[CheckFunctionViewController new] animated:true];
//    } else if ([actionStr isEqualToString:NSLocalizedString(@"Temperature correlation", nil)]) {
//        [self.navigationController pushViewController:[TestTemperatureViewController new] animated:true];
//    } else if ([actionStr isEqualToString:NSLocalizedString(@"Bracelet function display and hide", nil)]) {
//        [self.navigationController pushViewController:[HiddenFunctionActionViewController new] animated:true];
//    } else if ([actionStr isEqualToString:NSLocalizedString(@"Heart rate switch", nil)]) {
//        [self.navigationController pushViewController:[HRSwitchViewController new] animated:true];
//    } else if ([actionStr isEqualToString:NSLocalizedString(@"Continuous blood pressure", nil)]) {
//        [self.navigationController pushViewController:[ContinuousBPViewController new] animated:true];
//    } else if ([actionStr isEqualToString:NSLocalizedString(@"Customize the main interface", nil)]) {
//        [self.navigationController pushViewController:[CustomizeMainInterfaceViewController new] animated:true];
//    } else if ([actionStr isEqualToString:NSLocalizedString(@"Update Interface Color", nil)]) {
//        [self.navigationController pushViewController:[UpdateInterfaceColorViewController new] animated:true];
//    } else if ([actionStr isEqualToString:NSLocalizedString(@"OTA", nil)]) {
//        [self.navigationController pushViewController:[OtaActionViewController new] animated:true];
//    } else if ([actionStr isEqualToString:NSLocalizedString(@"Image OTA", nil)]) {
//        [self.navigationController pushViewController:[ImageOtaViewController new] animated:true];
//    } else if ([actionStr isEqualToString:NSLocalizedString(@"Custom Set Pulse/SleepAid", nil)]) {
//        [self.navigationController pushViewController:[CustomSetPluseViewController new] animated:true];
//    } else if ([actionStr isEqualToString:NSLocalizedString(@"Sauna Data", nil)]) {
//        [self.navigationController pushViewController:[SaunaViewController new] animated:true];
//    } else if ([actionStr isEqualToString:NSLocalizedString(@"V7(GT7D) ActionList", nil)]) {
//        [self.navigationController pushViewController:[V7_GT7D_ActionListViewController new] animated:true];
//    }
//
//}

#pragma mark - getter
- (NSArray *)functionArr {
    if (!_functionArr) {
        _functionArr = @[
            @"蓝牙搜索",
            @"设备连接",
            @"断开连接",
            @"同步时间",
            @"用户信息",
            @"语言",
            @"单位设置",
            @"目标设定",
            @"同步数据",
            @"查询电量",
            @"通知开关",
            @"闹钟",
            @"自动监测开关",
            @"久坐提醒",
            @"亮屏设置",
            @"倒计时",
            @"查找手机",
            @"天气",
            @"遥控拍照",
            @"通讯录",
            @"音频蓝牙配对",
            @"固体升级",
            @"内置/下载/自定义表盘"
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

#pragma mark - help
- (NSInteger)getStringLenthOfBytes:(NSString *)str {
    NSInteger length = 0;
    for (int i = 0; i < [str length]; i++) {
        NSString *s = [str substringWithRange:NSMakeRange(i, 1)];
        NSData *data = [s dataUsingEncoding:NSUTF8StringEncoding];
        length += data.length;
    }
    return length;
}

- (NSString *)subBytesOfstringToIndex:(NSInteger)index str:(NSString *)str {
    NSInteger length = 0;
    
    for (int i = 0; i < [str length]; i++) {
        NSString *s = [str substringWithRange:NSMakeRange(i, 1)];
        NSData *data = [s dataUsingEncoding:NSUTF8StringEncoding];
        
        if (length + data.length > index) {
            return [str substringToIndex:i];
        }
        
        length += data.length;
    }
    
    return [str substringToIndex:index];
}

@end
