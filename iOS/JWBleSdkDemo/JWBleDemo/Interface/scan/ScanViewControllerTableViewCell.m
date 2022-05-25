//
//  ScanViewControllerTableViewCell.m
//  CoreBluetoothDemo
//
//  Created by Bo 黄 on 2019/2/13.
//  Copyright © 2019 Jone. All rights reserved.
//

#import "ScanViewControllerTableViewCell.h"

@interface ScanViewControllerTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLB;
@property (weak, nonatomic) IBOutlet UILabel *macLB;
@property (weak, nonatomic) IBOutlet UILabel *rssiLB;

@end

@implementation ScanViewControllerTableViewCell

- (void)setDeviceModel:(JWBleDeviceModel *)deviceModel {
    _deviceModel = deviceModel;
    
    self.nameLB.text = [NSString stringWithFormat:@"Name: %@",deviceModel.deviceName];
    self.macLB.text = [NSString stringWithFormat:@"MAC: %@",deviceModel.macAddress];
    self.rssiLB.text = [NSString stringWithFormat:@"RSSI: %ld",deviceModel.rssi.integerValue];
}

@end
