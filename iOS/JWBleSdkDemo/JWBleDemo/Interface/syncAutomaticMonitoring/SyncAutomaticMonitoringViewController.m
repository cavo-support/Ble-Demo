//
//  SyncAutomaticMonitoringViewController.m
//  JWBleDemo
//
//  Created by bobobo on 2023/6/21.
//  Copyright © 2023 wosmart. All rights reserved.
//

#import "SyncAutomaticMonitoringViewController.h"
#import "WFJWDeviceFunctionModel.h"
#import "SyncAutomaticMonitoringTableViewCell.h"

@interface SyncAutomaticMonitoringViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource
>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSArray<WFJWDeviceFunctionModel *> *dataArr;
@property(nonatomic, strong) NSMutableDictionary *sectionViewDic;

@end

@implementation SyncAutomaticMonitoringViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"SyncAutomaticMonitoring";
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self getDeviceHRType];
}

- (void)getDeviceHRType {
    
    [MBProgressHUD showHUDAddedTo:self.view animated:true];
    __weak __typeof(self)weakSelf = self;
    [JWBleAction jwGetHRAutomaticDetectionType:^(JWBleCommunicationStatus status, NSDictionary *resultDic) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:true];
        if (status == JWBleCommunicationStatus_Success) {
            weakSelf.dataArr = [WFJWDeviceFunctionModel getArrWithDeviceResult:resultDic];
            [weakSelf.tableView reloadData];
        }
    }];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SyncAutomaticMonitoringTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SyncAutomaticMonitoringTableViewCell"];
    cell.functionModel = self.dataArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 23)];
        _tableView.estimatedRowHeight = 100;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 15)];
        [_tableView registerNib:[UINib nibWithNibName:@"SyncAutomaticMonitoringTableViewCell" bundle:nil] forCellReuseIdentifier:@"SyncAutomaticMonitoringTableViewCell"];

    }
    return _tableView;
}

- (NSMutableDictionary *)sectionViewDic {
    if (!_sectionViewDic) {
        _sectionViewDic = [NSMutableDictionary dictionary];
    }
    return _sectionViewDic;
}

@end
