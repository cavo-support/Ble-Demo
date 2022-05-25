//
//  UpdateInterfaceColorViewController.m
//  JWBleDemo
//
//  Created by Zebra on 2022/5/24.
//  Copyright © 2022 wosmart. All rights reserved.
//

#import "UpdateInterfaceColorViewController.h"

@interface UpdateInterfaceColorViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentView;

@end

@implementation UpdateInterfaceColorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib. 
}

- (IBAction)ClickSetBtn:(id)sender {
    [JWBleAction jwUpdateInterfaceColor:self.segmentView.selectedSegmentIndex callBack:^(JWBleCommunicationStatus status) {
        
    }];
}


@end
