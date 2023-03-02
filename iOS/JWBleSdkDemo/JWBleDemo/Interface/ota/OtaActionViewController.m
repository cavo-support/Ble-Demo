//
//  OtaActionViewController.m
//  JWBleDemo
//
//  Created by bobobo on 2023/3/1.
//  Copyright © 2023 wosmart. All rights reserved.
//

#import "OtaActionViewController.h"

@interface OtaActionViewController ()

@end

@implementation OtaActionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     操作步骤
     1：联系商务，得到新版本的bin文件
     2：可添加至项目中，或者web服务器中
     3：得到data数据后，进行传输
     */
    
    /**
    Operation steps
    1: Contact business to get the new version of bin file
    2: Can be added to the project or web server
    3: After getting the data, transfer it
    */
}

/**
 开始 ota
 isCommon： true: 固件，false:资源
 
 
 Start ota
 IsCommon: true: firmware, false: resource
 */
- (void)startWithCommon:(BOOL)isCommon {
    
    NSString *basePath = @"";
    NSString *fileName = @"";
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@",basePath,fileName]]];
    if (isCommon) {
        [[JWBleOTAAction shareInstance] startOTAWithData:data callBack:^(NSInteger didSend, NSInteger totalLength, JWBleDeviceDFUStatus deviceDFUStatus) {
            
            if (deviceDFUStatus == JWBleDeviceDFUStatus_FileNotExist) {
                
            } else if (deviceDFUStatus == JWBleDeviceDFUStatus_Start) {
            } else if (deviceDFUStatus == JWBleDeviceDFUStatus_Updating) {
                NSString *str = [NSString stringWithFormat:@"progress.. : %.1f%%",(float)didSend/(float)totalLength*100];
                NSLog(@"%@",str);
            } else if (deviceDFUStatus == JWBleDeviceDFUStatus_Success) {
                
            } else if (deviceDFUStatus == JWBleDeviceDFUStatus_Failure) {
                
            }
        }];
    } else {
        [[JWBleOTAAction shareInstance] startImageOTAWithData:data callBack:^(NSInteger didSend, NSInteger totalLength, JWBleDeviceDFUStatus deviceDFUStatus) {
            
            if (deviceDFUStatus == JWBleDeviceDFUStatus_FileNotExist) {
                
            } else if (deviceDFUStatus == JWBleDeviceDFUStatus_Start) {
                
            } else if (deviceDFUStatus == JWBleDeviceDFUStatus_Updating) {
                NSString *str = [NSString stringWithFormat:@"progress.. : %.1f%%",(float)didSend/(float)totalLength*100];
                NSLog(@"%@",str);
            } else if (deviceDFUStatus == JWBleDeviceDFUStatus_Success) {
                
            } else if (deviceDFUStatus == JWBleDeviceDFUStatus_Failure) {
                
            }
        }];
    }
}


@end