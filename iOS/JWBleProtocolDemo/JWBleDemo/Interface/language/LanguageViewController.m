//
//  LanguageViewController.m
//  JWBleDemo
//
//  Created by Bo 黄 on 2019/8/7.
//  Copyright © 2019 wosmart. All rights reserved.
//

#import "LanguageViewController.h"
#import "SettingRecordModel.h"

@interface LanguageViewController ()
<
    UIPickerViewDelegate,
    UIPickerViewDataSource
>

@property (weak, nonatomic) IBOutlet UIPickerView *pickView;
@property(nonatomic, strong) NSArray *titleArr;
@property(nonatomic, strong) NSArray *enumArr;
@property (weak, nonatomic) IBOutlet UISwitch *switchView;

@property(nonatomic, strong) SettingRecordModel *settingRecordModel;

@end

@implementation LanguageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Language", nil);
    
    self.settingRecordModel = [SettingRecordModel findByCurConnectionModel];
    self.switchView.on = self.settingRecordModel.deviceNameAutoSync;
    
    self.pickView.dataSource = self;
    self.pickView.delegate = self;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:true];
    __weak __typeof(self)weakSelf = self;
    [JWBleAction jwLanguageAction:true languageEnum:JWBleLanguageEnum_ChineseSimplified callBack:^(JWBleCommunicationStatus status, JWBleLanguageEnum languageEnum) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:true];
        if (status == JWBleCommunicationStatus_Success) {
            for (int i = 0; i < weakSelf.enumArr.count; i++) {
                if ([weakSelf.enumArr[i] intValue] == languageEnum) {
                    [weakSelf.pickView selectRow:i inComponent:0 animated:true];
                    break;
                }
            }
        }
    }];
    
}

- (IBAction)switchValueChanged:(id)sender {
    self.settingRecordModel.languageSelectIndex = [self.enumArr[[self.pickView selectedRowInComponent:0]] intValue];
    self.settingRecordModel.languageAutoSync = self.switchView.on;
    [self.settingRecordModel saveOrUpdate];
}

- (IBAction)clickSetBtn:(id)sender {
    
    JWBleLanguageEnum languageEnum = [self.enumArr[[self.pickView selectedRowInComponent:0]] intValue];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:true];
    __weak __typeof(self)weakSelf = self;
    [JWBleAction jwLanguageAction:false languageEnum:languageEnum callBack:^(JWBleCommunicationStatus status, JWBleLanguageEnum languageEnum) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:true];
        [weakSelf.view makeToast:[JWBleDemoHelp communication2Str:status]];
    }];
    
    self.settingRecordModel.languageSelectIndex = [self.enumArr[[self.pickView selectedRowInComponent:0]] intValue];
    self.settingRecordModel.languageAutoSync = self.switchView.on;
    [self.settingRecordModel saveOrUpdate];
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.titleArr.count;
}

#pragma mark - UIPickerViewDelegate
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.titleArr[row];
}

#pragma mark - getter
- (NSArray *)titleArr {
    if (!_titleArr) {
        _titleArr = @[
                      @"ChineseSimplified",
                      @"Traditional_Chinese",
                      @"English",
                      @"Spanish",
                      @"French",
                      @"German",
                      @"Italian",
                      @"Japanese",
                      @"Swedish",
                      @"Korean",
                      @"Portuguese",
                      @"Russian",
                      @"Turkey"
                ];
    }
    return _titleArr;
}

- (NSArray *)enumArr {
    if (!_enumArr) {
        _enumArr = @[
                     @(JWBleLanguageEnum_ChineseSimplified),
                     @(JWBleLanguageEnum_Traditional_Chinese),
                     @(JWBleLanguageEnum_English),
                     @(JWBleLanguageEnum_Spanish),
                     @(JWBleLanguageEnum_French),
                     @(JWBleLanguageEnum_German),
                     @(JWBleLanguageEnum_Italian),
                     @(JWBleLanguageEnum_Japanese),
                     @(JWBleLanguageEnum_Swedish),
                     @(JWBleLanguageEnum_Korean),
                     @(JWBleLanguageEnum_Portuguese),
                     @(JWBleLanguageEnum_Russian),
                     @(JWBleLanguageEnum_Turkey)
        ];
    }
    return _enumArr;
}

@end
    
