//
//  NoticeViewController.m
//  JWBleDemo
//
//  Created by Bo 黄 on 2019/8/8.
//  Copyright © 2019 wosmart. All rights reserved.
//

#import "NoticeViewController.h"
#import "NoticeTableViewCell.h"

@interface NoticeViewController ()
<
    UITableViewDataSource,
    UITableViewDelegate
>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, strong) NSArray *textArr;
@property(nonatomic, strong) NSArray *enumArr;
@property(nonatomic, strong) NSMutableArray *statusArr;

@end

@implementation NoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"notification", nil);
    
    [self setUpView];
    
    [self getDeviceValue:false];
}

- (void)setUpView {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"NoticeTableViewCell" bundle:nil] forCellReuseIdentifier:@"NoticeTableViewCell"];
    self.tableView.rowHeight = 54;
}

- (void)getDeviceValue:(BOOL)showHud {
    [self.statusArr removeAllObjects];
    if (showHud) {
        [MBProgressHUD showHUDAddedTo:self.view animated:true];
    }
     
    __weak __typeof(self)weakSelf = self;
    [JWBleAction jwGetNotiStatusWithCallBack:^(JWBleCommunicationStatus status, NSDictionary *dic) {
        if (status == JWBleCommunicationStatus_Success) {
            
//            Batch set to fully open
//            NSMutableDictionary *deviceDic = [NSMutableDictionary new];
//            NSArray *allKeys = [dic allKeys];
//            for (int i = 0; i < allKeys.count; i++) {
//                [deviceDic setObject:@(true) forKey:[NSString stringWithFormat:@"%@",allKeys[i]]];
//            }
//            [JWBleAction jwOneTimeUpdateNotiStatus:deviceDic callBack:^(JWBleCommunicationStatus status) {
//                NSLog(@"..");
//            }];
//            return;
            
            NSArray *deviceMessageNotiAvailableArr = self.enumArr;
            for (int i = 0; i < deviceMessageNotiAvailableArr.count; i++) {
                NSInteger jwType = [deviceMessageNotiAvailableArr[i] integerValue];;
                
                id value = [dic objectForKey:@(jwType)];
                if (value) {
                    BOOL open = [[dic objectForKey:@(jwType)] boolValue];
                    [weakSelf.statusArr addObject:@(open)];
                }
            }
            [weakSelf.tableView reloadData];
            
            if (showHud) {
                [MBProgressHUD hideHUDForView:self.view animated:true];
            }
        }
        
        if (status == JWBleCommunicationStatus_Busy) {
            [weakSelf.view makeToast:NSLocalizedString(@"Syncing data, please do it later", nil)];
        }
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.textArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NoticeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NoticeTableViewCell"];
    cell.lb.text = self.textArr[indexPath.row];
    if (self.statusArr.count == self.textArr.count) {
        cell.switchView.on = [self.statusArr[indexPath.row] boolValue];
    }
    cell.rowIndex = indexPath.row;
    
    cell.noticeSwitchChangedBlock = ^(NSInteger rowIndex, BOOL open) {
        NSInteger jwType = [self.enumArr[rowIndex] integerValue];
        
        __weak __typeof(self)weakSelf = self;
        [JWBleAction jwUpdateNotiStatus:jwType
                           open:open
                       callBack:^(JWBleCommunicationStatus status) {
                 weakSelf.statusArr[rowIndex] = open ? @(1):@(0);
           [MBProgressHUD hideHUDForView:weakSelf.view animated:true];
            
            if (status == JWBleCommunicationStatus_Busy) {
                [weakSelf.view makeToast:NSLocalizedString(@"Syncing data, please do it later", nil)];
            }
            
            [JWBleAction jwGetNotiStatusWithCallBack:^(JWBleCommunicationStatus status, NSDictionary *dic) {
                if (status == JWBleCommunicationStatus_Busy) {
                    [weakSelf.view makeToast:NSLocalizedString(@"Syncing data, please do it later", nil)];
                }
            }];
        }];
    };
    
    return cell;
}

#pragma mark - getter
- (NSArray *)textArr {
    if (!_textArr) {
        _textArr = @[
                @"Call",
                @"QQ",
                @"WeChat",
                @"SMS",
                @"Line",
                @"Twitter",
                @"Facebook",
                @"Messenger",
                @"WhatsApp",
                @"LinkedIn",
                @"Instagram",
                @"Skype",
                @"Viber",
                @"KakaoTalk",
                @"VKontakte",
                @"AppleMail",
                @"AppleCalendar",
                @"AppleFacetime",
                
                @"Messenger",
                @"Tim",
                @"Gmail",
                @"DingTalkPlus",
                @"WorkWechat",
                @"A+",
                @"Beike",
                @"Lianjia",
                @"LINK",
                @"Other"
            ];
    }
    return _textArr;
}

- (NSArray *)enumArr {
    if (!_enumArr) {
        _enumArr = @[
        
            @(JWBleNotiEnum_Call),
            @(JWBleNotiEnum_QQ),
            @(JWBleNotiEnum_WeChat),
            @(JWBleNotiEnum_SMS),
            @(JWBleNotiEnum_Line),
            @(JWBleNotiEnum_Twitter),
            @(JWBleNotiEnum_Facebook),
            @(JWBleNotiEnum_Messenger),
            @(JWBleNotiEnum_WhatsApp),
            @(JWBleNotiEnum_LinkedIn),
            @(JWBleNotiEnum_Instagram),
            @(JWBleNotiEnum_Skype),
            @(JWBleNotiEnum_Viber),
            @(JWBleNotiEnum_KakaoTalk),
            @(JWBleNotiEnum_VKontakte),
            @(JWBleNotiEnum_AppleMail),
            @(JWBleNotiEnum_AppleCalendar),
            @(JWBleNotiEnum_AppleFacetime),
            
            @(JWBleNotiEnum_Messenger),
            @(JWBleNotiEnum_Tim),
            @(JWBleNotiEnum_Gmail),
            @(JWBleNotiEnum_DingTalkPlus),
            @(JWBleNotiEnum_WorkWechat),
            @(JWBleNotiEnum_APlus),
            @(JWBleNotiEnum_Beike),
            @(JWBleNotiEnum_Lianjia),
            @(JWBleNotiEnum_LINK),
            @(JWBleNotiEnum_Other)
        ];
    }
    return _enumArr;
}

- (NSMutableArray *)statusArr {
    if (!_statusArr) {
        _statusArr = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _statusArr;
}

@end
