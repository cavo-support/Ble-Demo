//
//  UpdateVersionFileViewController.m
//  CoreBluetoothDemo
//
//  Created by Bo 黄 on 2019/3/15.
//  Copyright © 2019 Jone. All rights reserved.
//

#import "UpdateVersionFileViewController.h"
#import "UpdateVersionFileTableViewCell.h"

@interface UpdateVersionFileViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource
>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *dataArr;
@property(nonatomic, strong) NSString *basePath;
@property(nonatomic, strong) NSString *selectedFileName;

@end

@implementation UpdateVersionFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_tableView registerNib:[UINib nibWithNibName:@"UpdateVersionFileTableViewCell" bundle:nil] forCellReuseIdentifier:@"UpdateVersionFileTableViewCell"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.estimatedRowHeight = 50;
    
    self.title = @"选择文件";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self getAllFileNames];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getAllFileNames) name:@"FileNotification" object:nil];
}

- (void)getAllFileNames {
   
    NSArray *files = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:self.basePath error:nil];
    
    self.dataArr = [files mutableCopy];
    [self.tableView reloadData];
}

- (IBAction)clickSureBtn:(id)sender {
    if (self.selectedFileName == nil || [self.selectedFileName isEmpty]) {
        [self.view makeToast:@"请选择要升级的文件"];
        return;
    }
    
    if (self.selectedFileBlock) {
        self.selectedFileBlock(self.selectedFileName);
        [self.navigationController popViewControllerAnimated:true];
    }
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UpdateVersionFileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UpdateVersionFileTableViewCell"];
    cell.contentLB.text = self.dataArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedFileName = self.dataArr[indexPath.row];
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSString *fileName = self.dataArr[indexPath.row];
        
        if (self.otaRecordModel) {
            if ([fileName isEqualToString:self.otaRecordModel.fileName]) {
                if (self.removeFileBlock) {
                    self.removeFileBlock();
                }
            }
        }
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:[NSString stringWithFormat:@"%@/%@",self.basePath,self.dataArr[indexPath.row]] error:nil];
        [self getAllFileNames];

        if (self.selectedFileName != nil && [self.selectedFileName isEqualToString:fileName]) {
            self.selectedFileName = nil;
        }
    }
}

#pragma mark - getter
- (NSString *)basePath {
    if (!_basePath) {
        // 获得此程序的沙盒路径
        NSArray *patchs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        // 获取Documents路径
        // [patchs objectAtIndex:0]
        NSString *documentsDirectory = [patchs objectAtIndex:0];
        _basePath = [documentsDirectory stringByAppendingPathComponent:@"/Inbox"];
    }
    return _basePath;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];;
}

@end
