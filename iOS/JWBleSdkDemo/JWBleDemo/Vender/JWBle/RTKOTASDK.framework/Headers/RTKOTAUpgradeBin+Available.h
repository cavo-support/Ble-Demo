//
//  RTKOTAUpgradeBin+Available.h
//  RTKLEFoundation
//
//  Created by jerome_gu on 2020/9/23.
//  Copyright © 2020 jerome_gu. All rights reserved.
//

#import "RTKOTAUpgradeBin.h"
#import "RTKOTAPeripheral.h"
#import "RTKOTADeviceInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface RTKOTAUpgradeBin (Available)

@property (nonatomic, readonly) BOOL ICDetermined;


// Assign the OTA target peripheral IC subjectively.
// @discussion You should call this method only if property ICDetermined is NO. You should make sure the upgrade Bin matches target peripheral, otherwise, the behaviour is not determined.
- (void)assertAvailableForPeripheral:(RTKOTAPeripheral *)peripheral;

- (void)assertAvailableForPeripheralInfo:(RTKOTADeviceInfo *)info;

@end

NS_ASSUME_NONNULL_END
