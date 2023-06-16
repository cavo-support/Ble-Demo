//
//  V7(GT7D)ActionListViewController.m
//  JWBleDemo
//
//  Created by bobobo on 2023/6/16.
//  Copyright © 2023 wosmart. All rights reserved.
//

#import "V7_GT7D_ActionListViewController.h"
#import "ActionListViewControllerTableViewCell.h"

@interface V7_GT7D_ActionListViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource
>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSArray *functionArr;

@end

@implementation V7_GT7D_ActionListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"function list", nil);
    [self.view addSubview:self.tableView];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.functionArr.count;
}

#pragma mark UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ActionListViewControllerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActionListViewControllerTableViewCell"];
    cell.titleLB.text = NSLocalizedString(self.functionArr[indexPath.row], nil);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
   NSString *actionStr = NSLocalizedString(self.functionArr[indexPath.row], nil);
   
   __weak __typeof(self)weakSelf = self;
   if ([actionStr isEqualToString:@"蓝牙搜索"]) {
       [JWBleAction jwStartScanDeviceWithCallBack:^(JWBleDeviceModel *deviceModel) {
           
       }];
   } else if ([actionStr isEqualToString:@"设备连接"]) {
       [JWBleAction jwStartScanDeviceWithCallBack:^(JWBleDeviceModel *deviceModel) {
           //具体的连接代码
           [JWBleAction jwConnectDevice:deviceModel];
       }];
   } else if ([actionStr isEqualToString:@"断开连接"]) {
       //解绑、会清除设备数据
       [JWBleAction jwDisConnect];
       
       //断开链接，不会清除设备数据
       [JWBleAction jwDisConnectNotUnBond];
   } else if ([actionStr isEqualToString:@"登陆操作"]) {
       //[JWBleManager setUpWithUid:@"cavo"];
       //App启动的时候、切换用户登录时，设置uid即可；ios已经封装了与设备的登录流程
   } else if ([actionStr isEqualToString:@"获取设备信息"]) {
       /**
        1：全局监听 JWBleManager.connectStateChangeCallBack
        2：返回状态为 JWBleDeviceConnectStatus_SyncSuccess 时，即可根据 JWBleManager.connectionModel 获取相关信息
        3：详情可查看 RootViewController 54行左后的代码
        */
   } else if ([actionStr isEqualToString:@"同步时间"]) {
       
       //sdk，已经在连接设备时，设置手机当前时间给设备，该方法 如改变了设备时间，可能会导致 设备数据错乱。请慎重使用
       
       //获取当前时间
       NSDate *now = [NSDate date];
       NSCalendar *calendar = [NSCalendar currentCalendar];
       NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
       NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
       //    WristBand *_wristBand = [WristBand getShareInstance];
       NSInteger y = [dateComponent year] - 2000;
       [JWBleAction jwSetTimeWithYear:y
                             andMonth:[dateComponent month]
                               andDay:[dateComponent day]
                              andHour:[dateComponent hour]
                            andMinute:[dateComponent minute]
                            andSecond:[dateComponent second] callBack:^(JWBleCommunicationStatus status) {
           
       }];
   } else if ([actionStr isEqualToString:@"用户信息"]) {
       /**
        同步个人信息 Synchronize personal information
        
        @param age 年龄  0~127  Age 0~127
        @param isMan 是否是男的 Is it male
        @param height 身高cm 0.0~256 精确到0.5cm Height cm 0.0~256 accurate to 0.5cm
        @param weight 体重kg 0.0~512 精确到0.5kg Weight kg 0.0~512 accurate to 0.5kg
        @param callBack 回调 Callback
        */
       [JWBleAction jwSynchronizePersonalInformation:18 isMan:true height:175.5 weight:180 callBack:^(JWBleCommunicationStatus status) {
           
       }];
   } else if ([actionStr isEqualToString:@"语言"]) {
       //1: 获取设备支持语言
       [JWBleAction jwLanguageAction:true languageEnum:JWBleLanguageEnum_ChineseSimplified callBack:^(JWBleCommunicationStatus status, JWBleLanguageEnum languageEnum) {
           
       }];
       
       //2: 设置设备语言
       [JWBleAction jwLanguageAction:false languageEnum:JWBleLanguageEnum_ChineseSimplified callBack:^(JWBleCommunicationStatus status, JWBleLanguageEnum languageEnum) {
           
       }];
       
       //3:  可参考 LanguageViewController 类
   } else if ([actionStr isEqualToString:@"单位设置"]) {
       //1: 小时制
       bool show12 = false;
       [JWBleAction jwCommonFunction:JWBleFunctionEnum_TimeSystem functionsState:show12 ? JWBleCommonFunctionsStatus_Open : JWBleCommonFunctionsStatus_Close callBack:^(JWBleCommunicationStatus communicationStatus, JWBleCommonFunctionsStatus functionStatus) {
       }];
       
       //2：摄氏度、华氏度
       bool celsius = true;
       bool monitor = true;
       [JWBleAction jwTemperatureSwitchAction:false unit:true compensate:celsius monitor:monitor callBack:^(JWBleCommunicationStatus status, BOOL unit, BOOL compensate, BOOL monitor) {
       }];
       
       //3：公英制
       JWBleCommonFunctionsStatus status = JWBleCommonFunctionsStatus_Open;//公制
       [JWBleAction jwCommonFunction:JWBleFunctionEnum_Unit functionsState:status callBack:^(JWBleCommunicationStatus communicationStatus, JWBleCommonFunctionsStatus functionStatus) {
       }];
       
   } else if ([actionStr isEqualToString:@"目标设定"]) {
       /**
        设置计步目标 Set pedometer goal
        
        @param step 步数 1000~65000  Number of steps 1000~65000
        @param callBack 回调 Callback
        */
       [JWBleAction jwSetStepTargetAction:10000 callBack:^(JWBleCommunicationStatus status) {
           
       }];
       
       /**
        设置卡路里目标 Set calorie goal
        
        @param calorie 单位千卡  Unit kcal 100~9999
        @param callBack 回调 Callback
        */
       [JWBleAction jwSetCalorieTargetAction:1000 callBack:^(JWBleCommunicationStatus status) {
           
       }];
       
       /**
        设置睡眠目标 Set sleep goals
        
        @param minute 分钟 90~900 Min 90~900
        @param callBack 回调 Callback
        */
       [JWBleAction jwSetSleepTargetAction:480 callBack:^(JWBleCommunicationStatus status) {
           
       }];
   } else if ([actionStr isEqualToString:@"同步数据"]) {
       // 1： 先将设备的数据，同步至sdk中
       [JWBleDataAction jwSyncDataWithCallBack:^(JWBleCommunicationStatus status, JWBleSyncStateEnum syncStateEnum) {
           //监听 JWBleSyncEnum_Complete 状态为成功后 进行 第二步
       }];
       
       // 2: 从sdk db 中获取数据
       
       // 2.1: 抽象来说，所有数据类型，都提供了，根据天获取数据，如步数
       // 2.2: 其它的数据会在下列方法中详细补充
       [JWBleDataAction jwGetStepDataByYYYYMMDDStr:@"20180911" callBack:^(NSArray *dataArr) {
           
       }];
   } else if ([actionStr isEqualToString:@"计步"]) {
       
       //获取历史数据，必须先同步设备数据至sdk中 [JWBleDataAction jwSyncDataWithCallBack:];
       
       NSString *dayStr = @"20180911";//yyyyMMdd
       //以天获取
       [JWBleDataAction jwGetStepDataByYYYYMMDDStr:dayStr callBack:^(NSArray *dataArr) {
           /**
            1、dataArr会有96个，从00：00~23：45 间隔15分钟 一个
            2、如果获取失败，则dataArr为@[]
            3、手环显示 卡路里取整数（小数直接抛弃），公里数四舍五入
            
            dataArr:
            [
                {
                    offset:0(第几个15分钟)
                    steps:11 (步数),
                    calory:22 (卡路里，单位卡),
                    distance:33(距离，单位 米)
                }
            ]
            */
       }];
       
       //获取设备的当前 步数、卡路里等等
       [JWBleDataAction jwGetDayStepTotalValue:dayStr callback:^(JWBleCommunicationStatus status, int step, int dis, int calories) {
           /**
            steps:11 (步数),
            calory:22 (卡路里，单位卡),
            distance:33(距离，单位 米)
            */
       }];
       
   } else if ([actionStr isEqualToString:@"睡眠"]) {
       //获取历史数据，必须先同步设备数据至sdk中 [JWBleDataAction jwSyncDataWithCallBack:];
       
       NSString *dayStr = @"20180911";//yyyyMMdd
       //以天获取
       [JWBleDataAction jwGetSleepDataByYYYYMMDDStr:dayStr callBack:^(NSArray *dataArr) {
           /**
            1、返回的是每分钟数据 即每日有1440分钟。
            
            dataArr:
            [
                {
                    minute:1386 （第几分钟）
                    status:  1 （1：浅睡，2：深睡，3：清醒）
                    yyyyMMdd: 20190901
                },
                {
                minute:36 （第几分钟）
                status:  3 （1：浅睡，2：深睡，3：清醒）
                yyyyMMdd: 20190902
                }
            ]
            */
       }];
   } else if ([actionStr isEqualToString:@"心率"]) {
       //获取历史数据，必须先同步设备数据至sdk中 [JWBleDataAction jwSyncDataWithCallBack:];
       
       NSString *dayStr = @"20180911";//yyyyMMdd
       //以天获取
       [JWBleDataAction jwGetHRDataByYYYYMMDDStr:dayStr callBack:^(NSArray *dataArr) {
           /**
            返回的数据按照time排序 从小到大 返回
            
            dataArr:
            [
               {
                    time:1567576122 (时间戳),
                    value:123 (心率值)
               }，
                {
                time:1567576122 (时间戳),
                value:123 (心率值)
                }
            ]
            */
       }];
       
       //测试心率
       bool start = true;// false:结束测试、true:开始测试
       [JWBleAction jwTestHRAction:start callBack:^(JWBleCommunicationStatus status, JWBleTestHRStatus testStatus, int hrValue) {
           /**
            //测试心率状态 Test heart rate status
            typedef NS_ENUM(NSInteger, JWBleTestHRStatus) {
                JWBleTestHRStatus_TestStart = 0, //测试开始，等待手环的响应  The test starts, waiting for the bracelet's response
                JWBleTestHRStatus_DeviceResponse,//手环响应中  Bracelet responding
                JWBleTestHRStatus_TestEnd,//测试结束 End of test
                JWBleTestHRStatus_TestField,//测试失败 Test failed
            };
            */
       }];
   } else if ([actionStr isEqualToString:@"温度"]) {
       //获取历史数据，必须先同步设备数据至sdk中 [JWBleDataAction jwSyncDataWithCallBack:];
       
       NSString *dayStr = @"20180911";//yyyyMMdd
       //以天获取
       [JWBleDataAction jwGetTemperatureDataByYYYYMMDDStr:dayStr callBack:^(NSArray *dataArr) {
           /**
            [
               {
                   time:1567576122 (时间戳),
                   value:123 (温度值),
                   wearingState:0/1(佩戴状态),
                   compensationStatus:0/1(补偿状态)
               }，
               {
                   time:1567576122 (时间戳),
                   value:123 (温度值),
                   wearingState:0/1(佩戴状态),
                   compensationStatus:0/1(补偿状态)
               }
            ]
            */
       }];
       
       //测试温度
       int start = 1;//0:关闭温度数据监测 1：开启温度数据监测
       [JWBleAction jwTestTemperatureAction:start callBack:^(JWBleCommunicationStatus status, JWBleTestTemperatureStatus testStatus) {
           /**
            测试温度回调 Test temperature callback
            
            @param status 状态 status
            @param testStatus 测试状态回调 Test status callback
            */
       }];
       
       //监听实时温度返回
       JWBleManager.realTimeTemperatureCallBack = ^(float value, BOOL gradientStatus, BOOL wearingState, BOOL compensationStatus) {
           /**
            实时温度回调
            Real-time temperature callback
             
            value:温度值 Temperature value
            gradientStatus: 是否是渐变状态（如果是渐变状态，一般不会储存） Whether it is a gradual change state (if it is a gradual change state, it is generally not saved)
            wearingState：是否佩戴 Whether to wear
            compensationStatus：是否补偿 Whether to compensate
            如果value为-999，则是手环主动停止的 If the value is -999, the bracelet is actively stopped
            */
       };
       
       //温度校准  设备返回compensationStatus时才需要校准
       float value = [JWBleDataAction jwTemperatureCalibration:36];
       
   } else if ([actionStr isEqualToString:@"血氧"]) {
       //获取历史数据，必须先同步设备数据至sdk中 [JWBleDataAction jwSyncDataWithCallBack:];
       
       NSString *dayStr = @"20180911";//yyyyMMdd
       [JWBleDataAction jwGetOxygenDataByYYYYDDStr:dayStr callBack:^(NSArray *dataArr) {
           //返回是 JWOxygenModel 的数组
           
           /**
            @property(nonatomic, assign) int mCurValue; //当前血氧值 Current blood oxygen value
            @property(nonatomic, assign) int mHighValue; //最高血氧值 Maximum blood oxygen value
            @property(nonatomic, assign) int mLowValue; //最低血氧值 Minimum blood oxygen value

            @property(nonatomic, assign) NSInteger time; //时间戳 timestamp
            */
       }];
       
       //测试血氧
       [JWBleAction jwTestOxygen:JWTestOxygenRequestType_Start callBack:^(JWBleCommunicationStatus status, JWTestOxygenResultType resultType, JWOxygenModel *oxygenModel) {
           if (resultType == JWTestOxygenResultType_Start && oxygenModel.mCurValue != 0) {
               //值陆续返回
           } else if (resultType == JWTestOxygenResultType_End) {
               //测试结束
           }
       }];
   } else if ([actionStr isEqualToString:@"查询电量"]) {
       //1: 设备当前电量
       int power = JWBleManager.connectionModel.power;
       
       //2: 监听电量改变
       //JWBleManager.connectStateChangeCallBack 回调中，监听 JWBleDeviceConnectStatus_BatteryUpdate，然后再以第一步方式获取
   } else if ([actionStr isEqualToString:@"通知开关"]) {
       //1：获取支持的列表
       __block NSDictionary *deviceNotiDic = NULL;
       [JWBleAction jwGetNotiStatusWithCallBack:^(JWBleCommunicationStatus status, NSDictionary *dic) {
           if (status == JWBleCommunicationStatus_Success) {
               deviceNotiDic = dic;
               //遍历 返回的dic ，判断具体的消息通知类型，是否支持, 如
               NSArray *arr = dic.allKeys;
               for (int i = 0; i < arr.count; i++) {
                   if (arr[i] == JWBleNotiEnum_WeChat) {//则支持微信, 更多的枚举可查看 JWBleNotiEnum
                       JWBleNotiEnum notiType = arr[i];
                       BOOL open = [[dic objectForKey:@(notiType)] boolValue];
                       if (open) {//当前状态为 打开
                           
                       }
                   }
               }
           }
       }];
       
       //2：设置某个消息类型状态
       [JWBleAction jwUpdateNotiStatus:JWBleNotiEnum_WeChat open:true callBack:^(JWBleCommunicationStatus status) {
           
       }];
       
       //3: 批量更新消息状态
       [JWBleAction jwOneTimeUpdateNotiStatus:deviceNotiDic callBack:^(JWBleCommunicationStatus status) {
           
       }];
   } else if ([actionStr isEqualToString:@"来电提醒"]) {
       // ios 走 ancs 不需要该方法
   } else if ([actionStr isEqualToString:@"通知推送"]) {
       // ios 走 ancs 不需要该方法
   } else if ([actionStr isEqualToString:@"闹钟"]) {
       //1: 添加闹钟
       JWBleAlarmClockModel *model = [[JWBleAlarmClockModel alloc] init];
       
       // 2023-06-16 11:20
       model.year = 2023 - 2000;
       model.month = 6;
       model.day = 16;
       model.hour = 11;
       model.minute = 20;
       
       
//       [JWBleAction jwAlarmV2Action:false alarmModel:model callBack:^(JWBleCommunicationStatus status, NSArray<JWBleAlarmClockModel *> *alarmArr) {
//           [MBProgressHUD hideHUDForView:weakSelf.view animated:true];
//           if (status == JWBleCommunicationStatus_Success) {
//               [[WFOtherFun getCurrentVC].navigationController popViewControllerAnimated:true];
//           } else {
//               [WFNotiView showNotiWithMessage:NSLocalizedString(@"操作失败", nil)];
//           }
//       }];
   } else if ([actionStr isEqualToString:@"心率自动检测"]) {
       
   } else if ([actionStr isEqualToString:@"久坐提醒"]) {
       
   } else if ([actionStr isEqualToString:@"亮屏设置"]) {
       
   } else if ([actionStr isEqualToString:@"倒计时"]) {
       
   } else if ([actionStr isEqualToString:@"查找手机"]) {
       
   } else if ([actionStr isEqualToString:@"固体升级"]) {
       
   } else if ([actionStr isEqualToString:@"运动"]) {
       
   } else if ([actionStr isEqualToString:@"天气"]) {
       
   } else if ([actionStr isEqualToString:@"遥控拍照"]) {
       
   } else if ([actionStr isEqualToString:@"音乐控制"]) {
       
   } else if ([actionStr isEqualToString:@"亮屏时长"]) {
       
   } else if ([actionStr isEqualToString:@"开关设置"]) {
       
   } else if ([actionStr isEqualToString:@"蓝牙拨号"]) {
       
   } else if ([actionStr isEqualToString:@"通讯录"]) {
       
   } else if ([actionStr isEqualToString:@"音频蓝牙配对"]) {
       
   } else if ([actionStr isEqualToString:@"在线表盘"]) {
       
   } else if ([actionStr isEqualToString:@"表盘下载/切换/删除"]) {
       
   } else if ([actionStr isEqualToString:@"运动记录"]) {
       
   } else if ([actionStr isEqualToString:@"语音助手"]) {
       
   } else if ([actionStr isEqualToString:@"时间制式"]) {
       
   }
}

#pragma mark - getter
- (NSArray *)functionArr {
   if (!_functionArr) {
       _functionArr = @[
                   @"蓝牙搜索",
                   @"设备连接",
                   @"断开连接",
                   @"登陆操作",
                   @"获取设备信息",
                   @"同步时间",
                   @"用户信息",
                   @"语言",
                   @"单位设置",
                   @"目标设定",
                   @"同步数据",
                   @"计步",
                   @"睡眠",
                   @"心率",
                   @"温度",
                   @"查询电量",
                   @"通知开关",
                   @"来电提醒",
                   @"通知推送",
                   @"闹钟",
                   @"心率自动检测",
                   @"久坐提醒",
                   @"亮屏设置",
                   @"倒计时",
                   @"查找手机",
                   @"固体升级",
                   @"血氧",
                   @"运动",
                   @"天气",
                   @"遥控拍照",
                   @"音乐控制",
                   @"亮屏时长",
                   @"开关设置",
                   @"蓝牙拨号",
                   @"通讯录",
                   @"音频蓝牙配对",
                   @"在线表盘",
                   @"表盘下载/切换/删除",
                   @"运动记录",
                   @"语音助手",
                   @"时间制式"
                ];
   }
   return _functionArr;
}

- (UITableView *)tableView {
   if (!_tableView) {
       _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
       [_tableView registerNib:[UINib nibWithNibName:@"ActionListViewControllerTableViewCell" bundle:nil] forCellReuseIdentifier:@"ActionListViewControllerTableViewCell"];
       _tableView.delegate = self;
       _tableView.dataSource = self;
       _tableView.rowHeight = 50;
   }
   return _tableView;
}


@end
