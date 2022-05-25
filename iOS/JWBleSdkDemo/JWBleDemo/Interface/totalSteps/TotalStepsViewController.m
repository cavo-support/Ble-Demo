//
//  TotalStepsViewController.m
//  JWBleDemo
//
//  Created by Bo 黄 on 2019/9/21.
//  Copyright © 2019 wosmart. All rights reserved.
//

#import "TotalStepsViewController.h"

@interface TotalStepsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *valueLB;

@end

@implementation TotalStepsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [JWBleAction jwSynchronizePersonalInformation:18 isMan:true height:175.5 weight:180 callBack:^(JWBleCommunicationStatus status) {
        
    }];
    
    __weak __typeof(self)weakSelf = self;
    [JWBleAction jwGetRealTimeStepWithCallback:^(JWBleCommunicationStatus status, int step, int dis, int calories) {
        weakSelf.valueLB.text = [NSString stringWithFormat:@"计步: %d(步)\n距离: %d(米)\n卡路里: %d(卡)\n",step, dis, calories];
    }];
    
}

@end
