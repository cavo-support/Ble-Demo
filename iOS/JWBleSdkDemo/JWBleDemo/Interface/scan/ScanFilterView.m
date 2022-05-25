//
//  ScanFilterView.m
//  JWBleDemo
//
//  Created by Bo 黄 on 2019/9/21.
//  Copyright © 2019 wosmart. All rights reserved.
//

#import "ScanFilterView.h"

@interface ScanFilterView ()
<
    UITextFieldDelegate
>

@property (weak, nonatomic) IBOutlet UILabel *rssiLB;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property(nonatomic, strong) ScanFilterRecordModel *filterRecordModel;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UIButton *subBtn;

@end

@implementation ScanFilterView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.addBtn.layer.cornerRadius = 30;
    self.subBtn.layer.masksToBounds = true;
    self.subBtn.layer.cornerRadius = 30;
    self.subBtn.layer.masksToBounds = true;
    
    self.textField.delegate = self;
    self.textField.clearButtonMode=UITextFieldViewModeWhileEditing;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self modelValueChanged];
    });
    
}

- (void)modelValueChanged {
    [self.filterRecordModel saveOrUpdate];
    
    if (![self.filterRecordModel.name isEmpty]) {
        self.textField.text = self.filterRecordModel.name;
    }
    self.rssiLB.text = [NSString stringWithFormat:@"-%d",self.filterRecordModel.rssi];
    
    if (self.valueChangedCallBack) {
        self.valueChangedCallBack(self.filterRecordModel);
    }
}

- (IBAction)clickSubBtn:(id)sender {
    if (self.filterRecordModel.rssi > 10) {
        self.filterRecordModel.rssi -= 10;
        [self modelValueChanged];
    }
}

- (IBAction)clickAddBtn:(id)sender {
    self.filterRecordModel.rssi += 10;
    [self modelValueChanged];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.filterRecordModel.name = textField.text;
    [self modelValueChanged];
}

#pragma mark - getter
- (ScanFilterRecordModel *)filterRecordModel {
    if (!_filterRecordModel) {
        NSArray *all = [ScanFilterRecordModel findAll];
        if (all.count == 0) {
            _filterRecordModel = [ScanFilterRecordModel new];
            _filterRecordModel.rssi = 60;
        } else {
            _filterRecordModel = all.firstObject;
        }
    }
    return _filterRecordModel;
}

@end
