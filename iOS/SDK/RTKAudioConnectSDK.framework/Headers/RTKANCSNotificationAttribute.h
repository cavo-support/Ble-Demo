//
//  RTKANCSNotificationAttribute.h
//  RTKAudioConnectSDK
//
//  Created by jerome_gu on 2019/2/27.
//  Copyright © 2019 Realtek. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * A collection of Notification Attribtes.
 * @discussion Refer to Apple Notificaiton Center Service (ANCS) Specification for detail. (https://developer.apple.com/library/archive/documentation/CoreBluetooth/Reference/AppleNotificationCenterServiceSpecification/Introduction/Introduction.html#//apple_ref/doc/uid/TP40013460-CH2-SW1)
 */
@interface RTKANCSNotificationAttribute : NSObject

@property (copy, nullable) NSString *appIdentifier;

@property (copy, nullable) NSString *title;
@property (copy, nullable) NSString *subtitle;

@property (copy, nullable) NSString *message;
@property (copy, nullable) NSString *messageSize;

@property (copy, nullable) NSString *date;

@property (copy, nullable) NSString *positiveActionLabel;
@property (copy, nullable) NSString *negativeActionLabel;

@end

NS_ASSUME_NONNULL_END
