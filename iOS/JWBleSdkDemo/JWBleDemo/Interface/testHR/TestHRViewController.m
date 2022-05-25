//
//  TestHRViewController.m
//  JWBleDemo
//
//  Created by Bo 黄 on 2019/8/9.
//  Copyright © 2019 wosmart. All rights reserved.
//

#import "TestHRViewController.h"

@interface TestHRViewController ()

@property (weak, nonatomic) IBOutlet UILabel *valueLB;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@end

@implementation TestHRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.testBP ? NSLocalizedString(@"Test blood pressure", nil) : NSLocalizedString(@"Test heart rate", nil);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (self.testBP) {
        if (self.btn.enabled == false) {
            [JWBleAction jwTestBPAction:false callBack:^(JWBleCommunicationStatus status, JWBleTestBPStatus testStatus, int high, int low) {
                
            }];
        }
    } else {
        if (self.btn.enabled == false) {
            [JWBleAction jwTestHRAction:false callBack:^(JWBleCommunicationStatus status, JWBleTestHRStatus testStatus, int hrValue) {
                
            }];
        }
    }
}


- (IBAction)clickBtn:(id)sender {
    if (self.testBP) {
        [self tsetBPAction];
    } else {
        [self tsetHRAction];
    }
    
}

- (void)tsetBPAction {
    if (self.btn.enabled) {
        self.btn.enabled = false;
        __weak __typeof(self)weakSelf = self;
        [JWBleAction jwTestBPAction:true callBack:^(JWBleCommunicationStatus status, JWBleTestBPStatus testStatus, int high, int low) {
            if (status == JWBleCommunicationStatus_Success) {
                if (testStatus == JWBleTestBPStatus_TestStart) {
                    weakSelf.valueLB.text = NSLocalizedString(@"please wait...", nil);
                } else if (testStatus == JWBleTestBPStatus_DeviceResponse) {
                    weakSelf.valueLB.text = [NSString stringWithFormat:@"high:%d  --- low:%d",high,low];
                } else if (testStatus == JWBleTestBPStatus_TestEnd) {
                    weakSelf.btn.enabled = true;
                }
            } else {
                weakSelf.btn.enabled = true;
                [weakSelf.view makeToast:[JWBleDemoHelp communication2Str:status]];
            }
        }];
    } else {
        [JWBleAction jwTestHRAction:false callBack:^(JWBleCommunicationStatus status, JWBleTestHRStatus testStatus, int hrValue) {
            
        }];
    }
}

- (void)tsetHRAction {
    if (self.btn.enabled) {
        self.btn.enabled = false;
        __weak __typeof(self)weakSelf = self;
        [JWBleAction jwTestHRAction:true callBack:^(JWBleCommunicationStatus status, JWBleTestHRStatus testStatus, int hrValue) {
            if (status == JWBleCommunicationStatus_Success) {
                if (testStatus == JWBleTestHRStatus_TestStart) {
                    weakSelf.valueLB.text = NSLocalizedString(@"please wait...", nil);
                } else if (testStatus == JWBleTestHRStatus_DeviceResponse) {
                    weakSelf.valueLB.text = [NSString stringWithFormat:@"%@： %d",NSLocalizedString(@"Heart rate", nil),hrValue];
                } else if (testStatus == JWBleTestHRStatus_TestEnd) {
                    weakSelf.valueLB.text = NSLocalizedString(@"End of test", nil);
                    weakSelf.btn.enabled = true;
                }
            } else {
                weakSelf.btn.enabled = true;
                [weakSelf.view makeToast:[JWBleDemoHelp communication2Str:status]];
            }
        }];
        
    } else {
        [JWBleAction jwTestHRAction:false callBack:^(JWBleCommunicationStatus status, JWBleTestHRStatus testStatus, int hrValue) {
            
        }];
    }
}


@end
