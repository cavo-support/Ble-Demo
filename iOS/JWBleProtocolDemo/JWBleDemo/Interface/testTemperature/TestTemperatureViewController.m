//
//  TestTemperatureViewController.m
//  JWBleDemo
//
//  Created by Bo 黄 on 2020/7/10.
//  Copyright © 2020 wosmart. All rights reserved.
//

#import "TestTemperatureViewController.h"

@interface TestTemperatureViewController ()

@property (weak, nonatomic) IBOutlet UILabel *lb;

@end

@implementation TestTemperatureViewController

#pragma mark - warning
/**
 温度操作需要注意事项
    1.  温度与心率紧密关联，如心率自动检测不打开，将无法使用温度功能；
    2.  使用温度功能前，需要判断是否有温度功能；
    3.  为了防止手环重置、app与手环解绑，导致之前设置的开关状态消失，从而获取不到数据。app每次连接手环成功，需要将相对应开关重新设置一次
    4. 测试温度前，需要先开启温度功能；
 
 Matters needing attention in temperature operation
 1. Temperature is closely related to heart rate. If the automatic heart rate detection is not turned on, the temperature function will not be available;
 2. Before using the temperature function, you need to judge whether there is a temperature function;
 3. In order to prevent the reset of the bracelet and the unbinding of the app and the bracelet, the previously set switch state disappears, and no data can be obtained. Every time the app connects to the bracelet successfully, you need to reset the corresponding switch
 4. Before testing the temperature, you need to turn on the temperature function;
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Temperature correlation", nil);
    self.view.backgroundColor = [UIColor whiteColor];
    
    __weak __typeof(self)weakSelf = self;
    JWBleManager.realTimeTemperatureCallBack = ^(float value, BOOL gradientStatus, BOOL wearingState, BOOL compensationStatus) {
        weakSelf.lb.text = [NSString stringWithFormat:@"%@:%.1f",NSLocalizedString(@"temperature", nil),value];
    };
    JWBleManager.realTimeTemperatureCallBack = ^(float value, BOOL gradientStatus, BOOL wearingState, BOOL compensationStatus) {
        weakSelf.lb.text = [NSString stringWithFormat:@"%@:%.1f",NSLocalizedString(@"temperature", nil),value];
    };
    
    [self getDeviceTemperatureStatus];
}

- (void)getDeviceTemperatureStatus {
    [JWBleAction jwTemperatureSwitchAction:true unit:false compensate:false monitor:false callBack:^(JWBleCommunicationStatus status, BOOL unit, BOOL compensate, BOOL monitor) {
        if (status == JWBleCommunicationStatus_Success) {
            NSLog(@"..log");
        }
    }];
}

#pragma mark - button actions
- (IBAction)clickStartBtn:(id)sender {
    __weak __typeof(self)weakSelf = self;
    [JWBleAction jwCheckDeviceBusyWithCallBack:^(JWBleCommunicationStatus status, JWBleBusyStateEnum jWBleBusyStateEnum) {
        if (jWBleBusyStateEnum == JWBleBusyStateEnum_Idle) {
            [JWBleAction jwTestTemperatureAction:2 callBack:^(JWBleCommunicationStatus status, JWBleTestTemperatureStatus testStatus) {
                if (testStatus == JWBleTestTemperatureStatus_Open) {
                    [JWBleAction jwTestTemperatureAction:1 callBack:^(JWBleCommunicationStatus status, JWBleTestTemperatureStatus testStatus) {
                        if (status == JWBleCommunicationStatus_Success) {
                            //do...
                        }
                    }];
                } else {
                    [weakSelf.view makeToast:NSLocalizedString(@"The continuous heart rate of the device is not turned on and the temperature cannot be measured", nil)];
                }
            }];
        } else {
            [weakSelf.view makeToast:NSLocalizedString(@"Bracelet busy", nil)];
        }
    }];
}

- (IBAction)clickStopBtn:(id)sender {
    [JWBleAction jwTestTemperatureAction:0 callBack:^(JWBleCommunicationStatus status, JWBleTestTemperatureStatus testStatus) {
        if (status == JWBleCommunicationStatus_Success) {
            //do...
        }
    }];
}

- (IBAction)clickOpenBtn:(id)sender {
    __weak __typeof(self)weakSelf = self;
    [JWBleAction jwHrAutomaticDetectionAction:true open:false timeSpan:0 callBack:^(JWBleCommunicationStatus status, BOOL open, int timeSpan) {
        if (status == JWBleCommunicationStatus_Success) {
            if (open == false) {
                [weakSelf.view makeToast:NSLocalizedString(@"The continuous heart rate of the device is not turned on and the temperature cannot be measured", nil)];
            } else {
                [JWBleAction jwTemperatureSwitchAction:false unit:true compensate:true monitor:true callBack:^(JWBleCommunicationStatus status, BOOL unit, BOOL compensate, BOOL monitor) {
                    if (status == JWBleCommunicationStatus_Success) {
                        //do...
                    }
                }];
            }
        }
    }];
}

- (IBAction)clickCloseBtn:(id)sender {
    //忽略检查功能等方法..
    //Ignore checking functions and other methods...
    [JWBleAction jwTemperatureSwitchAction:false unit:false compensate:false monitor:false callBack:^(JWBleCommunicationStatus status, BOOL unit, BOOL compensate, BOOL monitor) {
        if (status == JWBleCommunicationStatus_Success) {
            //do...
        }
    }];
}

- (IBAction)clickGetBtn:(id)sender {
    NSString *dayStr = @"2020-07-21";
    [JWBleDataAction jwGetTemperatureDataByYYYYMMDDStr:dayStr callBack:^(NSArray *dataArr) {
        if (dataArr.count > 0) {
            NSLog(@"%@",dataArr);
        }
    }];
}

#pragma mark - help
/**
 补偿算法  Compensation algorithm
 */
- (CGFloat)fittingTemperature:(CGFloat)temperature wearingState:(BOOL)wearingState compensationStatus:(BOOL)compensationStatus {
    
    if (wearingState == false) {
        return 0;
    }

    if (compensationStatus) {
        CGFloat value = temperature*10;
        if (value >= 368) {
            return temperature;
        } else {
            value = 368 - (368 - value) / 20;
            return value/10.0;
        }
    }
    return temperature;
}

/**
 摄氏度华氏度转换 Celsius Fahrenheit Conversion
 */
- (CGFloat)converstionCentigradeOrFahrenheit:(CGFloat)centigrade {
    NSString *str = [NSString stringWithFormat:@"%.4f",(centigrade * 18) / 10 + 32];
    NSArray *arr = [str componentsSeparatedByString:@"."];
    NSInteger intValue = [arr.firstObject integerValue];
    NSInteger floatValue = [[arr.lastObject substringWithRange:NSMakeRange(0, 1)] integerValue];
    return intValue + floatValue / 10.0;
}

@end
