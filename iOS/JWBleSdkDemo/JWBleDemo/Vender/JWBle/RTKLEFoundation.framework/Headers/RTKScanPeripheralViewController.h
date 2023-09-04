//
//  RTKScanPeripheralViewController.h
//  RTKBLETester
//
//  Created by Jerome on 2018/4/27.
//  Copyright © 2018年 jerome_gu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTKLECentralManager.h"

@interface RTKScanPeripheralViewController : UITableViewController

@property () RTKLECentralManager *centralManager;

@property (nullable) NSArray<CBUUID*>* serviceIDs;





@property (copy) void (^rescanBlock)(void);
@property (copy) void (^stopScanBlock)(void);


- (void)handleNewScanedPeripheral:(RTKLEPeripheral *)peripheral;

@property (copy) void (^selectionHandler)(RTKLEPeripheral*);

@end
