//
//  WFJWDeviceFunctionModel.m
//  WoFit
//
//  Created by Bo 黄 on 2019/5/7.
//  Copyright © 2019 bo huang. All rights reserved.
//

#import "WFJWDeviceFunctionModel.h"

@implementation WFJWDeviceFunctionModel : NSObject

+ (NSArray *)getArrWithDeviceResult:(NSDictionary *)deviceResult {
    
    WFJWDeviceFunctionModel *model2 = [WFJWDeviceFunctionModel new];
    model2.functionType = WFDeviceFunctionType_AutomaticHeartRateMonitoring;
    model2.functionName = NSLocalizedString(@"心率自动检测", nil);
//    #ifdef DeepFit
//        model2.showSubArr = true;
//    #endif
    {
        NSMutableArray *subArr = [[NSMutableArray alloc] initWithCapacity:0];
        if ([[deviceResult objectForKey:@"0"] boolValue]) {
            WFJWDeviceFunctionModel *sub1 = [WFJWDeviceFunctionModel new];
            sub1.functionName = NSLocalizedString(@"连续", nil);
            sub1.functionType = 1;
            [subArr addObject:sub1];
        }
        
        if ([[deviceResult objectForKey:@"5"] boolValue]) {
            WFJWDeviceFunctionModel *sub2 = [WFJWDeviceFunctionModel new];
            sub2.functionName = [NSString stringWithFormat:@"span : %dminute", 5];
            sub2.functionType = 5;
            [subArr addObject:sub2];
        }
        
        if ([[deviceResult objectForKey:@"10"] boolValue]) {
            WFJWDeviceFunctionModel *sub2 = [WFJWDeviceFunctionModel new];
            sub2.functionName = [NSString stringWithFormat:@"span : %dminute", 10];
            sub2.functionType = 10;
            [subArr addObject:sub2];
        }
        
        if ([[deviceResult objectForKey:@"30"] boolValue]) {
            WFJWDeviceFunctionModel *sub2 = [WFJWDeviceFunctionModel new];
            sub2.functionName = [NSString stringWithFormat:@"span : %dminute", 30];
            sub2.functionType = 30;
            [subArr addObject:sub2];
        }
        
        if ([[deviceResult objectForKey:@"60"] boolValue]) {
            WFJWDeviceFunctionModel *sub2 = [WFJWDeviceFunctionModel new];
            sub2.functionName = [NSString stringWithFormat:@"span : %dminute", 60];
            sub2.functionType = 60;
            [subArr addObject:sub2];
        }
        
        if ([[deviceResult objectForKey:@"120"] boolValue]) {
            WFJWDeviceFunctionModel *sub2 = [WFJWDeviceFunctionModel new];
            sub2.functionName = [NSString stringWithFormat:@"span : %dminute", 120];
            sub2.functionType = 120;
            [subArr addObject:sub2];
        }
        
        //如果只有连续心率，那么就不显示下级
        BOOL showSubArr = true;
        if (subArr.count == 1) {
            WFJWDeviceFunctionModel *sub1 = (WFJWDeviceFunctionModel *)subArr.firstObject;
            if (sub1.functionType == 1) {
                showSubArr = false;
            }
        }
        
        if (showSubArr) {
            model2.subArr = [subArr mutableCopy];
        }
        
    }
    
    WFJWDeviceFunctionModel *model3;
    if ([JWBleAction jwCheckHideFunctionStates:JWBleFunctionEnum_TwoButtonSliding] != JWBleHideFunctionStatesEnum_NotSupport) {
        model3 = [WFJWDeviceFunctionModel new];
        model3.functionType = WFDeviceFunctionType_TwoButtonSliding;
        model3.functionName = NSLocalizedString(@"滑动翻页", nil);
    }
    
    WFJWDeviceFunctionModel *model4;
    if ([JWBleAction jwCheckHideFunctionStates:JWBleFunctionEnum_FindPhone] != JWBleHideFunctionStatesEnum_NotSupport) {
        model4 = [WFJWDeviceFunctionModel new];
        model4.functionType = WFDeviceFunctionType_LookUpACellPhone;
        model4.functionName = NSLocalizedString(@"查找手机", nil);
    }
    
    WFJWDeviceFunctionModel *model6;
    if ([JWBleAction jwCheckFunctionStates:JWBleFunctionEnum_BloodPressureV2] != JWBleFunctionStateEnum_NotSupport || [JWBleAction jwCheckFunctionStates:JWBleFunctionEnum_DeviceBPMonitoring] != JWBleFunctionStateEnum_NotSupport) {
        model6 = [WFJWDeviceFunctionModel new];
        model6.functionType = WFDeviceFunctionType_BloodPressure;
        model6.functionName = NSLocalizedString(@"血压自动检测", nil);
    }
    
    WFJWDeviceFunctionModel *model5;
    if ([JWBleAction jwCheckFunctionStates:JWBleFunctionEnum_Temperature] != JWBleFunctionStateEnum_NotSupport) {
        model5 = [WFJWDeviceFunctionModel new];
        model5.functionType = WFDeviceFunctionType_Temperature;
        model5.functionName = NSLocalizedString(@"温度自动检测", nil);
    }
     
    WFJWDeviceFunctionModel *model7;
    NSData *data = JWBleManager.connectionModel.hideFunctionMenu;
    if ([JWBleAction jwCheckHideFunctionStates:JWBleFunctionEnum_VoiceAssistant] != JWBleHideFunctionStatesEnum_NotSupport) {
        model7 = [WFJWDeviceFunctionModel new];
        model7.functionType = WFDeviceFunctionType_VoiceAssistant;
        model7.functionName = NSLocalizedString(@"语音助手", nil);
    }
    
    WFJWDeviceFunctionModel *model8;
    if ([JWBleAction jwCheckFunctionStates:JWBleFunctionEnum_ContinuousBloodOxygen] != JWBleFunctionStateEnum_NotSupport) {
        model8 = [WFJWDeviceFunctionModel new];
        model8.functionType = WFDeviceFunctionType_Oxygen;
        model8.functionName = NSLocalizedString(@"血氧自动检测", nil);
    }
    
    WFJWDeviceFunctionModel *model9;
    if ([JWBleAction jwCheckFunctionStates:JWBleFunctionEnum_BloodGlucose] != JWBleFunctionStateEnum_NotSupport) {
        model9 = [WFJWDeviceFunctionModel new];
        model9.functionType = WFDeviceFunctionType_BloodGlucose;
        model9.functionName = NSLocalizedString(@"血糖自动检测", nil);
    }
    
    WFJWDeviceFunctionModel *model10;
    if ([JWBleAction jwCheckFunctionStates:JWBleFunctionEnum_LowOxygenReminder] != JWBleFunctionStateEnum_NotSupport) {
        model10 = [WFJWDeviceFunctionModel new];
        model10.functionType = WFDeviceFunctionType_LowOxygenReminder;
        model10.functionName = NSLocalizedString(@"低氧提醒", nil);
    }
    
    WFJWDeviceFunctionModel *model11;
    if ([JWBleAction jwCheckFunctionStates:JWBleFunctionEnum_SleepAllDay] != JWBleFunctionStateEnum_NotSupport) {
        model11 = [WFJWDeviceFunctionModel new];
        model11.functionType = WFDeviceFunctionType_SleepAllDay;
        model11.functionName = NSLocalizedString(@"全天睡眠", nil);
    }
    
     
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:0];
    [result addObject:model2];
    
    if (model4) {
        [result addObject:model4];
    }
    
    if (model8) {
        [result addObject:model8];
    }
    
    if (model10) {
        [result addObject:model10];
    }
    
    if (model6) {
        [result addObject:model6];
    }
    
    if (model5) {
        [result addObject:model5];
    }
    
    if (model7) {
        [result addObject:model7];
    }
    
    if (model9) {
        [result addObject:model9];
    }
    
    if (model11) {
        [result addObject:model11];
    }
    
    if (model3) {
        [result addObject:model3];
    }
    
    
    return [result mutableCopy];
    
}

@end
