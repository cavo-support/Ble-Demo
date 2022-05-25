//
//  DemoAlarmClockModel.m
//  CoreBluetoothDemo
//
//  Created by Bo 黄 on 2019/3/6.
//  Copyright © 2019 Jone. All rights reserved.
//

#import "DemoAlarmClockModel.h"
#import "JWBleDemoHelp.h"

@implementation DemoAlarmClockModel

#pragma mark - db
/** 如果子类中有一些property不需要创建数据库字段，那么这个方法必须在子类中重写 */
+ (NSArray *)transients {
    return @[@"repeatWeekArr"];
}

#pragma mark - getter
- (NSArray *)repeatWeekArr {
    if (!_repeatWeekArr && self.repeatWeekArrStr) {
        _repeatWeekArr = [JWBleDemoHelp toArrayOrNSDictionary:[self.repeatWeekArrStr dataUsingEncoding:NSUTF8StringEncoding]];
    }
    return _repeatWeekArr;
}

- (NSString *)repeatWeekArrStr {
    if (!_repeatWeekArrStr || [_repeatWeekArrStr isEmpty]) {
        _repeatWeekArrStr = [[NSString alloc] initWithData:[JWBleDemoHelp toJSONData:_repeatWeekArr] encoding:NSUTF8StringEncoding];
    }
    return _repeatWeekArrStr;
}

#pragma mark - static
+ (NSArray<JWBleAlarmClockModel *> *)converstion2DeviceAlarmClock:(NSArray<DemoAlarmClockModel *> *)clockArr {
    NSMutableArray *resultArr = [NSMutableArray new];
//    for (DemoAlarmClockModel *demoModel in clockArr) {
//        JWBleAlarmClockModel *jwModel = [JWBleAlarmClockModel new];
//
//        jwModel.isOpen = demoModel.isOpen;
//        jwModel.repeat = demoModel.repeat;
//        jwModel.repeatWeekArr = demoModel.repeatWeekArr;
//        jwModel.clockType = demoModel.clockType;
//        jwModel.eventDesc = demoModel.eventDesc;
//        jwModel.utcTime = demoModel.utcTime;
//        jwModel.timeZone = demoModel.timeZone;
//
//        [resultArr addObject:jwModel];
//    }
    return [resultArr mutableCopy];;
}

+ (void)setDeviceAlarmClock:(NSArray<DemoAlarmClockModel *> *)clockArr callBack:(JWBleCommunicationCallBack)callBack {
    NSArray *jwModelArr = [self converstion2DeviceAlarmClock:clockArr];
    
    [JWBleAction jwAlarmAction:false alarmArr:jwModelArr callBack:^(JWBleCommunicationStatus status, NSArray<JWBleAlarmClockModel *> *alarmArr) {
        if (callBack) {
            callBack(status);
        }
    }];
}

+ (void)saveAndSynchronize:(DemoAlarmClockModel *)clockModel callBack:(JWBleCommunicationCallBack)callBack {
    if ([clockModel saveOrUpdate]) {
        NSArray *allDBModel = [self findAll];
        [self setDeviceAlarmClock:allDBModel callBack:callBack];
    }
}

+ (void)synchronization2DeviceWithCallBack:(JWBleCommunicationCallBack)callBack {
    NSArray *demoModelArr = [DemoAlarmClockModel findAll];
    
    [self setDeviceAlarmClock:demoModelArr callBack:callBack];
}

@end
