//
//  SyncTimeViewController.m
//  JWBleDemo
//
//  Created by bobobo on 2023/6/21.
//  Copyright © 2023 wosmart. All rights reserved.
//

#import "SyncTimeViewController.h"

@interface SyncTimeViewController ()

@property (nonatomic, strong) NSDateComponents *dateComponent;
@property (weak, nonatomic) IBOutlet UILabel *timeLB;

@end

@implementation SyncTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"同步时间", nil);
    
    //sdk，已经在连接设备时，设置手机当前时间给设备，该方法 如改变了设备时间，可能会导致 设备数据错乱。请慎重使用
    
    //获取当前时间
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    self.dateComponent = [calendar components:unitFlags fromDate:now];
    
    self.timeLB.text = [NSString stringWithFormat:@"time: %d-%02d-%02d %02d:%02d",
                            [self.dateComponent year],
                            [self.dateComponent month],
                            [self.dateComponent day],
                            [self.dateComponent hour],
                            [self.dateComponent minute],
                            [self.dateComponent second]
    ];
    
    
}

- (IBAction)clickSyncBtn:(id)sender {
    
    __weak __typeof(self)weakSelf = self;
    [JWBleAction jwSetTimeWithYear:[self.dateComponent year] - 2000
                          andMonth:[self.dateComponent month]
                            andDay:[self.dateComponent day]
                           andHour:[self.dateComponent hour]
                         andMinute:[self.dateComponent minute]
                         andSecond:[self.dateComponent second] callBack:^(JWBleCommunicationStatus status) {
        [weakSelf.view makeToast:NSLocalizedString(@"sync success", nil)];
    }];
}

@end
