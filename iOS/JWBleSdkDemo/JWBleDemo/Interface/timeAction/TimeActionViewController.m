//
//  TimeActionViewController.m
//  JWBleDemo
//
//  Created by Bo 黄 on 2019/8/6.
//  Copyright © 2019 wosmart. All rights reserved.
//

#import "TimeActionViewController.h"

@interface TimeActionViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segMent;

@end

@implementation TimeActionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLocale *locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_GB"];
    self.datePicker.locale = locale;
    
    [self.datePicker setCalendar:[NSCalendar currentCalendar]];
}

- (IBAction)segmentChange:(id)sender {
    NSLocale *locale = self.segMent.selectedSegmentIndex == 0 ? [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"] : [[NSLocale alloc]initWithLocaleIdentifier:@"en_GB"];
    self.datePicker.locale = locale;
}

- (IBAction)clickGetDeviceInfo:(id)sender {
    
}

- (IBAction)clickSetBtn:(id)sender {
//    [JWBleAction ];
}



@end
