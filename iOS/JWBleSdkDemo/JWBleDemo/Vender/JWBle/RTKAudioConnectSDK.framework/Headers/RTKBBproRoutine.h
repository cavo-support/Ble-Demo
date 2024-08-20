//
//  RTKBBproRoutine.h
//  RTKLEFoundation
//
//  Created by jerome_gu on 2020/3/13.
//  Copyright © 2020 jerome_gu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RTKLEFoundation/RTKLEFoundation.h>
#import "RTKBBproType.h"

NS_ASSUME_NONNULL_BEGIN


@interface RTKBBproRoutine : NSObject

- (instancetype)initWithMessageCommunication:(RTKPackageCommunication*)communication;

@property (nonatomic, readonly) RTKPackageCommunication *messageCommunication;

@property (nonatomic, readonly) RTKRequestCommunication *requestCommunication;

@end


NS_ASSUME_NONNULL_END
