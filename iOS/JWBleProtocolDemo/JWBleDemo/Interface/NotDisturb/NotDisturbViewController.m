//
//  NotDisturbViewController.m
//  CoreBluetoothDemo
//
//  Created by Bo 黄 on 2019/3/11.
//  Copyright © 2019 Jone. All rights reserved.
//

#import "NotDisturbViewController.h"

@interface NotDisturbViewController ()

@property (weak, nonatomic) IBOutlet UISwitch *openSwitch;
@property (weak, nonatomic) IBOutlet UITextField *shField;
@property (weak, nonatomic) IBOutlet UITextField *smField;
@property (weak, nonatomic) IBOutlet UITextField *ehField;
@property (weak, nonatomic) IBOutlet UITextField *emField;

@property(nonatomic, strong) JWNotDisturbModel *model;

@end

@implementation NotDisturbViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Do not disturb mode", nil);
    
    [MBProgressHUD showHUDAddedTo:self.view animated:true];
    __weak __typeof(self)weakSelf = self;
    [JWBleAction jwNotDisturbAction:true model:nil callBack:^(JWBleCommunicationStatus status, JWNotDisturbModel *model) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:true];
        [weakSelf.view makeToast:[JWBleDemoHelp communication2Str:status]];
        if (status == JWBleCommunicationStatus_Success) {
            weakSelf.model = model;
        }
    }];
}

- (void)setModel:(JWNotDisturbModel *)model {
    _model = model;
    
    self.openSwitch.on = model.open;
    
    self.shField.text = [NSString stringWithFormat:@"%u",(unsigned int)model.startHour];
    self.smField.text = [NSString stringWithFormat:@"%u",(unsigned int)model.startMinute];
    self.ehField.text = [NSString stringWithFormat:@"%u",(unsigned int)model.endHour];
    self.emField.text = [NSString stringWithFormat:@"%u",(unsigned int)model.endMinute];
}

- (IBAction)clickSetBtn:(id)sender {
    
    self.model.open = self.openSwitch.on;
    self.model.startHour = self.shField.text.intValue;
    self.model.startMinute = self.smField.text.intValue;
    self.model.endHour = self.ehField.text.intValue;
    self.model.endMinute = self.emField.text.intValue;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:true];
    __weak __typeof(self)weakSelf = self;
    [JWBleAction jwNotDisturbAction:false model:self.model callBack:^(JWBleCommunicationStatus status, JWNotDisturbModel *model) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:true];
        [weakSelf.view makeToast:[JWBleDemoHelp communication2Str:status]];
    }];
    
}

@end
