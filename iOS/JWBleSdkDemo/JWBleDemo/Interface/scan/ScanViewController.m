//
//  ScanViewController.m
//  CoreBluetoothDemo
//
//  Created by Bo 黄 on 2019/2/13.
//  Copyright © 2019 Jone. All rights reserved.
//

#import "ScanViewController.h"
#import "ScanViewControllerTableViewCell.h"
#import "ScanFilterView.h"
#import "MJRefresh.h"

@interface ScanViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource
>

@property(nonatomic, strong) NSMutableArray *scanDeviceArr;
@property(nonatomic, strong) UIButton *scanBtn;
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) ScanFilterView *filterView;
@property(nonatomic, strong) ScanFilterRecordModel *filterRecordModel;

@end

@implementation ScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNav];
    [self.view addSubview:self.filterView];
    [self.view addSubview:self.tableView];
    
    if (@available(iOS 11, *) == false) {
        [self.filterView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(@(64));
            make.height.equalTo(@(120));
        }];
    } else {
        [self.filterView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.view);
            make.height.equalTo(@(200));
        }];
    }
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.filterView.mas_bottom);
        make.bottom.left.right.equalTo(self.view);
    }];
}

- (void)setUpNav {
    self.scanBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.scanBtn setTitle:NSLocalizedString(@"scanning", nil) forState:UIControlStateNormal];
    [self.scanBtn addTarget:self action:@selector(clickScanBtn) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:self.scanBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.title = NSLocalizedString(@"Scanning equipment", nil);
}

- (void)clickScanBtn {
    self.scanDeviceArr = nil;
    
    __weak __typeof(self)weakSelf = self;
    [JWBleAction jwStartScanDeviceWithCallBack:^(JWBleDeviceModel *deviceModel) {
        
        if (weakSelf.scanDeviceArr.count > 99) {
            return ;
        }
        
        
        if (deviceModel.rssi.integerValue == 127 || deviceModel.deviceName == NULL) {
            return;
        }
        
        BOOL hasNew = false;
        if (deviceModel.rssi.intValue > (-weakSelf.filterRecordModel.rssi)) {
            if (weakSelf.filterRecordModel.name == nil || [weakSelf.filterRecordModel.name isEmpty]) {
                hasNew = true;
            } else if ([[deviceModel.deviceName uppercaseString] containsString:[weakSelf.filterRecordModel.name uppercaseString]]) {
                hasNew = true;
            }
        }
        
        if (hasNew) {
            [weakSelf.scanDeviceArr addObject:deviceModel];
            
            //排序
            NSArray *result = [weakSelf.scanDeviceArr sortedArrayUsingComparator:^NSComparisonResult(JWBleDeviceModel* obj1, JWBleDeviceModel* obj2) {
                return [obj2.rssi compare:obj1.rssi]; //降序
            }];
            weakSelf.scanDeviceArr = [result mutableCopy];
            [weakSelf.tableView reloadData];
        }
        
    }];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.scanDeviceArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ScanViewControllerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ScanViewControllerTableViewCell"];
    cell.deviceModel = self.scanDeviceArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [MBProgressHUD showHUDAddedTo:self.view animated:true];
    [JWBleAction jwConnectDevice:self.scanDeviceArr[indexPath.row]];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view animated:true];
    });
}

#pragma mark - UITableViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:true];
}

#pragma mark - setter
- (void)setFilterRecordModel:(ScanFilterRecordModel *)filterRecordModel {
    [self.scanDeviceArr removeAllObjects];
    [self.tableView reloadData];
    
    _filterRecordModel = filterRecordModel;
    
    [self clickScanBtn];
}

#pragma mark - getter
- (NSMutableArray *)scanDeviceArr {
    if (!_scanDeviceArr) {
        _scanDeviceArr = [[NSMutableArray alloc] init];
    }
    
    return _scanDeviceArr;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        [_tableView registerNib:[UINib nibWithNibName:@"ScanViewControllerTableViewCell" bundle:nil] forCellReuseIdentifier:@"ScanViewControllerTableViewCell"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 70;
        
        __weak __typeof(self)weakSelf = self;
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf.scanDeviceArr removeAllObjects];
            [weakSelf.tableView reloadData];
            [weakSelf clickScanBtn];
            [weakSelf.tableView.mj_header endRefreshing];
        }];
    }
    return _tableView;
}

- (ScanFilterView *)filterView {
    if (!_filterView) {
        _filterView = [ScanFilterView viewFromXIB];
        __weak __typeof(self)weakSelf = self;
        _filterView.valueChangedCallBack = ^(ScanFilterRecordModel *recordModel) {
            weakSelf.filterRecordModel = recordModel;
        };
    }
    return _filterView;
}


@end
