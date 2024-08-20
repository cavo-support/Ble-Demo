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
#import "HRVRmssdViewController.h"

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
       
       //2: 监听电量改变
       //JWBleManager.connectStateChangeCallBack 回调中，监听 JWBleDeviceConnectStatus_BatteryUpdate，然后再以第一步方式获取
       
       //3: 当前电量
       [JWBleAction jwGetDeviceCurrentBattery];
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
   } else if ([actionStr isEqualToString:@"HRV-RMSSD"]) {
       [self.navigationController pushViewController:[HRVRmssdViewController new] animated:true];
   }
}


#pragma mark - getter
- (NSArray *)functionArr {
    if (!_functionArr) {
        _functionArr = @[
            @"HRV-RMSSD",
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
