//
//  ActionListViewController.m
//  CoreBluetoothDemo
//
//  Created by Bo 黄 on 2019/2/15.
//  Copyright © 2019 Jone. All rights reserved.
//

#import "ActionListViewController.h"
#import "ActionListViewControllerTableViewCell.h"
#import "TimeActionViewController.h"
#import "ContinuousHRViewController.h"
#import "TurnWristViewController.h"
#import "SedentaryReminderViewController.h"
#import "TimeThemeViewController.h"
#import "LanguageViewController.h"
#import "NotDisturbViewController.h"
#import "NoticeViewController.h"
#import "AlarmClockViewController.h"
#import "TestHRViewController.h"
#import "TestHeadsetViewController.h"
#import "GetDeviceDataViewController.h"
#import "CheckFunctionViewController.h"
#import "TestTemperatureViewController.h"
#import "HiddenFunctionActionViewController.h"
#import "HRSwitchViewController.h"
#import "ContinuousBPViewController.h"
#import "CustomizeMainInterfaceViewController.h"
#import "UpdateInterfaceColorViewController.h"
#import "OtaActionViewController.h"
#import "ImageOtaViewController.h"
#import "CustomSetPluseViewController.h"
#import "SaunaViewController.h"
#import "V7_GT7D_ActionListViewController.h"

#import "ScanViewController.h"
#import "SyncTimeViewController.h"
#import "SyncUserInfoViewController.h"
#import "SyncUnitViewController.h"
#import "SyncTargetViewController.h"
#import "SyncDataViewController.h"

@interface ActionListViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource
>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSArray *functionArr;

@end

@implementation ActionListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"function list", nil);
    [self.view addSubview:self.tableView];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.functionArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ActionListViewControllerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActionListViewControllerTableViewCell"];
    cell.titleLB.text = NSLocalizedString(self.functionArr[indexPath.row], nil);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
   NSString *actionStr = NSLocalizedString(self.functionArr[indexPath.row], nil);
   
   if ([actionStr isEqualToString:NSLocalizedString(@"蓝牙搜索", nil)]) {
       [self.navigationController pushViewController:[ScanViewController new] animated:true];
   } else if ([actionStr isEqualToString:@"设备连接"]) {
       [self.navigationController pushViewController:[ScanViewController new] animated:true];
   } else if ([actionStr isEqualToString:@"断开连接"]) {
       //解绑、会清除设备数据
       [JWBleAction jwDisConnect];
       
       //断开链接，不会清除设备数据
       [JWBleAction jwDisConnectNotUnBond];
   } else if ([actionStr isEqualToString:@"同步时间"]) {
       [self.navigationController pushViewController:[SyncTimeViewController new] animated:true];
   } else if ([actionStr isEqualToString:@"用户信息"]) {
       [self.navigationController pushViewController:[SyncUserInfoViewController new] animated:true];
   } else if ([actionStr isEqualToString:@"语言"]) {
       [self.navigationController pushViewController:[LanguageViewController new] animated:true];
   } else if ([actionStr isEqualToString:@"单位设置"]) {
       [self.navigationController pushViewController:[SyncUnitViewController new] animated:true];
   } else if ([actionStr isEqualToString:@"目标设定"]) {
       [self.navigationController pushViewController:[SyncTargetViewController new] animated:true];
   } else if ([actionStr isEqualToString:@"同步数据"]) {
       [self.navigationController pushViewController:[SyncDataViewController new] animated:true];
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
       
       //血氧自动监测,不支持设置间隔，如需设置间隔，请联系商务提供，固件写死
       [JWBleAction jwContinuousBloodOxygenAction:false open:true callBack:^(JWBleCommunicationStatus status, BOOL open) {
           
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
       
       //1: 添加闹钟（最多添加8个）
       JWBleAlarmClockModel *model = [[JWBleAlarmClockModel alloc] init];
       
       // 2023-06-16 11:20
       model.year = 2023 - 2000;
       model.month = 6;
       model.day = 16;
       model.hour = 11;
       model.minute = 20;
       model.content = @"闹钟";
       
       //content 最大长度
       if ([self getStringLenthOfBytes:model.content] > 15) {
           model.content = [self subBytesOfstringToIndex:15 str:model.content];
       }
       
       // 周1、3、5、7重复（year、month、day可为0）
       {
           model.repeatWeekArr = @[@(1),@(0),@(1),@(0),@(1),@(0),@(1)];
       }
       // 不重复
       {
           model.repeatWeekArr = @[@(0),@(0),@(0),@(0),@(0),@(0),@(0)];
       }
       [JWBleAction jwAlarmV2Action:false alarmModel:model callBack:^(JWBleCommunicationStatus status, NSArray<JWBleAlarmClockModel *> *alarmArr) {
       }];
       
       
       //2：获取闹钟
       [JWBleAction jwAlarmV2Action:true alarmModel:nil callBack:^(JWBleCommunicationStatus status, NSArray<JWBleAlarmClockModel *> *alarmArr) {
           if (alarmArr.count == 8) {
               // 这里要限制 8个后 不允许新增
           }
       }];
       
       //3: 删除闹钟(闹钟有idd，找到那个idd所属的闹钟，并且设置月 日 重复为空)
       {
           JWBleAlarmClockModel *model = nil;//self.dataArray[indexPath.row];
           model.month = 0;
           model.day = 0;
           model.repeatWeekArr = @[];
           
           [JWBleAction jwAlarmV2Action:false alarmModel:model callBack:^(JWBleCommunicationStatus status, NSArray<JWBleAlarmClockModel *> *alarmArr) {
               if (status == JWBleCommunicationStatus_Success) {
                   
               }
           }];
       }
       
   } else if ([actionStr isEqualToString:@"心率自动检测"]) {
       //open： 开、关
       //timeSpan：固定传1
       [JWBleAction jwHrAutomaticDetectionAction:false open:true timeSpan:1 callBack:^(JWBleCommunicationStatus status, BOOL open, int timeSpan) {
           
       }];
   } else if ([actionStr isEqualToString:@"久坐提醒"]) {
       /**
        久坐提醒 Sedentary reminder
        
        @param isGet 是否获取 Whether to get
        @param open 开启、关闭 switch on switch off
        @param startH 开始小时 Start hour 0~23
        @param endH 结束小时 End hour 0~23
        @param span 间隔【30~240】（分钟） Interval【30~240】(minutes)
        @param threshold 阈值（在设定的时间段内，没有 xxx 步数即提醒）【0~65535】 Threshold (in the set time period, there is no xxx steps to remind)【0~65535】
        @param dayFlagArr 周重复【周一,周二,周三,周四.....周日】重复为true，不重复为false  Week repeat [Monday, Tuesday, Wednesday, Thursday... Sunday] Repeat is true, not repeat is false
        @param callBack 回调 Callback
        */
       NSArray *dayFlagArr = @[@(1),@(1),@(1),@(1),@(1),@(1),@(1)];//改设备不支持改变，固定传全1即可
       [JWBleAction jwSedentaryReminder:false
                           open:true
                         startH:0
                           endH:23
                           span:50
                      threshold:200
                     dayFlagArr:dayFlagArr
                       callBack:^(JWBleCommunicationStatus status, BOOL open, int startH, int endH, int span, int threshold, NSArray *dayFlagArr) {
                  
       }];
   } else if ([actionStr isEqualToString:@"亮屏设置"]) {
       /**
        转腕亮屏 Turn wrist bright screen
        
        @param isGet 是否获取 Whether to get
        @param open 是否开启 Whether to open
        @param sensitivity 灵敏度 Sensitivity
        @param startMinute 开始分钟 Start minute
        @param endMinute 结束分钟 End minute
        @param callBack 回调 Callback
        */
       
       //该设备，只支持 开、关
       [JWBleAction jwTurnWristCreenActionWithIsGet:false open:true sensitivity:0 startMinute:0 endMinute:0 callBack:^(JWBleCommunicationStatus status, BOOL open, int sensitivity, int startMinute, int endMinute) {
           
       }];
   } else if ([actionStr isEqualToString:@"倒计时"]) {
       //设置倒计时
       {
           JWCountDownModel *model = [JWCountDownModel new];
           model.optionEnum = JWCountDownOptionEnum_Setting;
           model.open = true;//显示在手环ui上
           model.seconds = 30;//30秒
           [JWBleAction jwCountDownAction:false model:model callBack:^(JWBleCommunicationStatus status, JWCountDownModel *countDownModel) {
               
           }];
       }
       
       //获取设备当前倒计时状态
       {
           [JWBleAction jwCountDownAction:true model:nil callBack:^(JWBleCommunicationStatus status, JWCountDownModel *countDownModel) {
               if (status == JWBleCommunicationStatus_Success) {
                   
                   if (countDownModel.optionEnum == JWCountDownOptionEnum_Start) {
                       //倒计时中
                   } else if (countDownModel.optionEnum == JWCountDownOptionEnum_Setting) {
                       // 倒计时配置
                   }
               } else {
                   //获取常用时长失败
               }
           }];
       }
       
       //开启设备倒计时
       {
           JWCountDownModel *model = [JWCountDownModel new];
           model.optionEnum = JWCountDownOptionEnum_Start;
           model.open = true;//显示在手环ui上
           model.seconds = 30;//30秒
           [JWBleAction jwCountDownAction:false model:model callBack:^(JWBleCommunicationStatus status, JWCountDownModel *countDownModel) {
               
           }];
       }
       
   } else if ([actionStr isEqualToString:@"查找手机"]) {
       JWBleManager.findPhoneV2CallBack = ^(BOOL start) {
           if (start) {
               //设备正在查找
           } else {
               //设备停止
           }
       };
   } else if ([actionStr isEqualToString:@"固体升级"]) {
       [self.navigationController pushViewController:[OtaActionViewController new] animated:true];
   } else if ([actionStr isEqualToString:@"运动"]) {
       // sdk 不支持开启 设备运动
   } else if ([actionStr isEqualToString:@"天气"]) {
       JWBleWeatherModel *weatherModel = [JWBleWeatherModel new];
       weatherModel.open = true;
       
       //当天天气
       {
           JWBleCurWeatherModel *curWeatherModel = [JWBleCurWeatherModel new];
           curWeatherModel.year = 2023;
           curWeatherModel.month = 6;
           curWeatherModel.day = 6;
           
           curWeatherModel.cityStr = @"shenzhen";//最长33个bytes;
           curWeatherModel.weatherCode = JWBleWeatherCode_Sunny;
           curWeatherModel.maxTemp = 37;
           curWeatherModel.minTemp = 16;
           curWeatherModel.temp = 25;
           //湿度、紫外线、pm 目前没有数值限制范围 都可为0
           curWeatherModel.humidity = 23;
           curWeatherModel.uv = 23;
           curWeatherModel.pm = 0;
           weatherModel.curWeatherModel = curWeatherModel;
       }
       
       //未来天气，manx6，可为空
       NSMutableArray<JWBleFutureWeatherModel *> *futureWeatherArr = [NSMutableArray new];
       for (int i = 0; i < 6; i++) {
           JWBleFutureWeatherModel *futureModel = [JWBleFutureWeatherModel new];
           futureModel.weatherCode = JWBleWeatherCode_Sunny;
           futureModel.maxTemp = 37;
           futureModel.minTemp = 16;
           [futureWeatherArr addObject:futureModel];
       }
       
       weatherModel.futureWeatherArr = [futureWeatherArr mutableCopy];
       
       [JWBleAction jwWeatherAction:weatherModel callBack:^(JWBleCommunicationStatus status) {
                               
       }];
   } else if ([actionStr isEqualToString:@"遥控拍照"]) {
       //设备进入拍照模式
       [JWBleAction jwRemotePhotography:true callBack:nil];
       
       //监听拍照回调
       JWBleManager.remotePhotographyCallBack = ^(JWBleRemotePhotographyStatus remotePhotographyStatus) {
           if (remotePhotographyStatus == JWBleRemotePhotographyStatus_TakePhoto) {
               
           }
       };
   } else if ([actionStr isEqualToString:@"音乐控制"]) {
       //ios 不需要调
   } else if ([actionStr isEqualToString:@"亮屏时长"]) {
       /**
        亮屏控制功能 Bright screen control function
        
        @param isGet 是否获取 Whether to get
        @param timeLength 亮屏时长 3~30秒 Bright screen duration 3~30 seconds
        @param callBack 回调 Callback
        */
       [JWBleAction jwbBrightScreenDuration:false timeLength:15 callBack:^(JWBleCommunicationStatus status, int timeLength, int defalut) {
           
       }];
   } else if ([actionStr isEqualToString:@"开关设置"]) {
       //需要什么开关
   } else if ([actionStr isEqualToString:@"蓝牙拨号"]) {
       //ios 走ancs 不需要调
   } else if ([actionStr isEqualToString:@"通讯录"]) {
       
       NSMutableArray *syncArr = [NSMutableArray new];
       for (int i = 0; i < 20; i++) {
           [syncArr addObject:@{
               @"name": @"zhangsan", //最多15个UTF8
               @"phone": @"13688888888" //最多19个UTF8
           }];
       }
       
       __weak __typeof(self)weakSelf = self;
       [JWBleAction jwSyncContacts:[syncArr mutableCopy] callBack:^(JWBleCommunicationStatus status, int index) {
           index += 1;
           float progress = index / (float)syncArr.count;
           NSString *progressStr = [NSString stringWithFormat:@"%@%.0f%%",NSLocalizedString(@"同步中", nil), progress * 100];
           
           NSLog(@"%d \t %f", index, progress);
           
           if (index == syncArr.count) {
               NSLog(@"success");
           }
       }];
       
   } else if ([actionStr isEqualToString:@"音频蓝牙配对"]) {
       // 1: 音频蓝牙状态监听
       JWBleManager.connectStateChangeCallBack = ^(JWBleDeviceConnectStatus deviceConnectStatus) {
           if (deviceConnectStatus == JWBleDeviceConnectStatus_HeadphoneDeviceStatusChanged) {
               //耳机状态
               int headphoneDeviceStatus = JWBleManager.connectionModel.headphoneDeviceStatus;
               //配对状态
               int headsetPaired = JWBleManager.connectionModel.headsetPaired;
           }
       };
       
       // 2: 弹出 仿苹果弹窗，30秒可认为超时
       [JWBleAction jwHeadphonePairing];
       
       // 3: 取消 仿苹果弹窗
       [JWBleAction jwCancelHeadphonePairing];
   } else if ([actionStr isEqualToString:@"内置/下载/自定义表盘"]) {
       [self.navigationController pushViewController:[CustomizeMainInterfaceViewController new] animated:true];
   } else if ([actionStr isEqualToString:@"运动记录"]) {
       
       //获取历史数据，必须先同步设备数据至sdk中 [JWBleDataAction jwSyncDataWithCallBack:];
       
       NSString *dayStr = @"20180911";//yyyyMMdd
       //以天获取
       [JWBleDataAction jwGetMotionDataByYYYYMMDDStr:dayStr callBack:^(NSArray *dataArr) {
           /**
            dataArr: 返回值解析
            @[
               @{
                    @"pk" //Primary key
                    @"year": 2019
                    @"month": 9
                    @"day": 7
                    @"minuteIndex": 995
                    @"seconds": 19
                    @"motionType": sports type (JWBleDeviceMotionEnum)
                    @"sportsMinute": minutes of exercise time
                    @"sportsSeconds": the number of seconds of exercise time
                    @"pauseCount": number of pauses
                    @"pauseMinute": Pause minutes
                    @"pauseSeconds": Pause seconds
                    @"stepCount": number of exercise steps
                    @"distance": Movement distance in meters
                    @"uid": user id
                    @"calories": calories burned per unit card
                },
               @{
                   ...
               }
            ]
            */
       }];
       
   } else if ([actionStr isEqualToString:@"语音助手"]) {
       bool showInDevice = true;
       [JWBleAction jwUpdateHideFunction:JWBleFunctionEnum_VoiceAssistant open:showInDevice callBack:^(JWBleCommunicationStatus status) {

       }];
   } else if ([actionStr isEqualToString:@"时间制式"]) {
       //1: 小时制
       bool show12 = false;
       [JWBleAction jwCommonFunction:JWBleFunctionEnum_TimeSystem functionsState:show12 ? JWBleCommonFunctionsStatus_Open : JWBleCommonFunctionsStatus_Close callBack:^(JWBleCommunicationStatus communicationStatus, JWBleCommonFunctionsStatus functionStatus) {
       }];
   }
}

//
///**
// @param tableView tableView description
// @param indexPath indexPath description
// */
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    NSString *actionStr = NSLocalizedString(self.functionArr[indexPath.row], nil);
//
//    __weak __typeof(self)weakSelf = self;
//    if ([actionStr isEqualToString:NSLocalizedString(@"Synchronize personal information", nil)]) {
//
//        [self.view makeToast:NSLocalizedString(@"Setting Gender: Male, Age: 18, Height: 60.5cm, Weight: 75.5kg", nil)];
//
//        [MBProgressHUD showHUDAddedTo:self.view animated:true];
//        [JWBleAction jwSynchronizePersonalInformation:18 isMan:true height:60.5 weight:75.5 callBack:^(JWBleCommunicationStatus status) {
//            [MBProgressHUD hideHUDForView:weakSelf.view animated:true];
//            [weakSelf.view makeToast:[JWBleDemoHelp communication2Str:status]];
//        }];
//
//    } else if ([actionStr isEqualToString:NSLocalizedString(@"Set step goal", nil)]) {
//
//        [self.view makeToast:NSLocalizedString(@"Setting goals: 1000 steps", nil)];
//
//        [MBProgressHUD showHUDAddedTo:self.view animated:true];
//        [JWBleAction jwSetStepTargetAction:10000 callBack:^(JWBleCommunicationStatus status) {
//            [MBProgressHUD hideHUDForView:weakSelf.view animated:true];
//            [weakSelf.view makeToast:[JWBleDemoHelp communication2Str:status]];
//        }];
//
//    } else if ([actionStr isEqualToString:NSLocalizedString(@"Set sleep goals", nil)]) {
//
//        [self.view makeToast:NSLocalizedString(@"Setting goal: 6 hours", nil)];
//
//        [MBProgressHUD showHUDAddedTo:self.view animated:true];
//        [JWBleAction jwSetSleepTargetAction:6*60 callBack:^(JWBleCommunicationStatus status) {
//            [MBProgressHUD hideHUDForView:weakSelf.view animated:true];
//            [weakSelf.view makeToast:[JWBleDemoHelp communication2Str:status]];
//        }];
//
//    } else if ([actionStr isEqualToString:NSLocalizedString(@"Find bracelet", nil)]) {
//        [JWBleAction jwFindDeviceWithCallBack:^(JWBleCommunicationStatus status) {
//            [weakSelf.view makeToast:[JWBleDemoHelp communication2Str:status]];
//        }];
//    } else if ([actionStr isEqualToString:NSLocalizedString(@"Open the remote camera", nil)]) {
//        [MBProgressHUD showHUDAddedTo:self.view animated:true];
//
//        [JWBleAction jwRemotePhotography:true callBack:^(JWBleCommunicationStatus status) {
//            [MBProgressHUD hideHUDForView:weakSelf.view animated:true];
//        }];
//
//        [self.view makeToast:NSLocalizedString(@"If shaking the bracelet has no effect, do some other operations first", nil)];
//
//        JWBleManager.remotePhotographyCallBack = ^(JWBleRemotePhotographyStatus remotePhotographyStatus) {
//            if (remotePhotographyStatus == JWBleRemotePhotographyStatus_TakePhoto) {
//                [weakSelf.view makeToast:NSLocalizedString(@"Photo callback", nil)];
//            }
//        };
//    } else if ([actionStr isEqualToString:NSLocalizedString(@"Turn off the remote camera", nil)]) {
//        [MBProgressHUD showHUDAddedTo:self.view animated:true];
//        [JWBleAction jwRemotePhotography:false callBack:^(JWBleCommunicationStatus status) {
//            [MBProgressHUD hideHUDForView:weakSelf.view animated:true];
//            [weakSelf.view makeToast:[JWBleDemoHelp communication2Str:status]];
//        }];
//    } else if ([actionStr isEqualToString:NSLocalizedString(@"Continuous heart rate monitoring", nil)]) {
//        [self.navigationController pushViewController:[ContinuousHRViewController new] animated:true];
//    } else if ([actionStr isEqualToString:NSLocalizedString(@"Turn the wrist bright screen-bright screen duration", nil)]) {
//        [self.navigationController pushViewController:[TurnWristViewController new] animated:true];
//    } else if ([actionStr isEqualToString:NSLocalizedString(@"Sedentary reminder", nil)]) {
//        [self.navigationController pushViewController:[SedentaryReminderViewController new] animated:true];
//    } else if ([actionStr isEqualToString:NSLocalizedString(@"Hour System-Metric and Imperial", nil)]) {
//        [self.navigationController pushViewController:[TimeThemeViewController new] animated:true];
//    } else if ([actionStr isEqualToString:NSLocalizedString(@"Language", nil)]) {
//        [self.navigationController pushViewController:[LanguageViewController new] animated:true];
//    } else if ([actionStr isEqualToString:NSLocalizedString(@"Do not disturb mode", nil)]) {
//        [self.navigationController pushViewController:[NotDisturbViewController new] animated:true];
//    } else if ([actionStr isEqualToString:NSLocalizedString(@"notification", nil)]) {
//        [self.navigationController pushViewController:[NoticeViewController new] animated:true];
//    } else if ([actionStr isEqualToString:NSLocalizedString(@"Alarm setting", nil)]) {
//        [self.navigationController pushViewController:[AlarmClockViewController new] animated:true];
//    } else if ([actionStr isEqualToString:NSLocalizedString(@"Test heart rate", nil)]) {
//        [self.navigationController pushViewController:[TestHRViewController new] animated:true];
//    } else if ([actionStr isEqualToString:NSLocalizedString(@"Test blood pressure", nil)]) {
//        TestHRViewController *vc = [TestHRViewController new];
//        vc.testBP = true;
//        [self.navigationController pushViewController:vc animated:true];
//    } else if ([actionStr isEqualToString:NSLocalizedString(@"Test headphones", nil)]) {
//        [self.navigationController pushViewController:[TestHeadsetViewController new] animated:true];
//    } else if ([actionStr isEqualToString:NSLocalizedString(@"Get bracelet data", nil)]) {
//        [self.navigationController pushViewController:[GetDeviceDataViewController new] animated:true];
//    } else if ([actionStr isEqualToString:NSLocalizedString(@"Check if there is a function", nil)]) {
//        [self.navigationController pushViewController:[CheckFunctionViewController new] animated:true];
//    } else if ([actionStr isEqualToString:NSLocalizedString(@"Temperature correlation", nil)]) {
//        [self.navigationController pushViewController:[TestTemperatureViewController new] animated:true];
//    } else if ([actionStr isEqualToString:NSLocalizedString(@"Bracelet function display and hide", nil)]) {
//        [self.navigationController pushViewController:[HiddenFunctionActionViewController new] animated:true];
//    } else if ([actionStr isEqualToString:NSLocalizedString(@"Heart rate switch", nil)]) {
//        [self.navigationController pushViewController:[HRSwitchViewController new] animated:true];
//    } else if ([actionStr isEqualToString:NSLocalizedString(@"Continuous blood pressure", nil)]) {
//        [self.navigationController pushViewController:[ContinuousBPViewController new] animated:true];
//    } else if ([actionStr isEqualToString:NSLocalizedString(@"Customize the main interface", nil)]) {
//        [self.navigationController pushViewController:[CustomizeMainInterfaceViewController new] animated:true];
//    } else if ([actionStr isEqualToString:NSLocalizedString(@"Update Interface Color", nil)]) {
//        [self.navigationController pushViewController:[UpdateInterfaceColorViewController new] animated:true];
//    } else if ([actionStr isEqualToString:NSLocalizedString(@"OTA", nil)]) {
//        [self.navigationController pushViewController:[OtaActionViewController new] animated:true];
//    } else if ([actionStr isEqualToString:NSLocalizedString(@"Image OTA", nil)]) {
//        [self.navigationController pushViewController:[ImageOtaViewController new] animated:true];
//    } else if ([actionStr isEqualToString:NSLocalizedString(@"Custom Set Pulse/SleepAid", nil)]) {
//        [self.navigationController pushViewController:[CustomSetPluseViewController new] animated:true];
//    } else if ([actionStr isEqualToString:NSLocalizedString(@"Sauna Data", nil)]) {
//        [self.navigationController pushViewController:[SaunaViewController new] animated:true];
//    } else if ([actionStr isEqualToString:NSLocalizedString(@"V7(GT7D) ActionList", nil)]) {
//        [self.navigationController pushViewController:[V7_GT7D_ActionListViewController new] animated:true];
//    }
//
//}

#pragma mark - getter
- (NSArray *)functionArr {
    if (!_functionArr) {
        _functionArr = @[
            @"蓝牙搜索",
            @"设备连接",
            @"断开连接",
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
            @"内置/下载/自定义表盘",
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

#pragma mark - help
- (NSInteger)getStringLenthOfBytes:(NSString *)str {
    NSInteger length = 0;
    for (int i = 0; i < [str length]; i++) {
        NSString *s = [str substringWithRange:NSMakeRange(i, 1)];
        NSData *data = [s dataUsingEncoding:NSUTF8StringEncoding];
        length += data.length;
    }
    return length;
}

- (NSString *)subBytesOfstringToIndex:(NSInteger)index str:(NSString *)str {
    NSInteger length = 0;
    
    for (int i = 0; i < [str length]; i++) {
        NSString *s = [str substringWithRange:NSMakeRange(i, 1)];
        NSData *data = [s dataUsingEncoding:NSUTF8StringEncoding];
        
        if (length + data.length > index) {
            return [str substringToIndex:i];
        }
        
        length += data.length;
    }
    
    return [str substringToIndex:index];
}

@end
