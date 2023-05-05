//
//  AlarmClockAddViewController.m
//  CoreBluetoothDemo
//
//  Created by Bo 黄 on 2019/3/5.
//  Copyright © 2019 Jone. All rights reserved.
//

#import "AlarmClockAddViewController.h"
#import "DemoAlarmClockModel.h"

@interface AlarmClockAddViewController ()

@property (weak, nonatomic) IBOutlet UIView *eventView;
@property (weak, nonatomic) IBOutlet UITextField *eventTextField;
@property (weak, nonatomic) IBOutlet UISwitch *cycleSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *openSwitch;
@property (weak, nonatomic) IBOutlet UIDatePicker *dataPicker;
@property (weak, nonatomic) IBOutlet UIView *weekBGView;

@end

@implementation AlarmClockAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNav];
    [self setUpView];
}

- (void)setUpNav {
    
    if (self.isClock) {
        self.title = NSLocalizedString(@"Add alarm", nil);
    } else {
        self.title = NSLocalizedString(@"Add event", nil);
    }
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [rightBtn setTitle:@"save" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(clickRightBtn) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)setUpView {
    self.dataPicker.datePickerMode = UIDatePickerModeDateAndTime;//模式选择
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中文
    self.dataPicker.calendar = [NSCalendar currentCalendar];
    self.dataPicker.locale = locale;
    
    self.eventView.hidden = self.isClock;
}

#pragma mark - action
- (void)clickRightBtn {
    DemoAlarmClockModel *clockModel = [DemoAlarmClockModel new];
    clockModel.isOpen = self.openSwitch.on;
    clockModel.repeat = self.cycleSwitch.on;
    clockModel.utcTime = self.dataPicker.date.timeIntervalSince1970;
    clockModel.clockType = !self.isClock;
    if (!self.isClock) {
        if (self.eventTextField.text.length > 10) {
            [self.view makeToast:NSLocalizedString(@"Event description up to ten words", nil)];
            return;
        }
        clockModel.eventDesc = self.eventTextField.text;
    }
    
    // 获取指定时区的缩写
    NSTimeZone *zone = [NSTimeZone localTimeZone];
    NSString *zoneAbbreviation1 = [zone abbreviation];
    int zoneInt = [[zoneAbbreviation1 substringWithRange: NSMakeRange(3, 2)] intValue];
    clockModel.timeZone = zoneInt;
    
    //循环数组
    if (self.cycleSwitch.on) {
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
        for (int i = 10000; i < 10007; i++) {
            UIButton *btn = [self.view viewWithTag:i];
            [arr addObject:@(btn.selected ? 1 : 0)];
        }
        clockModel.repeatWeekArr = [arr mutableCopy];
    }
    
    self.navigationItem.rightBarButtonItem.enabled = false;
    [self.view makeToastActivity:self];
    __weak __typeof(self)weakSelf = self;
    
    if ([JWBleAction jwCheckFunctionStates:JWBleFunctionEnum_SmartAlarmClockV2] == JWBleFunctionStateEnum_Open) {
        
        JWBleAlarmClockModel *sdkModel = [JWBleAlarmClockModel new];
        
        sdkModel.isOpen = false;
        sdkModel.idd = 1;
        sdkModel.year = 20;
        sdkModel.month = 10;
        sdkModel.day = 20;
        sdkModel.hour = 10;
        sdkModel.minute = 30;
        sdkModel.repeatWeekArr = clockModel.repeatWeekArr;
        sdkModel.content = @"good";
        
        [JWBleAction jwAlarmV2Action:false alarmModel:sdkModel callBack:^(JWBleCommunicationStatus status, NSArray<JWBleAlarmClockModel *> *alarmArr) {
            NSLog(@"123123");
        }];
        
    } else {
        [DemoAlarmClockModel saveAndSynchronize:clockModel callBack:^(JWBleCommunicationStatus status) {
            weakSelf.navigationItem.rightBarButtonItem.enabled = true;
            [self.view hideToastActivity];
            if (status == JWBleCommunicationStatus_Success) {
                [self.view makeToast:NSLocalizedString(@"Set up successfully", nil)];
                [weakSelf.navigationController popViewControllerAnimated:true];
            } else {
                [self.view makeToast:NSLocalizedString(@"Setup failed", nil)];
            }
        }];
    }

}

- (IBAction)clickWeekBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
    for (int i = 10000; i < 10007; i++) {
        UIButton *btn = [self.view viewWithTag:i];
        btn.backgroundColor = btn.selected ? [UIColor greenColor] : [UIColor clearColor];
    }
}

- (IBAction)cycleSwitchChanged:(id)sender {
    self.weekBGView.hidden = !self.cycleSwitch.on;
}

@end
