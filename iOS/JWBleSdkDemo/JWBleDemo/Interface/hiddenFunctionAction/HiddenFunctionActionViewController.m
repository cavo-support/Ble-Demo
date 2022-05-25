//
//  HiddenFunctionActionViewController.m
//  JWBleDemo
//
//  Created by Bo 黄 on 2020/7/10.
//  Copyright © 2020 wosmart. All rights reserved.
//

#import "HiddenFunctionActionViewController.h"
#import "NoticeTableViewCell.h"

@interface HiddenFunctionActionViewController ()
<
    UITableViewDataSource,
    UITableViewDelegate
>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *availableFunctionsArr;

@end

@implementation HiddenFunctionActionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpView];
    [self fixAvailableFunctionsArr];
    
}

- (void)setUpView {
    self.title = NSLocalizedString(@"Bracelet function display and hide", nil);
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)fixAvailableFunctionsArr {
    
    if ([JWBleAction jwCheckHideFunctionStates:JWBleFunctionEnum_StopwatchTiming] != JWBleHideFunctionStatesEnum_NotSupport) {
        [self.availableFunctionsArr addObject:@(JWBleFunctionEnum_StopwatchTiming)];
    }
    
    if ([JWBleAction jwCheckHideFunctionStates:JWBleFunctionEnum_FindPhone] != JWBleHideFunctionStatesEnum_NotSupport) {
        [self.availableFunctionsArr addObject:@(JWBleFunctionEnum_FindPhone)];
    }
    
    if ([JWBleAction jwCheckHideFunctionStates:JWBleFunctionEnum_AutomaticLockScreen] != JWBleHideFunctionStatesEnum_NotSupport) {
        [self.availableFunctionsArr addObject:@(JWBleFunctionEnum_AutomaticLockScreen)];
    }
    
    if ([JWBleAction jwCheckHideFunctionStates:JWBleFunctionEnum_TwoButtonSliding] != JWBleHideFunctionStatesEnum_NotSupport) {
        [self.availableFunctionsArr addObject:@(JWBleFunctionEnum_TwoButtonSliding)];
    }
    
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.availableFunctionsArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NoticeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NoticeTableViewCell"];
    
    JWBleFunctionEnum typeEnum = [self.availableFunctionsArr[indexPath.row] integerValue];
    if (typeEnum == JWBleFunctionEnum_StopwatchTiming) {
        cell.lb.text = NSLocalizedString(@"Countdown", nil);
    } else if (typeEnum == JWBleFunctionEnum_FindPhone) {
        cell.lb.text = NSLocalizedString(@"Find phone", nil);
    } else if (typeEnum == JWBleFunctionEnum_AutomaticLockScreen) {
        cell.lb.text = NSLocalizedString(@"Auto lock screen", nil);
    } else if (typeEnum == JWBleFunctionEnum_TwoButtonSliding) {
        cell.lb.text = NSLocalizedString(@"Double button slide", nil);
    }
    
    cell.rowIndex = indexPath.row;
    
    cell.noticeSwitchChangedBlock = ^(NSInteger rowIndex, BOOL open) {
//        NSInteger jwType = [self.enumArr[rowIndex] integerValue];
//
//        __weak __typeof(self)weakSelf = self;
//        [JWBleAction jwUpdateNotiStatus:jwType
//                           open:open
//                       callBack:^(JWBleCommunicationStatus status) {
//                 weakSelf.statusArr[rowIndex] = open ? @(1):@(0);
//           [MBProgressHUD hideHUDForView:weakSelf.view animated:true];
//
//            if (status == JWBleCommunicationStatus_Busy) {
//                [weakSelf.view makeToast:NSLocalizedString(@"正在同步数据，请稍后操作", nil)];
//            }
//
//            [JWBleAction jwGetNotiStatusWithCallBack:^(JWBleCommunicationStatus status, NSDictionary *dic) {
//                if (status == JWBleCommunicationStatus_Busy) {
//                    [weakSelf.view makeToast:NSLocalizedString(@"正在同步数据，请稍后操作", nil)];
//                }
//            }];
//        }];
    };
    
    return cell;
}

#pragma mark - getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:@"NoticeTableViewCell" bundle:nil] forCellReuseIdentifier:@"NoticeTableViewCell"];
        _tableView.rowHeight = 54;
    }
    return _tableView;
}

- (NSMutableArray *)availableFunctionsArr {
    if (!_availableFunctionsArr) {
        _availableFunctionsArr = [NSMutableArray new];
    }
    return _availableFunctionsArr;
}


@end
