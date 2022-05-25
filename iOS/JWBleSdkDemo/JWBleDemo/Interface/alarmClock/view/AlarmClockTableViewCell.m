//
//  AlarmClockTableViewCell.m
//  CoreBluetoothDemo
//
//  Created by Bo 黄 on 2019/3/6.
//  Copyright © 2019 Jone. All rights reserved.
//

#import "AlarmClockTableViewCell.h"

@interface AlarmClockTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *topLB;
@property (weak, nonatomic) IBOutlet UILabel *eventDescLB;
@property (weak, nonatomic) IBOutlet UISwitch *openSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *repatSwitch;
@property (weak, nonatomic) IBOutlet UILabel *repeatWeekLB;

@end

@implementation AlarmClockTableViewCell

- (void)setClockModel:(DemoAlarmClockModel *)clockModel {
    _clockModel = clockModel;
    
    NSString *typeStr = clockModel.clockType == 0 ? NSLocalizedString(@"Alarm clock", nil) : NSLocalizedString(@"event", nil);
    NSString *timeStr = [NSString timeFromTimestamp:clockModel.utcTime formtter:@"yyyy-MM-dd HH:mm"];
    self.topLB.text = [NSString stringWithFormat:@"%@：%@ \t %@:%@",NSLocalizedString(@"Types of", nil),typeStr, NSLocalizedString(@"time", nil),timeStr];
    
    self.eventDescLB.text = [NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"Event content", nil),clockModel.eventDesc];
    
    self.openSwitch.on = clockModel.isOpen;
    self.repatSwitch.on = clockModel.repeat;
    
    NSString *repeatStr = @"";
    NSArray *strArr = @[@"7",@"1",@"2",@"3",@"4",@"5",@"6"];
    for (int i = 0; i < clockModel.repeatWeekArr.count; i++) {
        bool repeat = [clockModel.repeatWeekArr[i] boolValue];
        if (repeat) {
            repeatStr = [NSString stringWithFormat:@"%@ %@",repeatStr,strArr[i]];
        }
    }
    self.repeatWeekLB.text = repeatStr;

}

- (IBAction)switchValueChanged:(UISwitch *)sender {
    if (sender.tag == 20000) {
        self.clockModel.isOpen = sender.on;
    } else {
        self.clockModel.repeat = sender.on;
    }
    [self.clockModel update];
    
    if (self.changedBlock) {
        self.changedBlock();
    }
}

@end
