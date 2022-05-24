//
//  ScanFilterView.h
//  JWBleDemo
//
//  Created by Bo 黄 on 2019/9/21.
//  Copyright © 2019 wosmart. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ScanFilterRecordModel.h"

@interface ScanFilterView : UIView



@property(nonatomic, copy) void (^valueChangedCallBack)(ScanFilterRecordModel *recordModel);

@end

