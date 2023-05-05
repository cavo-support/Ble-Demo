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
            [weakSelf.view makeToast:[JWBleDemoHelp communication2Str:status]];
            
            NSLog(@"alarmArr: %@",alarmArr);
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
            
            NSLog(@"alarmArr: %@",alarmArr);
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
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AlarmClockTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AlarmClockTableViewCell"];
    cell.clockModel = self.dataArr[indexPath.row];
    
    __weak __typeof(self)weakSelf = self;
    cell.changedBlock = ^{
        [weakSelf sync2Device];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return NSLocalizedString(@"delete", nil);
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        DemoAlarmClockModel *model = self.dataArr[indexPath.row];
        [model deleteObject];
        [self sync2Device];
    }
}

#pragma mark - action
- (IBAction)clickActionBtn:(UIButton *)sender {
    AlarmClockAddViewController *vc = [AlarmClockAddViewController new];
    if (sender.tag == 10001) {
        vc.isClock = true;
    }
    [self.navigationController pushViewController:vc animated:true];
}

@end
