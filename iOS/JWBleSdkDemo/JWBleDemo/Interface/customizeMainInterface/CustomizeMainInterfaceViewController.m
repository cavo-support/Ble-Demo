//
//  CustomizeMainInterfaceViewController.m
//  JWBleDemo
//
//  Created by Bo 黄 on 2020/9/1.
//  Copyright © 2020 wosmart. All rights reserved.
//

#import "CustomizeMainInterfaceViewController.h"

@interface CustomizeMainInterfaceViewController ()
@property (weak, nonatomic) IBOutlet UILabel *descLB;
@end

@implementation CustomizeMainInterfaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Continuous blood pressure", nil);
    
}

/**
 内置表盘
 解析：设备自带的表盘
 */
- (void)deviceInterfaceAction {
    // 1: 获取有多少个表盘
    [JWBleAction jwMainInterfaceAction:true willShowIndex:0 callBack:^(JWBleCommunicationStatus status, int curShowIndex, int count) {
        NSLog(@"表盘总数: %d \t 当前显示下标: %d", count, curShowIndex);
    }];
    
    // 2: 设置显示的表盘
    int index = 0; //第一个
    [JWBleAction jwMainInterfaceAction:false willShowIndex:index callBack:^(JWBleCommunicationStatus status, int curShowIndex, int count) {
    }];
}

/**
 下载表盘
 解析：固件做好的表盘包，发给App，App进行资源升级
 */
- (void)downloadIntercadeAction {
    
    // 1: 通知固件，进入升级模式
    [JWBleAction jwUpdateResourceType:false type:JWUpdateResourceType_Dial_market_resources callBack:^(JWBleCommunicationStatus status, JWUpdateResourceType type) {
        
    }];
        
    // 2: 进行升级
    NSString *basePath = @"";
    NSString *fileName = @"";
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@",basePath,fileName]]];
    [[JWBleOTAAction shareInstance] startImageOTAWithData:data callBack:^(NSInteger didSend, NSInteger totalLength, JWBleDeviceDFUStatus deviceDFUStatus) {
        
        if (deviceDFUStatus == JWBleDeviceDFUStatus_FileNotExist) {
            
        } else if (deviceDFUStatus == JWBleDeviceDFUStatus_Start) {
            
        } else if (deviceDFUStatus == JWBleDeviceDFUStatus_Updating) {
            NSString *str = [NSString stringWithFormat:@"progress.. : %.1f%%",(float)didSend/(float)totalLength*100];
            NSLog(@"%@",str);
            
            // 3: 显示手环 首页表盘为 该下载表盘
            int deviceInterfaceCount = 999;// 通过 [JWBleAction jwMainInterfaceAction] 获取到的总数
            [JWBleAction jwMainInterfaceAction:false willShowIndex:deviceInterfaceCount+2 callBack:^(JWBleCommunicationStatus status, int curShowIndex, int count) {
            }];
        } else if (deviceDFUStatus == JWBleDeviceDFUStatus_Success) {
            
        } else if (deviceDFUStatus == JWBleDeviceDFUStatus_Failure) {
            
        }
    }];
    

}

/**
 自定义表盘
 解析：
    1：可动态设置背景图、时间颜色、时间位置。
    2：App进行组包
    3：通过资源升级
 */
- (void)customInterfaceAction {
    
    // 1: 通知设备进入升级模式
    [JWBleAction jwUpdateResourceType:false type:JWUpdateResourceType_Custom_interface_resources callBack:^(JWBleCommunicationStatus status, JWUpdateResourceType type) {

    }];
    
    UIImage *contentImage = NULL; //主屏幕图片(368 * 488)，通过App进行截图。可参考wofit
    UIImage *previewImage = NULL; //主屏幕预览图(274 * 320)，圆角16，边框颜色#08d3ff，边框大小2，通过App进行截图。可参考wofit
    
    JWBleCustomizeMainInterfaceActionConfigModel *configModel = [JWBleCustomizeMainInterfaceActionConfigModel new];
    
    //颜色、位置，结合App动态改
    configModel.color = JWBleCustomizeMainInterfaceActionConfigModelColor_White;
    configModel.position = JWBleCustomizeMainInterfaceActionConfigModelPosition_Bottom_Right;
    
    //以下2个固定写死即可
    configModel.chipType = JWBleManager.connectionModel.chipType;
    NSMutableDictionary *devicePositionDic = [NSMutableDictionary new];
    [devicePositionDic setObject:@{@"x":@(26),@"y":@(44)} forKey:@(0)];
    [devicePositionDic setObject:@{@"x":@(98),@"y":@(44)} forKey:@(1)];
    [devicePositionDic setObject:@{@"x":@(170),@"y":@(44)} forKey:@(2)];
    [devicePositionDic setObject:@{@"x":@(26),@"y":@(178)} forKey:@(3)];
    [devicePositionDic setObject:@{@"x":@(98),@"y":@(178)} forKey:@(4)];
    [devicePositionDic setObject:@{@"x":@(170),@"y":@(178)} forKey:@(5)];
    [devicePositionDic setObject:@{@"x":@(26),@"y":@(312)} forKey:@(6)];
    [devicePositionDic setObject:@{@"x":@(98),@"y":@(312)} forKey:@(7)];
    [devicePositionDic setObject:@{@"x":@(170),@"y":@(312)} forKey:@(8)];
    configModel.devicePositionDic = devicePositionDic;
    
    [JWBleCustomizeMainInterfaceAction startWithImage:contentImage
                                         previewImage:previewImage
                                          deviceWidth:368// GT7D固定写死即可
                                         deviceHeight:448// GT7D固定写死即可
                                          configModel:configModel
                                       actionCallBack:^(JWBleCustomizeMainInterfaceActionStatus actionStatus) {
            
                                      }
                                       updateCallBack:^(NSInteger didSend, NSInteger totalLength, JWBleDeviceDFUStatus deviceDFUStatus) {
            
    }];
    
    // 3: 显示手环 首页表盘为 该自定义表盘
    [JWBleAction jwMainInterfaceAction:true willShowIndex:0 callBack:^(JWBleCommunicationStatus status, int curShowIndex, int count) {
        [JWBleAction jwMainInterfaceAction:false willShowIndex:curShowIndex+1 callBack:^(JWBleCommunicationStatus status, int curShowIndex, int count) {
        }];
    }];
}

- (IBAction)clickStartBtn:(id)sender {
    
    [JWBleAction jwMainInterfaceAction:false willShowIndex:7 callBack:^(JWBleCommunicationStatus status, int curShowIndex, int count) {
        
    }];
    
//    __weak __typeof(self)weakSelf = self;
//
//    UIImage *img = [UIImage imageNamed:@"wofit1024" inBundle:nil compatibleWithTraitCollection:nil];
//    JWBleCustomizeMainInterfaceActionConfigModel *model = [JWBleCustomizeMainInterfaceActionConfigModel new];
//    model.color = JWBleCustomizeMainInterfaceActionConfigModelColor_Black;
//    model.position = JWBleCustomizeMainInterfaceActionConfigModelPosition_Middle_Left;
//
//    [JWBleCustomizeMainInterfaceAction startWithImage:img
//                         previewImage:img
//                          configModel:model
//                        actionCallBack:^(JWBleCustomizeMainInterfaceActionStatus actionStatus) {
//
//        if (actionStatus == JWBleCustomizeMainInterfaceActionStatus_Transmission) {
//            weakSelf.descLB.text = @"传输中";
//        } else if (actionStatus == JWBleCustomizeMainInterfaceActionStatus_Success) {
//            weakSelf.descLB.text = @"设置成功";
//        } else if (actionStatus == JWBleCustomizeMainInterfaceActionStatus_MakingResourcePack) {
//            weakSelf.descLB.text = @"制作资源包中";
//        }
//
//                        }
//                       updateCallBack:^(NSInteger didSend, NSInteger totalLength, JWBleDeviceDFUStatus deviceDFUStatus) {
//
//            weakSelf.descLB.text = [NSString stringWithFormat:@"传输中 didSend:%ld \t totalLength:%ld",didSend,totalLength];
//
//    }];

}

@end
