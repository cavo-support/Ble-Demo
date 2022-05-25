//
//  MainInterfaceStyleViewController.m
//  CoreBluetoothDemo
//
//  Created by Bo 黄 on 2019/3/11.
//  Copyright © 2019 Jone. All rights reserved.
//

#import "MainInterfaceStyleViewController.h"
#import "SettingRecordModel.h"

@interface MainInterfaceStyleViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *seg;
@property (weak, nonatomic) IBOutlet UISwitch *switchView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewConstraint;

@end

@implementation MainInterfaceStyleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (@available(iOS 11, *) == false) {
        self.topViewConstraint.constant += 64;
    }
    
    self.title = @"主界面风格";
    
    __weak __typeof(self)weakSelf = self;
    [JWBleAction jwMainInterfaceAction:true willShowIndex:0 callBack:^(JWBleCommunicationStatus status, int curShowIndex, int count) {
        if (status == JWBleCommunicationStatus_Success) {
            [weakSelf.seg removeAllSegments];
            for (int i = 0; i < count; i++) {
                [weakSelf.seg insertSegmentWithTitle:[NSString stringWithFormat:@" 风格%d ",i+1] atIndex:i animated:false];
            }
            weakSelf.seg.selectedSegmentIndex = curShowIndex;
        }
    }];
    
    self.switchView.on = [SettingRecordModel findByCurConnectionModel].mainInterfaceAutoSync;
}

- (IBAction)clickSetBtin:(id)sender {
    int selectIndex = (int)self.seg.selectedSegmentIndex;
    
    [self.view makeToastActivity:self];
    
    __weak __typeof(self)weakSelf = self;
    [JWBleAction jwMainInterfaceAction:false willShowIndex:selectIndex callBack:^(JWBleCommunicationStatus status, int curShowIndex, int count) {
        [weakSelf.view hideToastActivity];
        [weakSelf.view makeToast:[JWBleDemoHelp communication2Str:status]];
    }];
    
    SettingRecordModel *settingModel = [SettingRecordModel findByCurConnectionModel];
    settingModel.mainInterfaceAutoSync = self.switchView.on;
    settingModel.mainInterfaceSelectIndex = (int)self.seg.selectedSegmentIndex;
    [settingModel saveOrUpdate];
    
}

- (IBAction)switchValueChanged:(id)sender {
    SettingRecordModel *settingModel = [SettingRecordModel findByCurConnectionModel];
    settingModel.mainInterfaceAutoSync = self.switchView.on;
    settingModel.mainInterfaceSelectIndex = (int)self.seg.selectedSegmentIndex;
    [settingModel saveOrUpdate];
}

@end
