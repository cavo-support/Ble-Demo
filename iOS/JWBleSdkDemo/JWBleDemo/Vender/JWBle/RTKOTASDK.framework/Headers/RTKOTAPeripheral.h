//
//  RTKOTAPeripheral.h
//  RTKOTASDK
//
//  Created by jerome_gu on 2019/4/16.
//  Copyright © 2019 Realtek. All rights reserved.
//

#import <RTKLEFoundation/RTKLEFoundation.h>
#import "RTKOTAFormat.h"
#import "RTKOTABin.h"

NS_ASSUME_NONNULL_BEGIN


@class RTKOTAPeripheral;

@protocol RTKOTAPeripheralDelegate <RTKLEPeripheralDelegate>

/**
 * Invoked when RTKOTAClient has determined information about OTA.
 */
- (void)OTAPeripheral:(RTKOTAPeripheral *)peripheral didDetermineInfoWithError:(nullable NSError*)error;

@end



@interface RTKOTAPeripheral : RTKLEPeripheral

@property (readonly) BOOL infoSettled;

@property (nonatomic, weak) id <RTKOTAPeripheralDelegate> delegate;

/**
 * Realtek IC
 */
@property (readonly) RTKOTAICType ic;

/**
 * OTA process version
 */
@property (readonly) NSUInteger OTAVersion;

@property (readonly) NSUInteger securityVersion;

@property (readonly) uint64_t bdAddress;

@property (readonly) uint16_t appVersion;
@property (readonly) uint16_t patchVersion;

@property (readonly) NSString *linkKey;

@property () NSUInteger maxBufferSize;
@property (readonly) NSUInteger tempBufferSize;

@property (readonly) NSUInteger freeBank;
@property (readonly) NSUInteger appFreeBank;
@property (readonly) NSUInteger patchFreeBank;

@property (readonly) BOOL bufferCheckEnable;
@property (readonly) BOOL AESEnable;
@property (readonly) NSUInteger encryptionMode;
@property (readonly) BOOL copyImage;
@property (readonly) BOOL updateMultiImages;

@property (readonly) uint32_t imageIndicator;

@property (readonly) uint16_t protocolVer;

/**
 * The executable bins installed in Realtek peripheral.
 */
@property (readonly) NSArray <RTKOTABin*> *bins;


/**
 * Indicate whether related peripheral can translate to OTA mode, and wether -enterOTAMode method can be invoked.
 */
@property (readonly) BOOL canEnterOTAMode;

/**
 * Indicate whether related peripheral can DFU upgrade immediately.
 */
@property (readonly) BOOL canUpgradeSliently;


/**
 * Request peripheral translate to OTA mode.
 * @discussion In translating to OTA mode, the Peripheral first get disconnected, and reboot as a different peripheral (while advertising same address). When the OTA mode peripheral be scanned, RTKOTAClientDelegate -OTAClient:didEnterOTAModeWithPeripheral: get invoked with the peripheral.
 */
- (void)enterOTAMode;

@end

NS_ASSUME_NONNULL_END
