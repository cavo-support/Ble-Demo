//
//  RTKOTAProfile.h
//  RTKOTASDK
//
//  Created by jerome_gu on 2019/4/16.
//  Copyright © 2019 Realtek. All rights reserved.
//

#import <RTKLEFoundation/RTKLEFoundation.h>
#import "RTKOTAPeripheral.h"
#import "RTKMultiDFUPeripheral.h"

NS_ASSUME_NONNULL_BEGIN

@interface RTKOTAProfile : RTKLEProfile

// Instantiate OTAPeripheral from a known CBPeripheral object.
// You typically already have a CBPeripheral to upgrade within your CBCentralManager.
- (nullable RTKOTAPeripheral*)OTAPeripheralFromCBPeripheral:(CBPeripheral *)peripheral;

// Silent upgrade
- (nullable RTKMultiDFUPeripheral*)DFUPeripheralOfOTAPeripheral:(RTKOTAPeripheral *)peripheral;

// Normal upgrade
- (void)translatePeripheral:(RTKOTAPeripheral*)peripheral toDFUPeripheralWithCompletion:(void(^)(BOOL success, NSError *_Nullable err, RTKMultiDFUPeripheral *_Nullable peripheral))handler;

@end


@interface RTKOTAProfile (Protect)

/* Protected */
- (void)_scanDFUPerpheralOf:(RTKOTAPeripheral*)peripheral withCompletion:(void(^)(BOOL success, NSError *_Nullable err, RTKMultiDFUPeripheral *_Nullable peripheral))handler;

@end

NS_ASSUME_NONNULL_END
