//
//  SyncDataViewController.m
//  JWBleDemo
//
//  Created by bobobo on 2023/6/21.
//  Copyright © 2023 wosmart. All rights reserved.
//

#import "SyncDataViewController.h"

@interface SyncDataViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *dataTypeSeg;
@property (weak, nonatomic) IBOutlet UILabel *syncStatusLB;
@property (weak, nonatomic) IBOutlet UITextView *detaDetailTextView;

@end

@implementation SyncDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"SyncData", nil);
    
}

- (IBAction)clickSyncBtn:(id)sender {
    
    self.syncStatusLB.text = @"synchronizing";
    self.detaDetailTextView.text = @"";
    
//    JWBleSyncEnum_Start = 0,//开始 Start
//    JWBleSyncEnum_Interrupt, //中断 Interrupt
//    JWBleSyncEnum_InconsistentTotals, //总数不一致 Inconsistent totals
//    JWBleSyncEnum_Complete //完成
    
//    [JWBleAction jwDeviceDataReset];
    
    __weak __typeof(self)weakSelf = self;
    [JWBleDataAction jwSyncDataWithCallBack:^(JWBleCommunicationStatus status, JWBleSyncStateEnum syncStateEnum) {
        if (syncStateEnum == JWBleSyncEnum_Start) {
            weakSelf.syncStatusLB.text = @"synchron Start" ;
        } else if (syncStateEnum == JWBleSyncEnum_Interrupt) {
            weakSelf.syncStatusLB.text = @"synchron Interrupt";
        } else if (syncStateEnum == JWBleSyncEnum_InconsistentTotals) {
            weakSelf.syncStatusLB.text = @"synchron InconsistentTotals";
            
            /**
            A data exception occurs, and the total number of data returned by the firmware is inconsistent with the total number received;

            1: Full data can be pulled back, but it takes a long time;
            [JWBleAction jwDeviceDataReset];
            
            2: It can be ignored, and the synchronization is directly considered successful;
             */
            
        } else if (syncStateEnum == JWBleSyncEnum_Complete) {
            weakSelf.syncStatusLB.text = @"synchron Complete";
            
            [weakSelf getDBData];
        }
    }];
}

- (void)getDBData {
    
    NSString *dateString = [self currentDayStr];
    self.detaDetailTextView.text = dateString;
    
    // step sleep hr temp oxygen sports
    __weak __typeof(self)weakSelf = self;
    if (self.dataTypeSeg.selectedSegmentIndex == 0) {//step
        
        [JWBleDataAction jwGetStepDataByYYYYMMDDStr:dateString callBack:^(NSArray *dataArr) {
            for (int i = 0; i < dataArr.count; i++) {
                NSDictionary *valueDic = dataArr[i];
                
                int steps = [[valueDic objectForKey:@"steps"] intValue];
                if (steps == 0) {
                    continue;
                }
                int offset = [[valueDic objectForKey:@"offset"] intValue];
                int distance = [[valueDic objectForKey:@"distance"] intValue];
                int calory = [[valueDic objectForKey:@"calory"] intValue];
                NSString *valueStr = [NSString stringWithFormat:@"steps:%d offest:%d distance:%d calory:%d",steps,offset,distance,calory];
                
                weakSelf.detaDetailTextView.text = [NSString stringWithFormat:@"%@ \n %@",weakSelf.detaDetailTextView.text,valueStr];
            }
            
            // device total
            [JWBleDataAction jwGetDayStepTotalValue:dateString callback:^(JWBleCommunicationStatus status, int step, int dis, int calories) {
                NSString *valueStr = [NSString stringWithFormat:@"step:%d dis:%d calories:%d",step,dis,calories];
                weakSelf.detaDetailTextView.text = [NSString stringWithFormat:@"%@ \n total: %@",weakSelf.detaDetailTextView.text,valueStr];
            }];
        }];
    } else if (self.dataTypeSeg.selectedSegmentIndex == 1) {//sleep
        
//        get filter data
        [JWBleDataAction jwGetFilterSleepDataByYYYYMMDDStr:dateString callBack:^(NSArray *dataArr) {

        }];
        
        [JWBleDataAction jwGetSleepDataByYYYYMMDDStr:dateString callBack:^(NSArray *dataArr) {
            if (dataArr.count == 0) {
                weakSelf.detaDetailTextView.text = [NSString stringWithFormat:@"%@ \n empty data",weakSelf.detaDetailTextView.text];
            } else {
                for (int i = 0; i < dataArr.count; i++) {
                    NSDictionary *valueDic = dataArr[i];
                    
                    int minute = [[valueDic objectForKey:@"minute"] intValue];
                    int status = [[valueDic objectForKey:@"status"] intValue];
                    NSString *statusStr = @"sober";
                    if (status == 1) {
                        statusStr = @"light sleep";
                    } else if (status == 2) {
                        statusStr = @"deep sleep";
                    }
                    NSString *valueStr = [NSString stringWithFormat:@"minute:%d statusStr:%@",minute,statusStr];
                    
                    weakSelf.detaDetailTextView.text = [NSString stringWithFormat:@"%@ \n %@",weakSelf.detaDetailTextView.text,valueStr];
                }
            }
        }];
    } else if (self.dataTypeSeg.selectedSegmentIndex == 2) {//hr
        [JWBleDataAction jwGetHRDataByYYYYMMDDStr:dateString callBack:^(NSArray *dataArr) {
            if (dataArr.count == 0) {
                weakSelf.detaDetailTextView.text = [NSString stringWithFormat:@"%@ \n empty data",weakSelf.detaDetailTextView.text];
            } else {
                for (int i = 0; i < dataArr.count; i++) {
                    NSDictionary *valueDic = dataArr[i];
                    
                    int time = [[valueDic objectForKey:@"time"] intValue];
                    int value = [[valueDic objectForKey:@"value"] intValue];
                    NSString *valueStr = [NSString stringWithFormat:@"time:%d value:%d",time,value];
                    
                    weakSelf.detaDetailTextView.text = [NSString stringWithFormat:@"%@ \n %@",weakSelf.detaDetailTextView.text,valueStr];
                }
            }
        }];
    } else if (self.dataTypeSeg.selectedSegmentIndex == 3) {//temp
        [JWBleDataAction jwGetTemperatureDataByYYYYMMDDStr:dateString callBack:^(NSArray *dataArr) {
            if (dataArr.count == 0) {
                weakSelf.detaDetailTextView.text = [NSString stringWithFormat:@"%@ \n empty data",weakSelf.detaDetailTextView.text];
            } else {
                for (int i = 0; i < dataArr.count; i++) {
                    NSDictionary *valueDic = dataArr[i];
                    
                    int time = [[valueDic objectForKey:@"time"] intValue];
                    int wearingState = [[valueDic objectForKey:@"wearingState"] intValue];
                    float value = [[valueDic objectForKey:@"value"] floatValue];
                    if (wearingState) {
                        value = [JWBleDataAction jwTemperatureCalibration:value];
                    } else {
                        value = value / 10.0f;
                    }
                    int compensationStatus = [[valueDic objectForKey:@"compensationStatus"] intValue];
                    NSString *valueStr = [NSString stringWithFormat:@"time:%d value:%.1f wearingState:%d compensationStatus:%d",time,value,wearingState,compensationStatus];
                    
                    weakSelf.detaDetailTextView.text = [NSString stringWithFormat:@"%@ \n %@",weakSelf.detaDetailTextView.text,valueStr];
                }
            }
        }];
    } else if (self.dataTypeSeg.selectedSegmentIndex == 4) {//oxygen
        [JWBleDataAction jwGetOxygenDataByYYYYDDStr:dateString callBack:^(NSArray *dataArr) {
            if (dataArr.count == 0) {
                weakSelf.detaDetailTextView.text = [NSString stringWithFormat:@"%@ \n empty data",weakSelf.detaDetailTextView.text];
            } else {
                for (int i = 0; i < dataArr.count; i++) {
                    JWOxygenModel *oxygenModel = dataArr[i];
                    
                    NSString *valueStr = [NSString stringWithFormat:@"time:%d mCurValue:%d mHighValue:%d mLowValue:%d",oxygenModel.time,oxygenModel.mCurValue,oxygenModel.mHighValue,oxygenModel.mLowValue];
                    
                    weakSelf.detaDetailTextView.text = [NSString stringWithFormat:@"%@ \n %@",weakSelf.detaDetailTextView.text,valueStr];
                }
            }
            
        }];
    } else if (self.dataTypeSeg.selectedSegmentIndex == 5) {//sports
        
        [JWBleDataAction jwGetMotionDataByYYYYMMDDStr:dateString callBack:^(NSArray *dataArr) {
            if (dataArr.count == 0) {
                weakSelf.detaDetailTextView.text = [NSString stringWithFormat:@"%@ \n empty data",weakSelf.detaDetailTextView.text];
            } else {
                for (int i = 0; i < dataArr.count; i++) {
                    NSDictionary *valueDic = dataArr[i];
                    
                    int minuteIndex = [[valueDic objectForKey:@"minuteIndex"] intValue];
                    int seconds = [[valueDic objectForKey:@"seconds"] intValue];
                    int motionType = [[valueDic objectForKey:@"motionType"] intValue];
                    int sportsMinute = [[valueDic objectForKey:@"sportsMinute"] intValue];
                    int sportsSeconds = [[valueDic objectForKey:@"sportsSeconds"] intValue];
                    NSString *valueStr = [NSString stringWithFormat:@"minuteIndex:%d seconds:%d motionType:%d sportsMinute:%d sportsSeconds:%d",minuteIndex,seconds,motionType,sportsMinute,sportsSeconds];
                    
                    weakSelf.detaDetailTextView.text = [NSString stringWithFormat:@"%@ \n %@",weakSelf.detaDetailTextView.text,valueStr];
                }
            }
        }];
    }
}

- (NSString *)currentDayStr{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYYMMdd"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    return dateString;
}


@end
