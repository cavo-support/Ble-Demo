//
//  SyncAutomaticMonitoringTableViewCell.h
//  JWBleDemo
//
//  Created by bobobo on 2023/6/21.
//  Copyright © 2023 wosmart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WFJWDeviceFunctionModel.h"

@interface SyncAutomaticMonitoringTableViewCell : UITableViewCell

@property (nonatomic, strong) WFJWDeviceFunctionModel *functionModel;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UISwitch *switchView;

@end
