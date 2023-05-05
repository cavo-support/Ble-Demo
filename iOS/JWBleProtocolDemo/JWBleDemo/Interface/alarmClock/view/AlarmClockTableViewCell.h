//
//  AlarmClockTableViewCell.h
//  CoreBluetoothDemo
//
//  Created by Bo 黄 on 2019/3/6.
//  Copyright © 2019 Jone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DemoAlarmClockModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^AlarmClockCellValueChangedBlock)(void);

@interface AlarmClockTableViewCell : UITableViewCell

@property(nonatomic, strong) DemoAlarmClockModel *clockModel;

@property(nonatomic, copy) AlarmClockCellValueChangedBlock changedBlock;

@end

NS_ASSUME_NONNULL_END
