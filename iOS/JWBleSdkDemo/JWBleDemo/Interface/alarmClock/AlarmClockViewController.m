//
//  AlarmClockViewController.m
//  CoreBluetoothDemo
//
//  Created by Bo 黄 on 2019/3/5.
//  Copyright © 2019 Jone. All rights reserved.
//

#import "AlarmClockViewController.h"
#import "AlarmClockAddViewController.h"
#import "DemoAlarmClockModel.h"
#import "AlarmClockTableViewCell.h"

@interface AlarmClockViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource
>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *addedLB;
@property(nonatomic, strong) NSArray<DemoAlarmClockModel *> *dataArr;
@property(nonatomic, strong) NSArray<JWBleAlarmClockModel *> *dataArr_V2;

@end

@implementation AlarmClockViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self getDBArr];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Alarm setting", nil);
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"AlarmClockTableViewCell" bundle:nil] forCellReuseIdentifier:@"AlarmClockTableViewCell"];
    self.tableView.estimatedRowHeight = 50;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
}

- (void)getDBArr {
    __weak __typeof(self)weakSelf = self;
    if ([JWBleAction jwCheckFunctionStates:JWBleFunctionEnum_SmartAlarmClockV2] == JWBleFunctionStateEnum_Open) {
        
        [JWBleAction jwAlarmV2Action:true alarmModel:nil callBack:^(JWBleCommunicationStatus status, NSArray<JWBleAlarmClockModel *> *alarmArr) {
            [weakSelf.view hideToastActivity];
            
            weakSelf.dataArr_V2 = alarmArr;
            [weakSelf.tableView reloadData];
            
            weakSelf.addedLB.text = [NSString stringWithFormat:@"%ld %@",weakSelf.dataArr_V2.count,NSLocalizedString(@"Alarm clocks", nil)];
        }];
    } else {
        self.dataArr = [[[DemoAlarmClockModel findAll] reverseObjectEnumerator] allObjects];
        [self.tableView reloadData];
        
        self.addedLB.text = [NSString stringWithFormat:@"%lu %@",(unsigned long)self.dataArr.count,NSLocalizedString(@"Alarm clocks", nil)];
    }
}

- (void)sync2Device {
    [self.view makeToastActivity:self];
    
    __weak __typeof(self)weakSelf = self;
    if ([JWBleAction jwCheckFunctionStates:JWBleFunctionEnum_SmartAlarmClockV2] == JWBleFunctionStateEnum_Open) {
        
        [JWBleAction jwAlarmV2Action:true alarmModel:nil callBack:^(JWBleCommunicationStatus status, NSArray<JWBleAlarmClockModel *> *alarmArr) {
            [weakSelf.view hideToastActivity];
            [weakSelf.view makeToast:[JWBleDemoHelp communication2Str:status]];
            weakSelf.dataArr_V2 = alarmArr;
        }];
    } else {
        [DemoAlarmClockModel synchronization2DeviceWithCallBack:^(JWBleCommunicationStatus status) {
            [weakSelf.view hideToastActivity];
            [weakSelf.view makeToast:[JWBleDemoHelp communication2Str:status]];
            
            [weakSelf getDBArr];
        }];
    }
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([JWBleAction jwCheckFunctionStates:JWBleFunctionEnum_SmartAlarmClockV2] == JWBleFunctionStateEnum_Open) {
        return self.dataArr_V2.count;
    } else {
        return self.dataArr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AlarmClockTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AlarmClockTableViewCell"];
    
    if ([JWBleAction jwCheckFunctionStates:JWBleFunctionEnum_SmartAlarmClockV2] == JWBleFunctionStateEnum_Open) {
        cell.clockModel_v2 = self.dataArr_V2[indexPath.row];
    } else {
        cell.clockModel = self.dataArr[indexPath.row];
    }
    
    __weak __typeof(self)weakSelf = self;
    cell.changedBlock = ^{
        [weakSelf sync2Device];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([JWBleAction jwCheckFunctionStates:JWBleFunctionEnum_SmartAlarmClockV2] == JWBleFunctionStateEnum_Open) {
        AlarmClockAddViewController *vc = [AlarmClockAddViewController new];
        vc.clockModel_v2 = self.dataArr_V2[indexPath.row];
        vc.isClock = true;
        [self.navigationController pushViewController:vc animated:true];
    } else {
        
    }
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return NSLocalizedString(@"delete", nil);
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        JWBleAlarmClockModel *model = self.dataArr_V2[indexPath.row];
        model.month = 0;
        model.day = 0;
        model.repeatWeekArr = @[];
        
        __weak __typeof(self)weakSelf = self;
        [JWBleAction jwAlarmV2Action:false alarmModel:model callBack:^(JWBleCommunicationStatus status, NSArray<JWBleAlarmClockModel *> *alarmArr) {
            [weakSelf getDBArr];
        }];
    } else {
        DemoAlarmClockModel *model = self.dataArr[indexPath.row];
        [model deleteObject];
        [self sync2Device];
    }
}

#pragma mark - action
- (IBAction)clickActionBtn:(UIButton *)sender {
    if ([JWBleAction jwCheckFunctionStates:JWBleFunctionEnum_SmartAlarmClockV2] == JWBleFunctionStateEnum_Open) {
        if (self.dataArr_V2.count == 8) {
            [self.view makeToast:@"max length = 8"];
            return;
        }
        
        // find next idd
        int nextIdd = 0;
        NSArray *idValue = @[@(0),@(1),@(2),@(3),@(4),@(5),@(6),@(7)];
        NSMutableArray *idValue2 = [@[@(false),@(false),@(false),@(false),@(false),@(false),@(false),@(false)] mutableCopy];
        for (int i = 0; i < idValue.count; i++) {
            if (i < self.dataArr_V2.count) {
                if ([idValue containsObject:@(self.dataArr_V2[i].idd)]) {
                    idValue2[self.dataArr_V2[i].idd] = @(true);
                }
            }
        }
        
        for (int i = 0; i < idValue2.count; i++) {
            if ([idValue2[i] boolValue] == false) {
                nextIdd = i;
                break;
            }
        }
        AlarmClockAddViewController *vc = [AlarmClockAddViewController new];
        vc.isClock = true;
        vc.nextIdd = nextIdd;
        [self.navigationController pushViewController:vc animated:true];
    } else {
        AlarmClockAddViewController *vc = [AlarmClockAddViewController new];
        vc.isClock = true;
        [self.navigationController pushViewController:vc animated:true];
    }
}

#pragma mark getter
- (NSArray<JWBleAlarmClockModel *> *)dataArr_V2 {
    if (!_dataArr_V2) {
        _dataArr_V2 = [NSArray new];
    }
    return _dataArr_V2;
}

@end
