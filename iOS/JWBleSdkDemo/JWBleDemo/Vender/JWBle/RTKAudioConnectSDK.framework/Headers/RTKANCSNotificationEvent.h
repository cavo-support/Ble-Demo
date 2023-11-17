//
//  RTKANCSNotificationEvent.h
//  RTKAudioConnectSDK
//
//  Created by jerome_gu on 2019/2/27.
//  Copyright © 2019 Realtek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RTKANCSStructure.h"


NS_ASSUME_NONNULL_BEGIN

/**
 * ANCS Notification Source information. Indicate a new notification event.
 * @discussion Refer to Apple Notificaiton Center Service (ANCS) Specification for detail. (https://developer.apple.com/library/archive/documentation/CoreBluetooth/Reference/AppleNotificationCenterServiceSpecification/Introduction/Introduction.html#//apple_ref/doc/uid/TP40013460-CH2-SW1)
 */
@interface RTKANCSNotificationEvent : NSObject

@property ANCSEventID ID;

@property ANCSEventFlag flag;

@property ANCSCategoryID category;

@property uint8_t count;

@property uint32_t notificationUID;

@end

NS_ASSUME_NONNULL_END
