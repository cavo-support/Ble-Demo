//
//  NoticeTableViewCell.m
//  JWBleDemo
//
//  Created by Bo 黄 on 2019/8/8.
//  Copyright © 2019 wosmart. All rights reserved.
//

#import "NoticeTableViewCell.h"

@implementation NoticeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)switchChanged:(UISwitch *)sender {
    if (self.noticeSwitchChangedBlock) {
        self.noticeSwitchChangedBlock(self.rowIndex, sender.on);
    }
}

@end
