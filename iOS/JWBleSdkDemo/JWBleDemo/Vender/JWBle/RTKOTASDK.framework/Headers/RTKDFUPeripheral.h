//
//  RTKDFUPeripheral.h
//  RTKOTASDK
//
//  Created by jerome_gu on 2019/4/16.
//  Copyright © 2019 Realtek. All rights reserved.
//

#import <RTKLEFoundation/RTKLEFoundation.h>
#import "RTKOTAPeripheral.h"

#import "RTKOTAUpgradeBin.h"


typedef enum : NSUInteger {
    RTKDFUPhaseNone,
    RTKDFUPhaseSending,
    RTKDFUPhaseActivating,
    RTKDFUPhaseResetting,
    RTKDFUPhaseCanceling,
    RTKDFUPhaseReconnecting,
    RTKDFUPhaseEncounterError,
} RTKDFUPhase;


NS_ASSUME_NONNULL_BEGIN


@class RTKDFUPeripheral;

@protocol RTKDFUPeripheralDelegate <RTKLEPeripheralDelegate>
@required
- (void)DFUPeripheral:(RTKDFUPeripheral *)peripheral didFinishWithError:(nullable NSError *)err;

@optional
- (void)DFUPeripheral:(RTKDFUPeripheral *)peripheral didSend:(NSUInteger)length totalToSend:(NSUInteger)totalLength;

@end



@class RTKLEProfile;

@interface RTKDFUPeripheral : RTKLEPeripheral {
    @protected
    RTKDFUPhase _phase;
}

@property (nonatomic, weak) id <RTKDFUPeripheralDelegate> delegate;

@property (nonatomic, readonly) RTKOTAPeripheral *OTAPeripheral;

@property (nonatomic, readonly) RTKDFUPhase phase;

@property (readonly, nullable) RTKOTAUpgradeBin *upgradingImage;

/**
 * The AES key, used to encrypte image data when peripheral support.
 * @discussion If no encryptKey set, the default key is used.
 */
- (void)setEncryptKey:(NSData * _Nonnull)encryptKey;


- (instancetype)initWithCBPeripheral:(CBPeripheral *)peripheral OTAPeripheral:(nullable RTKOTAPeripheral *)OTAPeri;


- (void)upgradeImage:(RTKOTAUpgradeBin *)image;

- (void)cancelUpgrade;


/**
 * 模板方法，不要在外部调用
 */
- (void)sendActiveResetToNormalMessage;
- (void)sendActiveResetToOTAMessage;

- (void)handleImageSendCompletion;

@end

NS_ASSUME_NONNULL_END
