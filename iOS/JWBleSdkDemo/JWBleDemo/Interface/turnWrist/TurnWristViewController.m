//
//  TurnWristViewController.m
//  JWBleDemo
//
//  Created by Bo 黄 on 2019/8/7.
//  Copyright © 2019 wosmart. All rights reserved.
//

#import "TurnWristViewController.h"

@interface TurnWristViewController ()

@property (weak, nonatomic) IBOutlet UISwitch *switchView;
@property (weak, nonatomic) IBOutlet UITextField *lengthField;

@end

@implementation TurnWristViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Turn the wrist bright screen-bright screen duration", nil);
    
    [MBProgressHUD showHUDAddedTo:self.view animated:true];
    __weak __typeof(self)weakSelf = self;
    [JWBleAction jwTurnWristCreenActionWithIsGet:true open:false sensitivity:0 startMinute:0 endMinute:0 callBack:^(JWBleCommunicationStatus status, BOOL open, int sensitivity, int startMinute, int endMinute) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:true];
        [weakSelf.view makeToast:[JWBleDemoHelp communication2Str:status]];
        if (status == JWBleCommunicationStatus_Success) {
            weakSelf.switchView.on = open;
        }
    }];
    
    [JWBleAction jwbBrightScreenDuration:true timeLength:0 callBack:^(JWBleCommunicationStatus status, int timeLength, int defalut) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:true];
        [weakSelf.view makeToast:[JWBleDemoHelp communication2Str:status]];
        if (status == JWBleCommunicationStatus_Success) {
            weakSelf.lengthField.text = [NSString stringWithFormat:@"%d",timeLength];
        }
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:true];
}

- (IBAction)clickSaveBtn:(id)sender {
    [MBProgressHUD showHUDAddedTo:self.view animated:true];
    __weak __typeof(self)weakSelf = self;
    [JWBleAction jwTurnWristCreenActionWithIsGet:false open:self.switchView.on sensitivity:0 startMinute:0 endMinute:0 callBack:^(JWBleCommunicationStatus status, BOOL open, int sensitivity, int startMinute, int endMinute) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:true];
        [weakSelf.view makeToast:[JWBleDemoHelp communication2Str:status]];
    }];
    
}

- (IBAction)clickLengthBtn:(id)sender {
    
    [MBProgressHUD showHUDAddedTo:self.view animated:true];
    __weak __typeof(self)weakSelf = self;
    [JWBleAction jwbBrightScreenDuration:false timeLength:self.lengthField.text.intValue callBack:^(JWBleCommunicationStatus status, int timeLength, int defalut) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:true];
        [weakSelf.view makeToast:[JWBleDemoHelp communication2Str:status]];
    }];
    
}

@end
