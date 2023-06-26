//
//  WFJWDeviceFunctionModel.h
//  WoFit
//
//  Created by Bo 黄 on 2019/5/7.
//  Copyright © 2019 bo huang. All rights reserved.
//

#import <Foundation/Foundation.h>


//功能枚举
typedef NS_ENUM(NSInteger, WFDeviceFunctionType) {
    WFDeviceFunctionType_BloodPressure,//血压
    WFDeviceFunctionType_LookUpACellPhone,//查找手机
    WFDeviceFunctionType_VoiceAssistant,//语音助手
    WFDeviceFunctionType_Oxygen,//血氧
    WFDeviceFunctionType_AutomaticHeartRateMonitoring,//心率自动监测,具有时间间隔的
    WFDeviceFunctionType_TwoButtonSliding,//双按键滑动
    WFDeviceFunctionType_Temperature,//温度
    WFDeviceFunctionType_BloodGlucose,//血糖
    WFDeviceFunctionType_SleepAllDay,// 全天睡眠
    WFDeviceFunctionType_LowOxygenReminder,//低氧提醒
};

@interface WFJWDeviceFunctionModel : NSObject

@property(nonatomic, assign) BOOL showSubArr;
@property(nonatomic, strong) NSArray *subArr;
@property(nonatomic, assign) WFDeviceFunctionType functionType;
@property(nonatomic, strong) NSString *functionName;
@property(nonatomic, strong) NSString *functionDesc;

+ (NSArray *)getArrWithDeviceResult:(NSDictionary *)deviceResult;

@end
