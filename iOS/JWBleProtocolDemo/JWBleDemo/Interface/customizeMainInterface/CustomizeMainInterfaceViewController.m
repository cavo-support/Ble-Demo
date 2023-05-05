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
