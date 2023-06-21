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

- (void)setClockModel_v2:(JWBleAlarmClockModel *)clockModel_v2 {
    _clockModel_v2 = clockModel_v2;
    
    NSString *typeStr = NSLocalizedString(@"event", nil);
    NSString *timeStr = [NSString stringWithFormat:@"%d-%02d-%02d %02d:%02d",clockModel_v2.year+2000,clockModel_v2.month,clockModel_v2.day,clockModel_v2.hour,clockModel_v2.minute];
    self.topLB.text = [NSString stringWithFormat:@"%@：%@ \t %@:%@",NSLocalizedString(@"Types of", nil),typeStr, NSLocalizedString(@"time", nil),timeStr];
    
    self.eventDescLB.text = [NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"Event content", nil),clockModel_v2.content];
    
    self.openSwitch.on = clockModel_v2.isOpen;
    self.repatSwitch.hidden = true;
    
    NSString *repeatStr = @"";
    NSArray *strArr = @[@"7",@"1",@"2",@"3",@"4",@"5",@"6"];
    for (int i = 0; i < clockModel_v2.repeatWeekArr.count; i++) {
        bool repeat = [clockModel_v2.repeatWeekArr[i] boolValue];
        if (repeat) {
            repeatStr = [NSString stringWithFormat:@"%@ %@",repeatStr,strArr[i]];
        }
    }
    self.repeatWeekLB.text = repeatStr;
}

- (IBAction)switchValueChanged:(UISwitch *)sender {
    if (self.clockModel_v2) {
        if (sender.tag == 20000) {
            self.clockModel_v2.isOpen = sender.on;
        }
        
        if (self.changedBlock) {
            self.changedBlock();
        }
        return;
    }
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
