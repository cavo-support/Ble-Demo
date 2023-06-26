//
//  SyncAutomaticMonitoringTableViewCell.m
//  JWBleDemo
//
//  Created by bobobo on 2023/6/21.
//  Copyright © 2023 wosmart. All rights reserved.
//

#import "SyncAutomaticMonitoringTableViewCell.h"

@interface SyncAutomaticMonitoringTableViewCell ()


@end

@implementation SyncAutomaticMonitoringTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setFunctionModel:(WFJWDeviceFunctionModel *)functionModel {
    _functionModel = functionModel;
    
    __weak __typeof(self)weakSelf = self;
    if (functionModel.functionType == WFDeviceFunctionType_BloodPressure) {
        self.titleLB.text = NSLocalizedString(@"血压", nil);
        
        if ([JWBleAction jwCheckFunctionStates:JWBleFunctionEnum_BloodPressureV2] != JWBleFunctionStateEnum_NotSupport) {
            [JWBleAction jwBPV2Action:true open:false callBack:^(JWBleCommunicationStatus status, BOOL open) {
               if (status == JWBleCommunicationStatus_Success) {
                   weakSelf.switchView.on = open;
               }
            }];
        } else if ([JWBleAction jwCheckFunctionStates:JWBleFunctionEnum_DeviceBPMonitoring] != JWBleFunctionStateEnum_NotSupport) {
            [JWBleAction jwBPAutomaticDetectionAction_V3:true open:self.switchView.on timeSpan:10 callBack:^(JWBleCommunicationStatus status, BOOL open, int timeSpan) {
                if (status == JWBleCommunicationStatus_Success) {
                    weakSelf.switchView.on = open;
                }
            }];
        }
        
    } else if (functionModel.functionType == WFDeviceFunctionType_LookUpACellPhone) {
        self.titleLB.text = NSLocalizedString(@"查找手机", nil);

        self.switchView.on = [JWBleAction jwCheckHideFunctionStates:JWBleFunctionEnum_FindPhone] == JWBleHideFunctionStatesEnum_Show;
    } else if (functionModel.functionType == WFDeviceFunctionType_VoiceAssistant) {
        self.titleLB.text = NSLocalizedString(@"语音助手", nil);
        
        self.switchView.on = [JWBleAction jwCheckHideFunctionStates:JWBleFunctionEnum_VoiceAssistant] == JWBleHideFunctionStatesEnum_Show;
    } else if (functionModel.functionType == WFDeviceFunctionType_Oxygen) {
        self.titleLB.text = NSLocalizedString(@"血氧", nil);
        
        [JWBleAction jwContinuousBloodOxygenAction:true open:false callBack:^(JWBleCommunicationStatus status, BOOL open) {
            if (status == JWBleCommunicationStatus_Success) {
                weakSelf.switchView.on = open;
            }
        }];
    } else if (functionModel.functionType == WFDeviceFunctionType_AutomaticHeartRateMonitoring) {
        self.titleLB.text = NSLocalizedString(@"心率", nil);
        
        [JWBleAction jwHrAutomaticDetectionAction:true open:false timeSpan:false callBack:^(JWBleCommunicationStatus status, BOOL open, int timeSpan) {
            if (status == JWBleCommunicationStatus_Success) {
                weakSelf.switchView.on = open;
            }
        }];
    } else if (functionModel.functionType == WFDeviceFunctionType_TwoButtonSliding) {
        self.titleLB.text = NSLocalizedString(@"双按键滑动", nil);
        
        self.switchView.on = [JWBleAction jwCheckHideFunctionStates:JWBleFunctionEnum_TwoButtonSliding] == JWBleHideFunctionStatesEnum_Show;
    } else if (functionModel.functionType == WFDeviceFunctionType_Temperature) {
        self.titleLB.text = NSLocalizedString(@"温度", nil);
        
        [JWBleAction jwTemperatureSwitchAction:true unit:0 compensate:0 monitor:0 callBack:^(JWBleCommunicationStatus status, BOOL unit, BOOL compensate, BOOL monitor) {
            if (status == JWBleCommunicationStatus_Success) {
                weakSelf.switchView.on = monitor;
            }
        }];
    } else if (functionModel.functionType == WFDeviceFunctionType_BloodGlucose) {
        self.titleLB.text = NSLocalizedString(@"血糖", nil);
        
        [JWBleAction jwContinuousBloodGlucoseAction:true open:false callBack:^(JWBleCommunicationStatus status, BOOL open) {
            if (status == JWBleCommunicationStatus_Success) {
                weakSelf.switchView.on = open;
            }
        }];
    } else if (functionModel.functionType == WFDeviceFunctionType_SleepAllDay) {
        self.titleLB.text = NSLocalizedString(@"全天睡眠", nil);
        
        [JWBleAction jwSleepAllDayAction:true open:false callBack:^(JWBleCommunicationStatus status, BOOL open) {
            if (status == JWBleCommunicationStatus_Success) {
                weakSelf.switchView.on = open;
            }
        }];
    } else if (functionModel.functionType == WFDeviceFunctionType_LowOxygenReminder) {
        self.titleLB.text = NSLocalizedString(@"低氧提醒", nil);
        
        [JWBleAction jwLowOxygenReminderAction:true open:false callBack:^(JWBleCommunicationStatus status, BOOL open) {
            if (status == JWBleCommunicationStatus_Success) {
                weakSelf.switchView.on = open;
            }
        }];
    }
    
}

- (IBAction)switchValueChanged:(id)sender {
    WFJWDeviceFunctionModel *functionModel = self.functionModel;
    
    __weak __typeof(self)weakSelf = self;
    if (functionModel.functionType == WFDeviceFunctionType_BloodPressure) {
        if ([JWBleAction jwCheckFunctionStates:JWBleFunctionEnum_BloodPressureV2] != JWBleFunctionStateEnum_NotSupport) {
            [JWBleAction jwBPV2Action:false open:self.switchView.on callBack:^(JWBleCommunicationStatus status, BOOL open) {
            }];
        } else if ([JWBleAction jwCheckFunctionStates:JWBleFunctionEnum_DeviceBPMonitoring] != JWBleFunctionStateEnum_NotSupport) {
            [JWBleAction jwBPAutomaticDetectionAction_V3:false open:self.switchView.on timeSpan:10 callBack:^(JWBleCommunicationStatus status, BOOL open, int timeSpan) {
                if (status == JWBleCommunicationStatus_Success) {
                    weakSelf.switchView.on = open;
                }
            }];
        }
        
    } else if (functionModel.functionType == WFDeviceFunctionType_LookUpACellPhone) {
        self.switchView.on = [JWBleAction jwCheckHideFunctionStates:JWBleFunctionEnum_FindPhone] == JWBleHideFunctionStatesEnum_Show;
    } else if (functionModel.functionType == WFDeviceFunctionType_VoiceAssistant) {
        self.switchView.on = [JWBleAction jwCheckHideFunctionStates:JWBleFunctionEnum_VoiceAssistant] == JWBleHideFunctionStatesEnum_Show;
    } else if (functionModel.functionType == WFDeviceFunctionType_Oxygen) {
        [JWBleAction jwContinuousBloodOxygenAction:false open:self.switchView.on callBack:^(JWBleCommunicationStatus status, BOOL open) {
        }];
    } else if (functionModel.functionType == WFDeviceFunctionType_AutomaticHeartRateMonitoring) {
        int timeSpan = 1;//continue 1 minute
        if (functionModel.subArr && functionModel.subArr.count > 0) {
            // you can use subArr
            WFJWDeviceFunctionModel *sub = functionModel.subArr[0];
            timeSpan = sub.functionType;
        }
        [JWBleAction jwHrAutomaticDetectionAction:false open:self.switchView.on timeSpan:timeSpan callBack:^(JWBleCommunicationStatus status, BOOL open, int timeSpan) {
        }];
    } else if (functionModel.functionType == WFDeviceFunctionType_TwoButtonSliding) {
        self.switchView.on = [JWBleAction jwCheckHideFunctionStates:JWBleFunctionEnum_TwoButtonSliding] == JWBleHideFunctionStatesEnum_Show;
    } else if (functionModel.functionType == WFDeviceFunctionType_Temperature) {
        [JWBleAction jwTemperatureSwitchAction:false unit:0 compensate:0 monitor:self.switchView.on callBack:^(JWBleCommunicationStatus status, BOOL unit, BOOL compensate, BOOL monitor) {
        }];
    } else if (functionModel.functionType == WFDeviceFunctionType_BloodGlucose) {
        [JWBleAction jwContinuousBloodGlucoseAction:false open:self.switchView.on callBack:^(JWBleCommunicationStatus status, BOOL open) {
        }];
    } else if (functionModel.functionType == WFDeviceFunctionType_SleepAllDay) {
        [JWBleAction jwSleepAllDayAction:false open:self.switchView.on callBack:^(JWBleCommunicationStatus status, BOOL open) {
        }];
    } else if (functionModel.functionType == WFDeviceFunctionType_LowOxygenReminder) {
        [JWBleAction jwLowOxygenReminderAction:false open:self.switchView.on callBack:^(JWBleCommunicationStatus status, BOOL open) {
        }];
    }
    
}

@end
