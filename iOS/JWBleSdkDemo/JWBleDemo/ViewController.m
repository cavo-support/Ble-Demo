//
//  ViewController.m
//  JWBleDemo
//
//  Created by Bo 黄 on 2019/3/20.
//  Copyright © 2019 wosmart. All rights reserved.
//

#import "ViewController.h"
#import "ScanViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *connectionBtn;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"迦沃智能";
}

- (void)updateConnectionBtnTitle {
    if (JWBleManager.isConnected) {
        [self.connectionBtn setTitle:@"断开连接" forState:UIControlStateNormal];
    } else {
        [self.connectionBtn setTitle:@"去连接" forState:UIControlStateNormal];
    }
}

- (IBAction)click2ConnectionBtn:(id)sender {
    if (JWBleManager.isConnected) {
        [JWBleAction jwDisConnect];
    } else {
        [self.navigationController pushViewController:[ScanViewController new] animated:true];
    }
}

- (IBAction)clickActionList:(id)sender {
    if (JWBleManager.isConnected) {
//        [self.navigationController pushViewController:[ActionListViewController new] animated:true];
    } else {
        [self.navigationController pushViewController:[ScanViewController new] animated:true];
    }
}

#pragma mark - help
- (void)updateVersion {
//    [self.navigationController pushViewController:[UpdateVersionViewController new] animated:true];
}

- (void)showUpdateVersionAlert {
    __weak __typeof(self)weakSelf = self;
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"该设备是DFU手环", nil)
                                                                   message:@"是否升级"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"是", nil) style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action) {
                                                         [weakSelf updateVersion];
                                                     }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"否", nil) style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * action) {
                                                             
                                                         }];
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)showPasswordAlert {
//    __weak __typeof(self)weakSelf = self;
//    
//    UIAlertController* alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"请输入密码", nil)
//                                                                   message:nil
//                                                            preferredStyle:UIAlertControllerStyleAlert];
//    
//    UIAlertAction* okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"完成", nil) style:UIAlertActionStyleDefault
//                                                     handler:^(UIAlertAction * action) {
//                                                         for(UITextField *text in alert.textFields){
//                                                             if (![text.text isEmpty]) {
//                                                                 [MBProgressHUD showHUDAddedTo:weakSelf.view animated:true];
//                                                                 
//                                                                 [JWBleAction checkPassword:[text.text intValue] callBack:^(JWBleCommunicationStatus status) {
//                                                                     [MBProgressHUD hideHUDForView:weakSelf.view animated:true];
//                                                                     [weakSelf.view makeToast:[JWBleDemoHelp communication2Str:status]];
//                                                                     if (status == JWBleCommunicationStatus_PWDError) {
//                                                                         [weakSelf showPasswordAlert];
//                                                                     }
//                                                                 }];
//                                                             }
//                                                         }
//                                                     }];
//    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"取消", nil) style:UIAlertActionStyleCancel
//                                                         handler:^(UIAlertAction * action) {
//                                                             
//                                                         }];
//    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
//        textField.text = @"";
//        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
//    }];
//    [alert addAction:okAction];
//    [alert addAction:cancelAction];
//    
//    [self presentViewController:alert animated:YES completion:nil];
}
@end
