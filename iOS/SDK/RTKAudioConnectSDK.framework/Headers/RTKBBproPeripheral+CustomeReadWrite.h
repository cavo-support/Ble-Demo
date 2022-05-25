//
//  RTKBBproPeripheral+CustomeReadWrite.h
//  RTKAudioConnectSDK
//
//  Created by jerome_gu on 2019/4/12.
//  Copyright © 2019 Realtek. All rights reserved.
//

#import <RTKAudioConnectSDK/RTKAudioConnectSDK.h>
#import "RTKBBproRequestCommunication.h"

NS_ASSUME_NONNULL_BEGIN

@interface RTKBBproPeripheral (CustomReadWrite) <RTKPackageCommunicationClient>

@property (readonly) RTKBBproRequestCommunication *communication;

@end

NS_ASSUME_NONNULL_END
