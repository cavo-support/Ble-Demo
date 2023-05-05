//
//  RootViewController.m
//  JWBleDemo
//
//  Created by Bo 黄 on 2019/3/20.
//  Copyright © 2019 wosmart. All rights reserved.
//

#import "RootViewController.h"
#import "ScanViewController.h"
#import "ActionListViewController.h"

@interface RootViewController ()

@property (weak, nonatomic) IBOutlet UIButton *connectionBtn;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *bleStatusLB;
@property (weak, nonatomic) IBOutlet UIButton *functionBtn;

@end

@implementation RootViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.functionBtn setTitle:NSLocalizedString(@"function list", nil) forState:UIControlStateNormal];
    [self.connectionBtn setTitle:NSLocalizedString(@"To connect", nil) forState:UIControlStateNormal];
    self.textView.text = NSLocalizedString(@"Device is not connected", nil);
    
    self.title = @"JW Ble Demo";
    
    NSLog(@"%@",[JWBleManager sdkInfo]);
    
    JWBleManager.showLog = true;
    [JWBleManager setUpWithUid:@"huangbo"];
    
    __weak __typeof(self)weakSelf = self;
    JWBleManager.connectStateChangeCallBack = ^(JWBleDeviceConnectStatus deviceConnectStatus) {
        if (JWBleManager.connectionModel.otaIng) {
            return ;
        }
        
        [weakSelf.navigationController popToRootViewControllerAnimated:true];
        [weakSelf updateConnectionBtnTitle];
        
        if (deviceConnectStatus == JWBleDeviceConnectStatus_Connect) {
            weakSelf.textView.text = NSLocalizedString(@"Successful connection, binding the bracelet", nil);
            [weakSelf.view makeToastActivity:self];
        } else if (deviceConnectStatus == JWBleDeviceConnectStatus_SyncSuccess) {
            NSString *name = [NSString stringWithFormat:@"name : %@",JWBleManager.connectionModel.deviceName];
            NSString *mac = [NSString stringWithFormat:@"mac : %@",JWBleManager.connectionModel.macAddress];
            NSString *deviceNumber = [NSString stringWithFormat:@"%@ : %d",NSLocalizedString(@"Hardware number", nil),JWBleManager.connectionModel.deviceNumber];
            NSString *power = [NSString stringWithFormat:@"%@ : %d%%",NSLocalizedString(@"Power", nil),JWBleManager.connectionModel.power];
            NSString *appVersion = [NSString stringWithFormat:@"versionName : %@",JWBleManager.connectionModel.versionName];

            weakSelf.textView.text = [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%@\n",name,mac,deviceNumber,power,appVersion];
            [weakSelf.view hideToastActivity];

            NSLog(@"JWBleDeviceConnectStatus_SyncSuccess \n \t weakSelf.textView.text : %@", weakSelf.textView.text);
        } else if (deviceConnectStatus == JWBleDeviceConnectStatus_SyncFailure) {
            weakSelf.textView.text = NSLocalizedString(@"Failed to obtain device information", nil);
            [weakSelf.view hideToastActivity];
        } else if (deviceConnectStatus == JWBleDeviceConnectStatus_BondSuccess) {
            weakSelf.textView.text = NSLocalizedString(@"Successful binding, basic information is being set", nil);
            [weakSelf.view makeToastActivity:self];
        } else if (deviceConnectStatus == JWBleDeviceConnectStatus_BondFailure) {
            [weakSelf showBondFailAlert];
            [weakSelf.view hideToastActivity];
        } else if (deviceConnectStatus == JWBleDeviceConnectStatus_DiscoverNewUpdateFirm) {
            weakSelf.textView.text = NSLocalizedString(@"Discover new firmware that can be upgraded", nil);
            [weakSelf.view hideToastActivity];
        } else if (deviceConnectStatus == JWBleDeviceConnectStatus_DisConnect) {
            weakSelf.textView.text = NSLocalizedString(@"Device is not connected", nil);
            [weakSelf.view hideToastActivity];
            [weakSelf updateConnectionBtnTitle];
        }
    };
    
    NSArray *txtArr = @[
                        @"unknown",
                        @"Resetting",
                        @"Device does not support",
                        @"Device is not authorized",
                        @"System Bluetooth is off",
                        @"System Bluetooth is on"
                        ];
    
    JWBleManager.centralManagerStateChangeBlock = ^(JWBleCentralManagerState centralManagerState) {
        weakSelf.bleStatusLB.text = [NSString stringWithFormat:@"%@：%@",NSLocalizedString(@"Phone Bluetooth status", nil),NSLocalizedString(txtArr[centralManagerState], nil)];
    };
}

- (void)updateConnectionBtnTitle {
    if (JWBleManager.isConnected) {
        [self.connectionBtn setTitle:NSLocalizedString(@"Disconnect", nil) forState:UIControlStateNormal];
    } else {
        [self.connectionBtn setTitle:NSLocalizedString(@"To connect", nil) forState:UIControlStateNormal];
    }
}

- (IBAction)click2ConnectionBtn:(id)sender {
    if (JWBleManager.isConnected) {
        [JWBleAction jwDisConnect];
    } else {
        [self.navigationController pushViewController:[ScanViewController new] animated:true];
    }
}

- (IBAction)clickActionList:(id)sender {
    if (JWBleManager.isConnected) {
        [self.navigationController pushViewController:[ActionListViewController new] animated:true];
    } else {
        [self.navigationController pushViewController:[ScanViewController new] animated:true];
    }
}

#pragma mark - help
- (void)showBondFailAlert {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Binding failed, please confirm whether the bracelet has been connected by other mobile phones", nil)
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Ok", nil) style:UIAlertActionStyleCancel
                                                         handler:nil];
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end
