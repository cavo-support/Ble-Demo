//
//  AlarmClockAddViewController.h
//  CoreBluetoothDemo
//
//  Created by Bo 黄 on 2019/3/5.
//  Copyright © 2019 Jone. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AlarmClockAddViewController : UIViewController

@property(nonatomic, assign) BOOL isClock;
@property(nonatomic, assign) int nextIdd;//next alarm id
@property(nonatomic, strong) JWBleAlarmClockModel *clockModel_v2;

@end

NS_ASSUME_NONNULL_END
