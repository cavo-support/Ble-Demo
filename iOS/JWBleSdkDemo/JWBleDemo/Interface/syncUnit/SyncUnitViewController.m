//
//  SyncUnitViewController.m
//  JWBleDemo
//
//  Created by bobobo on 2023/6/21.
//  Copyright © 2023 wosmart. All rights reserved.
//

#import "SyncUnitViewController.h"

@interface SyncUnitViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *timeSeg;
@property (weak, nonatomic) IBOutlet UISegmentedControl *temperatureSeg;
@property (weak, nonatomic) IBOutlet UISegmentedControl *metricSeg;

@end

@implementation SyncUnitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"syncUnit", nil);
    
}

- (IBAction)clickSyncBtn:(id)sender {
    
    //1: time
    JWBleCommonFunctionsStatus timeStatus = (self.timeSeg.selectedSegmentIndex == 0 ? JWBleCommonFunctionsStatus_Open : JWBleCommonFunctionsStatus_Close);
    [JWBleAction jwCommonFunction:JWBleFunctionEnum_TimeSystem functionsState:timeStatus callBack:^(JWBleCommunicationStatus communicationStatus, JWBleCommonFunctionsStatus functionStatus) {
        
    }];

    //2：temperature
    bool celsiusUnit = self.temperatureSeg.selectedSegmentIndex == 0;
    [JWBleAction jwTemperatureSwitchAction:false unit:celsiusUnit compensate:false monitor:false callBack:^(JWBleCommunicationStatus status, BOOL unit, BOOL compensate, BOOL monitor) {
    }];

    //3：Metric
    JWBleCommonFunctionsStatus metricStatus = (self.metricSeg.selectedSegmentIndex == 0 ? JWBleCommonFunctionsStatus_Open : JWBleCommonFunctionsStatus_Close);
    [JWBleAction jwCommonFunction:JWBleFunctionEnum_Unit functionsState:metricStatus callBack:^(JWBleCommunicationStatus communicationStatus, JWBleCommonFunctionsStatus functionStatus) {
    }];
    
}

@end
