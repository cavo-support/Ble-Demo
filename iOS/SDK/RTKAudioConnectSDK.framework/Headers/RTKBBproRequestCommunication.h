//
//  RTKBBproRequestCommunication.h
//  RTKAudioConnectSDK
//
//  Created by jerome_gu on 2019/1/14.
//  Copyright © 2019 Realtek. All rights reserved.
//

#import <RTKLEFoundation/RTKLEFoundation.h>

@class RTKBBproPeripheral;
NS_ASSUME_NONNULL_BEGIN

@interface RTKBBproRequestCommunication : RTKRequestCommunication

@property (nonatomic) NSInteger version;

@end

NS_ASSUME_NONNULL_END
