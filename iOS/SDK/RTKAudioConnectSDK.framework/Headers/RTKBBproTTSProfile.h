//
//  RTKBBproTTSProfile.h
//  RTKAudioConnectSDK
//
//  Created by jerome_gu on 2020/6/5.
//  Copyright © 2020 jerome_gu. All rights reserved.
//

#import <RTKAudioConnectSDK/RTKAudioConnectSDK.h>

@class RTKBBproTTSPeripheral;
NS_ASSUME_NONNULL_BEGIN

/*!
 RTKBBproTTSProfile provide additional TTS service in addition to RTKBBproProfile.
 *
 * @discussion This class use RTKBBproTTSPeripheral class as peripheral representation. There should be only one connection to peripheral,  otherwise the behaviour is undefined.
 */
@interface RTKBBproTTSProfile : RTKBBproProfile

/*!
 * The peripheral current in use.
 *  @discussion There should be only one instance.
 */
@property (nullable, readonly) RTKBBproTTSPeripheral *peripheral;
@end

NS_ASSUME_NONNULL_END
