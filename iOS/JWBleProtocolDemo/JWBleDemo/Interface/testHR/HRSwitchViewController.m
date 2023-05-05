//
//  HRSwitchViewController.m
//  JWBleDemo
//
//  Created by Bo 黄 on 2020/7/21.
//  Copyright © 2020 wosmart. All rights reserved.
//

#import "HRSwitchViewController.h"

@interface HRSwitchViewController ()

@end

@implementation HRSwitchViewController

#pragma mark - warning
/**
 心率开关注意事项：
    1. 判断手环是否支持心率；
    2. 开启开关前，需要获取手环支持的间隔；
 
 Note for heart rate switch:
 1. Determine whether the bracelet supports heart rate;
 2. Before turning on the switch, you need to obtain the interval supported by the bracelet;
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Heart rate switch", nil);
    

    
}

- (IBAction)clickOpen:(id)sender {
    if ([JWBleAction jwCheckFunctionStates:JWBleFunctionEnum_HR]) {
        [JWBleAction jwGetHRAutomaticDetectionType:^(JWBleCommunicationStatus status, NSDictionary *resultDic) {
            if (status == JWBleCommunicationStatus_Success) {
                if (resultDic.allKeys.count > 0) {
                    int span = [[resultDic objectForKey:resultDic.allKeys.firstObject] intValue];
                    [JWBleAction jwHrAutomaticDetectionAction:false open:true timeSpan:span callBack:^(JWBleCommunicationStatus status, BOOL open, int timeSpan) {
                        if (status == JWBleCommunicationStatus_Success) {
                            //do...
                        }
                    }];
                }
            }
        }];
    }
}

- (IBAction)clickClose:(id)sender {
    [JWBleAction jwHrAutomaticDetectionAction:false open:false timeSpan:0 callBack:^(JWBleCommunicationStatus status, BOOL open, int timeSpan) {
        if (status == JWBleCommunicationStatus_Success) {
            //do...
        }
    }];
}

@end
