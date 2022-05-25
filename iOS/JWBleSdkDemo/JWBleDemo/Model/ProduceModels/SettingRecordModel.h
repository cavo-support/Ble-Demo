//
//  SettingRecordModel.h
//  JWBleDemo
//
//  Created by Bo 黄 on 2019/9/24.
//  Copyright © 2019 wosmart. All rights reserved.
//

#import "JKDBModel.h"

@interface SettingRecordModel : JKDBModel

@property(nonatomic, assign) int deviceNum;

@property(nonatomic, assign) int mainInterfaceSelectIndex;
@property(nonatomic, assign) bool mainInterfaceAutoSync;

@property(nonatomic, assign) int languageSelectIndex;
@property(nonatomic, assign) bool languageAutoSync;

@property(nonatomic, strong) NSString *deviceName;
@property(nonatomic, assign) bool deviceNameAutoSync;

@property(nonatomic, assign) BOOL bpOpenValue;
@property(nonatomic, assign) BOOL bpOpenAutoSync;

@property(nonatomic, assign) BOOL temperatureUseXiaomi;//温度使用小米仪器
@property(nonatomic, assign) NSInteger temperatureComponent1;
@property(nonatomic, assign) NSInteger temperatureComponent2;

+ (SettingRecordModel *)findByDeviceNum:(int)deviceNum;

+ (SettingRecordModel *)findByCurConnectionModel;

@end
