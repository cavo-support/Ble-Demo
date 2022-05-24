//
//  UpdateVersionFileViewController.h
//  CoreBluetoothDemo
//
//  Created by Bo 黄 on 2019/3/15.
//  Copyright © 2019 Jone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OTARecordModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UpdateVersionFileViewController : UIViewController

@property(nonatomic, copy) void (^selectedFileBlock)(NSString *fileName);
@property(nonatomic, copy) void (^removeFileBlock)(void);

@property(nonatomic, strong) OTARecordModel *otaRecordModel;

@end

NS_ASSUME_NONNULL_END
