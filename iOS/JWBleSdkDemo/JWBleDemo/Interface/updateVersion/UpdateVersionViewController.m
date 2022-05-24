//
//  UpdateVersionViewController.m
//  CoreBluetoothDemo
//
//  Created by Bo 黄 on 2019/3/15.
//  Copyright © 2019 Jone. All rights reserved.
//

#import "UpdateVersionViewController.h"
#import "UpdateVersionFileViewController.h"
#import "OTARecordModel.h"

@interface UpdateVersionViewController ()

@property(nonatomic, strong) NSString *selectedFileName;
@property (weak, nonatomic) IBOutlet UILabel *fileNameLB;
@property(nonatomic, strong) NSString *basePath;
@property (weak, nonatomic) IBOutlet UILabel *statusLB;
@property(nonatomic, strong) OTARecordModel *otaRecordModel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewConstraint;

@end

@implementation UpdateVersionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"固件更新";
    self.statusLB.textColor = [UIColor redColor];
    
    if (@available(iOS 11, *) == false) {
        self.topViewConstraint.constant += 64;
    }
    
    [self checkDBRecord];
}

- (void)checkDBRecord {
    if (self.otaRecordModel) {
        NSData *data = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@",self.basePath,self.otaRecordModel.fileName]]];
        if (data) {
            self.selectedFileName = self.otaRecordModel.fileName;
            self.fileNameLB.text = [NSString stringWithFormat:@"已选择：%@",self.selectedFileName];
        }
    }
}

- (IBAction)clickStartBtn:(UIButton *)sender {
    
    if (self.selectedFileName == nil || [self.selectedFileName isEmpty]) {
        [self.view makeToast:@"请选择要升级的文件"];
        return;
    }
    
    //储存这次的选择
    if (!self.otaRecordModel) {
        self.otaRecordModel = [OTARecordModel new];
        self.otaRecordModel.deviceNumber = JWBleManager.connectionModel.deviceNumber;
    }
    self.otaRecordModel.fileName = self.selectedFileName;
    [OTARecordModel clearTable];
    [self.otaRecordModel save];
    
    NSString *str = [NSString stringWithFormat:@"你选择的是  %@  方式",sender.tag == 222222 ? @"资源升级" : @"普通升级"];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请核对升级方式" message:str preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *select1 = [UIAlertAction actionWithTitle:@"选错了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    UIAlertAction *select2 = [UIAlertAction actionWithTitle:@"继续升级" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self startWithCommon:sender.tag != 222222];
    }];
    [alertController addAction:select1];
    [alertController addAction:select2];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)startWithCommon:(BOOL)isCommon {
    [self.view makeToastActivity:self];
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@",self.basePath,self.selectedFileName]]];
    __weak __typeof(self)weakSelf = self;
    if (isCommon) {
        [[JWBleOTAAction shareInstance] startOTAWithData:data callBack:^(NSInteger didSend, NSInteger totalLength, JWBleDeviceDFUStatus deviceDFUStatus) {
            
            [weakSelf.view hideAllToasts];
            [weakSelf.view hideToastActivity];
            [weakSelf updateAllButtonEnable:false];
            
            if (deviceDFUStatus == JWBleDeviceDFUStatus_FileNotExist) {
                weakSelf.statusLB.text = @"升级文件不存在";
                [weakSelf updateAllButtonEnable:true];
            } else if (deviceDFUStatus == JWBleDeviceDFUStatus_Start) {
                weakSelf.statusLB.text = @"升级中，请稍后...";
            } else if (deviceDFUStatus == JWBleDeviceDFUStatus_Updating) {
                NSString *str = [NSString stringWithFormat:@"升级中 : %.1f%%",(float)didSend/(float)totalLength*100];
                weakSelf.statusLB.text = str;
            } else if (deviceDFUStatus == JWBleDeviceDFUStatus_Success) {
                weakSelf.statusLB.text = @"升级成功";
                [weakSelf updateAllButtonEnable:true];
            } else if (deviceDFUStatus == JWBleDeviceDFUStatus_Failure) {
                weakSelf.statusLB.text = @"升级失败";
                [weakSelf updateAllButtonEnable:true];
            }
        }];
    } else {
        [[JWBleOTAAction shareInstance] startImageOTAWithData:data callBack:^(NSInteger didSend, NSInteger totalLength, JWBleDeviceDFUStatus deviceDFUStatus) {
            
            [weakSelf.view hideAllToasts];
            [weakSelf.view hideToastActivity];
            [weakSelf updateAllButtonEnable:false];
            
            if (deviceDFUStatus == JWBleDeviceDFUStatus_FileNotExist) {
                weakSelf.statusLB.text = @"升级文件不存在";
                [weakSelf updateAllButtonEnable:true];
            } else if (deviceDFUStatus == JWBleDeviceDFUStatus_Start) {
                weakSelf.statusLB.text = @"升级中，请稍后...";
            } else if (deviceDFUStatus == JWBleDeviceDFUStatus_Updating) {
                NSString *str = [NSString stringWithFormat:@"升级中 : %.1f%%",(float)didSend/(float)totalLength*100];
                weakSelf.statusLB.text = str;
            } else if (deviceDFUStatus == JWBleDeviceDFUStatus_Success) {
                weakSelf.statusLB.text = @"升级成功";
                [weakSelf updateAllButtonEnable:true];
            } else if (deviceDFUStatus == JWBleDeviceDFUStatus_Failure) {
                weakSelf.statusLB.text = @"升级失败";
                [weakSelf updateAllButtonEnable:true];
            }
        }];
    }
}

- (IBAction)clickSelectFileBtn:(id)sender {
    UpdateVersionFileViewController *vc = [UpdateVersionFileViewController new];
    vc.otaRecordModel = self.otaRecordModel;
    __weak __typeof(self)weakSelf = self;
    vc.selectedFileBlock = ^(NSString * _Nonnull fileName) {
        weakSelf.selectedFileName = fileName;
        weakSelf.fileNameLB.text = [NSString stringWithFormat:@"已选择：%@",fileName];
    };
    
    vc.removeFileBlock = ^{
        weakSelf.otaRecordModel = nil;
        weakSelf.selectedFileName = nil;
        weakSelf.fileNameLB.text = @"";
    };
    
    [self.navigationController pushViewController:vc animated:true];
}

- (IBAction)clickNetBtn:(id)sender {

}

- (void)updateAllButtonEnable:(BOOL)enable {
    for (UIView *subView in self.view.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)subView;
            btn.enabled = enable;
        }
    }
}

#pragma mark - getter
- (NSString *)basePath {
    if (!_basePath) {
        // 获得此程序的沙盒路径
        NSArray *patchs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        // 获取Documents路径
        // [patchs objectAtIndex:0]
        NSString *documentsDirectory = [patchs objectAtIndex:0];
        _basePath = [documentsDirectory stringByAppendingPathComponent:@"/Inbox"];
    }
    return _basePath;
}

- (OTARecordModel *)otaRecordModel {
    if (!_otaRecordModel) {
        _otaRecordModel = [OTARecordModel getByDeviceNumber:JWBleManager.connectionModel.deviceNumber];
    }
    return _otaRecordModel;
}


@end
