//
//  AddressBookViewController.m
//  JWBleDemo
//
//  Created by bobobo on 2023/6/21.
//  Copyright © 2023 wosmart. All rights reserved.
//

#import "AddressBookViewController.h"

@interface AddressBookViewController ()

@end

@implementation AddressBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"RemotePhotography";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    NSMutableArray *syncArr = [NSMutableArray new];
    for (int i = 0; i < 20; i++) {
        [syncArr addObject:@{
            @"name": @"zhangsan", //Up to 15 UTF8
            @"phone": @"13688888888" //Up to 19 UTF8
        }];
    }
    
    __weak __typeof(self)weakSelf = self;
    [JWBleAction jwSyncContacts:[syncArr mutableCopy] callBack:^(JWBleCommunicationStatus status, int index) {
        index += 1;
        float progress = index / (float)syncArr.count;
        NSString *progressStr = [NSString stringWithFormat:@"%@%.0f%%",NSLocalizedString(@"synchronizing", nil), progress * 100];
        
        NSLog(@"%d \t %f", index, progress);
        
        if (index == syncArr.count) {
            NSLog(@"success");
        }
    }];
}


@end
