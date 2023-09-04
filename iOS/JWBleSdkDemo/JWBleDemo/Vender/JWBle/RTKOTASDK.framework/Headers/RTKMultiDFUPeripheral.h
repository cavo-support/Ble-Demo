//
//  RTKMultiDFUPeripheral.h
//  RTKOTASDK
//
//  Created by jerome_gu on 2019/4/16.
//  Copyright © 2019 Realtek. All rights reserved.
//

#import "RTKDFUPeripheral.h"

NS_ASSUME_NONNULL_BEGIN

@class RTKOTAProfile;
@class RTKMultiDFUPeripheral;

@protocol RTKMultiDFUPeripheralDelegate <RTKDFUPeripheralDelegate>
@optional
- (void)DFUPeripheral:(RTKMultiDFUPeripheral *)peripheral willSendImage:(RTKOTAUpgradeBin *)image;
- (void)DFUPeripheral:(RTKMultiDFUPeripheral *)peripheral didSendImage:(RTKOTAUpgradeBin *)image;
- (void)DFUPeripheral:(RTKMultiDFUPeripheral *)peripheral didActiveImages:(NSArray<RTKOTAUpgradeBin*>*)images;

@end


@interface RTKMultiDFUPeripheral : RTKDFUPeripheral

@property (nonatomic, weak) id <RTKMultiDFUPeripheralDelegate> delegate;

@property (nonatomic, weak, readonly) RTKLEProfile *profile;  /* Protected */

@property (readonly, nullable) NSArray <RTKOTAUpgradeBin*> *upgradeImages;

- (instancetype)initWithCBPeripheral:(CBPeripheral *)peripheral OTAPeripheral:(RTKOTAPeripheral *)OTAPeri profile:(RTKLEProfile*)profile;

- (void)upgradeImages:(NSArray <RTKOTAUpgradeBin*> *)images inOTAMode:(BOOL)yesOrNo;

@end

NS_ASSUME_NONNULL_END
