//
//  NoticeTableViewCell.h
//  JWBleDemo
//
//  Created by Bo 黄 on 2019/8/8.
//  Copyright © 2019 wosmart. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^NoticeSwitchChangedBlock)(NSInteger rowIndex, BOOL open);

@interface NoticeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lb;
@property (weak, nonatomic) IBOutlet UISwitch *switchView;
@property(nonatomic, assign) NSInteger rowIndex;

@property(nonatomic, copy) NoticeSwitchChangedBlock noticeSwitchChangedBlock;

@end

NS_ASSUME_NONNULL_END
