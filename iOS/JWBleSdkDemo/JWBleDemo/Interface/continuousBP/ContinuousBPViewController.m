//
//  ContinuousBPViewController.m
//  JWBleDemo
//
//  Created by Bo 黄 on 2020/8/21.
//  Copyright © 2020 wosmart. All rights reserved.
//

#import "ContinuousBPViewController.h"

@interface ContinuousBPViewController ()

@end

@implementation ContinuousBPViewController

/**
连续血压需要注意事项
   1.  连续血压与心率紧密关联，如心率自动检测不打开，将无法使用连续血压功能；
   2.  使用连续血压功能前，需要判断是否有连续血压功能；
   3.  为了防止手环重置、app与手环解绑，导致之前设置的开关状态消失，从而获取不到数据。app每次连接手环成功，需要将相对应开关重新设置一次；

 Note on continuous blood pressure
 1. Continuous blood pressure is closely related to heart rate. If the automatic heart rate detection is not turned on, the continuous blood pressure function cannot be used;
 2. Before using the continuous blood pressure function, you need to judge whether there is continuous blood pressure function;
 3. In order to prevent the reset of the bracelet and the unbinding of the app and the bracelet, the previously set switch state will disappear, and no data can be obtained. Every time the app connects to the bracelet successfully, you need to reset the corresponding switch;
*/
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Continuous blood pressure", nil);
    
    //1. 确保连续连续打开
    //1. Make sure to open continuously
    
    
    //2. 打开血压连续监测开关
    //2. Turn on the continuous blood pressure monitoring switch
    [JWBleAction jwBPV2Action:false open:true callBack:^(JWBleCommunicationStatus status, BOOL open) {
        
    }];
    
    //3. 如有需要，可打开私人血压
    //3. If necessary, you can turn on the personal blood pressure
    [JWBleAction jwBPPrivateSet:true h:160 l:70 callBack:^(JWBleCommunicationStatus status) {
        
    }];
    
    //4. 等待一些时间（心率自动监测的间隙时长），获取一下数据即有数据
    //4. Wait for some time (interval time of automatic heart rate monitoring), get the data and there will be data
    [JWBleDataAction jwGetBpDataByYYYYMMDDStr:@"yyyy-MM-dd" callBack:^(NSArray *dataArr) {
        //。。。
    }];
    
}



@end
