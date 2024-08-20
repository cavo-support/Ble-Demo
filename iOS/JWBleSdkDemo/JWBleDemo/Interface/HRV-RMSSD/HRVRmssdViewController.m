//
//  HRVRmssdViewController.m
//  JWBleDemo
//
//  Created by bobobo on 2024/8/19.
//  Copyright © 2024 wosmart. All rights reserved.
//

#import "HRVRmssdViewController.h"

@interface HRVRmssdViewController ()

@property (weak, nonatomic) IBOutlet UILabel *valueLB;

@end

@implementation HRVRmssdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"HRV-RMSSD";
}

- (IBAction)clickGetStatusBtn:(id)sender {
    
    __weak __typeof(self)weakSelf = self;
    [JWBleAction jwCustomHrvRmssdAction:true timeInterval:0 callBack:^(JWBleCommunicationStatus status, int timeInterval) {
        [weakSelf.view makeToast:[NSString stringWithFormat:@"timeInterval : %d",timeInterval]];
    }];
}

- (IBAction)clickSetBtn1:(id)sender {
    __weak __typeof(self)weakSelf = self;
    [JWBleAction jwCustomHrvRmssdAction:false timeInterval:0 callBack:^(JWBleCommunicationStatus status, int timeInterval) {
        [weakSelf.view makeToast:[NSString stringWithFormat:@"timeInterval : %d",timeInterval]];
    }];
}

- (IBAction)clickSetBtn2:(id)sender {
    __weak __typeof(self)weakSelf = self;
    [JWBleAction jwCustomHrvRmssdAction:false timeInterval:5 callBack:^(JWBleCommunicationStatus status, int timeInterval) {
        [weakSelf.view makeToast:[NSString stringWithFormat:@"timeInterval : %d",timeInterval]];
    }];
}

- (IBAction)clickGetData:(id)sender {

    [JWBleAction jwDeviceDataReset];
    
    __weak __typeof(self)weakSelf = self;
    [JWBleDataAction jwSyncDataWithCallBack:^(JWBleCommunicationStatus status, JWBleSyncStateEnum syncStateEnum) {
        if (syncStateEnum == JWBleSyncEnum_Start) {
            weakSelf.valueLB.text = @"synchron Start" ;
        } else if (syncStateEnum == JWBleSyncEnum_Interrupt) {
            weakSelf.valueLB.text = @"synchron Interrupt";
        } else if (syncStateEnum == JWBleSyncEnum_InconsistentTotals) {
            weakSelf.valueLB.text = @"synchron InconsistentTotals";
            
        } else if (syncStateEnum == JWBleSyncEnum_Complete) {
            weakSelf.valueLB.text = @"synchron Complete";
            
            [weakSelf getDBData];
        }
    }];
}

- (void)getDBData {
    __weak __typeof(self)weakSelf = self;
    [JWBleDataAction jwGetHrvRmssdDataByYYYYDDStr:@"20240820" callBack:^(NSArray *dataArr) {
        NSMutableString *str = [NSMutableString new];
        for (NSDictionary *dic in dataArr) {
            int time = [[dic objectForKey:@"time"] intValue];
            int value = [[dic objectForKey:@"value"] intValue];
            [str appendFormat:@"\n time:%d \t value:%d",time,value];
        }
        weakSelf.valueLB.text = [str mutableCopy];
    }];
}


@end
