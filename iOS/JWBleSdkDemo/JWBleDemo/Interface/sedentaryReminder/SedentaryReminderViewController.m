//
//  SedentaryReminderViewController.m
//  CoreBluetoothDemo
//
//  Created by Bo 黄 on 2019/3/11.
//  Copyright © 2019 Jone. All rights reserved.
//

#import "SedentaryReminderViewController.h"

@interface SedentaryReminderViewController ()

@property (weak, nonatomic) IBOutlet UITextField *shTextField;
@property (weak, nonatomic) IBOutlet UITextField *ehTextField;
@property (weak, nonatomic) IBOutlet UITextField *spanTextField;
@property (weak, nonatomic) IBOutlet UISwitch *openSwitch;

@end

@implementation SedentaryReminderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Sedentary reminder", nil);
    
    [MBProgressHUD showHUDAddedTo:self.view animated:true];
    __weak __typeof(self)weakSelf = self;
    [JWBleAction jwSedentaryReminder:true open:false startH:0 endH:0 span:0 threshold:0 dayFlagArr:0 callBack:^(JWBleCommunicationStatus status, BOOL open, int startH, int endH, int span, int threshold, NSArray *dayFlagArr) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:true];
        [weakSelf.view makeToast:[JWBleDemoHelp communication2Str:status]];
        if (status == JWBleCommunicationStatus_Success) {
            weakSelf.openSwitch.on = open;
            
            weakSelf.shTextField.text = [NSString stringWithFormat:@"%d",startH];
            weakSelf.ehTextField.text = [NSString stringWithFormat:@"%d",endH];
            weakSelf.spanTextField.text = [NSString stringWithFormat:@"%d",span];
            
            [weakSelf updateWeekBtn:dayFlagArr];
        }
    }];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:true];
}

- (void)updateWeekBtn:(NSArray *)reserve {
    for (int i = 0; i < 7; i++) {
        UIButton *btn = [self.view viewWithTag:10000+i];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    }
    
    if (reserve.count == 7) {
        for (int i = 0; i < 7; i++) {
            UIButton *btn = [self.view viewWithTag:10000+i];
            btn.selected = [reserve[i] boolValue];
        }
    }
}

- (IBAction)clickWeekBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
}

- (IBAction)clickSetBtn:(id)sender {
    
    NSMutableArray *reserveArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < 7; i++) {
        UIButton *btn = [self.view viewWithTag:10000+i];
        [reserveArr addObject:@(btn.selected)];
    }
    
    [self.view makeToastActivity:self];
    __weak __typeof(self)weakSelf = self;
    
    [JWBleAction jwSedentaryReminder:false
                    open:self.openSwitch.on
                  startH:self.shTextField.text.intValue
                    endH:self.ehTextField.text.intValue
                    span:self.spanTextField.text.intValue
               threshold:30// fix 30
              dayFlagArr:reserveArr
                callBack:^(JWBleCommunicationStatus status, BOOL open, int startH, int endH, int span, int threshold, NSArray *dayFlagArr) {
        [weakSelf.view hideToastActivity];
        [weakSelf.view makeToast:[JWBleDemoHelp communication2Str:status]];
    }];
    
}


@end
