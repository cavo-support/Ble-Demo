//
//  ContinuousHRViewController.m
//  JWBleDemo
//
//  Created by Bo 黄 on 2019/8/6.
//  Copyright © 2019 wosmart. All rights reserved.
//

#import "ContinuousHRViewController.h"

@interface ContinuousHRViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@property (weak, nonatomic) IBOutlet UISwitch *switchView;
@property(nonatomic, strong) NSArray *supportArr;

@end

@implementation ContinuousHRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Continuous heart rate monitoring", nil);
    
    [MBProgressHUD showHUDAddedTo:self.view animated:true];
    __weak __typeof(self)weakSelf = self;
    
    self.segment.selectedSegmentIndex = 0;
    [JWBleAction jwGetHRAutomaticDetectionType:^(JWBleCommunicationStatus status, NSDictionary *resultDic) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:true];
        if (status == JWBleCommunicationStatus_Success) {
            [weakSelf.segment removeAllSegments];
            
            weakSelf.supportArr = [resultDic allKeys];
            for (int i = 0; i < weakSelf.supportArr.count; i++) {
                [self.segment insertSegmentWithTitle:weakSelf.supportArr[i] atIndex:i animated:true];
            }
        }
        if (status == JWBleCommunicationStatus_Busy) {
        }
    }];
    
    [JWBleAction jwHrAutomaticDetectionAction:true open:false timeSpan:0 callBack:^(JWBleCommunicationStatus status, BOOL open, int timeSpan) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:true];
        [weakSelf.view makeToast:[JWBleDemoHelp communication2Str:status]];
        if (status == JWBleCommunicationStatus_Success) {
            weakSelf.switchView.on = open;
            weakSelf.segment.selectedSegmentIndex = [weakSelf segIndex:timeSpan];
        }
    }];
}

- (IBAction)segmentChanged:(id)sender {
    [self save2Device];
}

- (IBAction)switchViewChanged:(id)sender {
    
    [self save2Device];
    
    self.segment.hidden = !self.switchView.on;
}

- (void)save2Device {
    
    if (self.switchView.on) {
        int timeSpan = [self.supportArr[0] integerValue];
        
        //注意：我们需要将0的值转换为1，这才可设置连续检测（实时监测）
        //Note: We need to convert the value of 0 to 1 before we can set up continuous detection (real-time monitoring)
        timeSpan = timeSpan == 0 ? 1 : timeSpan;
        
        [MBProgressHUD showHUDAddedTo:self.view animated:true];
        __weak __typeof(self)weakSelf = self;
        [JWBleAction jwHrAutomaticDetectionAction:false open:self.switchView.on timeSpan:timeSpan callBack:^(JWBleCommunicationStatus status, BOOL open, int timeSpan) {
            [MBProgressHUD hideHUDForView:weakSelf.view animated:true];
            [weakSelf.view makeToast:[JWBleDemoHelp communication2Str:status]];
        }];
    } else {
        [MBProgressHUD showHUDAddedTo:self.view animated:true];
        __weak __typeof(self)weakSelf = self;
        [JWBleAction jwHrAutomaticDetectionAction:false open:self.switchView.on timeSpan:0 callBack:^(JWBleCommunicationStatus status, BOOL open, int timeSpan) {
            [MBProgressHUD hideHUDForView:weakSelf.view animated:true];
            [weakSelf.view makeToast:[JWBleDemoHelp communication2Str:status]];
        }];
    }

}

- (NSInteger)segIndex:(int)timeSpan {
    if (timeSpan == 5) {
        return 0;
    } else if (timeSpan == 30) {
        return 1;
    } else if (timeSpan == 60) {
        return 2;
    } else {
        return 3;
    }
}


@end
