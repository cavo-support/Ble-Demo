//
//  RemotePhotographyViewController.m
//  JWBleDemo
//
//  Created by bobobo on 2023/6/21.
//  Copyright © 2023 wosmart. All rights reserved.
//

#import "RemotePhotographyViewController.h"

@interface RemotePhotographyViewController ()

@end

@implementation RemotePhotographyViewController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    [JWBleAction jwRemotePhotography:false callBack:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"RemotePhotography";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    //The device enters camera mode
    [JWBleAction jwRemotePhotography:true callBack:nil];
    
    //Monitor camera callback
    JWBleManager.remotePhotographyCallBack = ^(JWBleRemotePhotographyStatus remotePhotographyStatus) {
        if (remotePhotographyStatus == JWBleRemotePhotographyStatus_TakePhoto) {
            NSLog(@"JWBleRemotePhotographyStatus_TakePhoto");
        }
    };
}


@end
