//
//  GetDeviceDataViewController.m
//  JWBleDemo
//
//       Synchronized data flow:
//          1: Connect the bracelet;
//          2: Execute [JWBleDataAction jwSyncDataWithCallBack:] to synchronize the bracelet data to the sdk storage;
//          3: After the monitoring synchronization is successful, the JWBleDataAction class provides a variety of data acquisition APIs, such as the method of acquiring steps
//          [JWBleDataAction jwGetStepDataByYYYYMMDDStr:@"2020-07-10" callBack:^(NSArray *dataArr) {
//            if (dataArr.count == 96) {
//            }
//          }];
//
//  Created by Bo 黄 on 2020/7/10.
//  Copyright © 2020 wosmart. All rights reserved.
//

#import "GetDeviceDataViewController.h"

@interface GetDeviceDataViewController ()

@end

@implementation GetDeviceDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Get bracelet data", nil);
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view makeToast:NSLocalizedString(@"Developers need to change the number of days acquired", nil)];
    
    [self syncData];
}

- (void)syncData {
    __weak __typeof(self)weakSelf = self;
    [JWBleDataAction jwSyncDataWithCallBack:^(JWBleCommunicationStatus status, JWBleSyncStateEnum syncStateEnum) {
        if (status == JWBleCommunicationStatus_Success && syncStateEnum == JWBleSyncEnum_Complete) {
            [weakSelf getDeviceDayArr:@"2020-07-10"];
        } else if (syncStateEnum == JWBleSyncEnum_Interrupt) {
            [self.view makeToast:@"JWBleSyncEnum_Interrupt"];
        }
    }];
}

- (void)getDeviceDayArr:(NSString *)dayStr {
    
    __weak __typeof(self)weakSelf = self;
    [JWBleDataAction jwGetStepDataByYYYYMMDDStr:dayStr callBack:^(NSArray *dataArr) {
        if (dataArr.count == 96) {
        }
    }];
    
    [JWBleDataAction jwGetSleepDataByYYYYMMDDStr:dayStr callBack:^(NSArray *dataArr) {
        if (dataArr.count > 1) {
        }
    }];
    
    [JWBleDataAction jwGetHRDataByYYYYMMDDStr:dayStr callBack:^(NSArray *dataArr) {
        if (dataArr.count > 0) {
        }
    }];
    
    if ([JWBleAction jwCheckFunctionStates:JWBleFunctionEnum_Temperature] == JWBleFunctionStateEnum_Open) {
        [JWBleDataAction jwGetTemperatureDataByYYYYMMDDStr:dayStr callBack:^(NSArray *dataArr) {
            if (dataArr.count > 0) {
            }
        }];
    }
    
    [JWBleDataAction jwGetMotionDataByYYYYMMDDStr:dayStr callBack:^(NSArray *dataArr) {
        if (dataArr.count > 0) {
        }
    }];
}

@end
