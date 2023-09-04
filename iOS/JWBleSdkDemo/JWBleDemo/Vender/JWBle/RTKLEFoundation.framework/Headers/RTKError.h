//
//  RTKError.h
//  RTKLEFoundation
//
//  Created by jerome_gu on 2019/1/21.
//  Copyright © 2019 Realtek. All rights reserved.
//

#ifndef RTKError_h
#define RTKError_h

#import <Foundation/Foundation.h>

extern NSErrorDomain const RTKGenericErrorDomain;

/* RTKGenericErrorDomain Error code */
typedef enum : NSUInteger {
    RTKGenericErrorNotAvailable = 100,
    RTKGenericErrorTimeout,
    RTKGenericErrorServiceDiscoverFail,
    RTKGenericErrorEnableNotifyFail,
    RTKGenericErrorUnexpectedDisconnection,
    RTKGenericErrorUnavailable,
    RTKGenericErrorInvalidParameter,
    RTKGenericErrorBusy,
    RTKGenericErrorNotExist,
    
    RTKGenericErrorNotConform  = 150,
} RTKGenericErrorCode;



@interface NSError (RTKLE)

@property (readonly) BOOL isLinkloss;


/* Warn: iPhone 蓝牙开关关闭时，错误也是 Error Domain=CBErrorDomain Code=7 "The specified device has disconnected from us." UserInfo={NSLocalizedDescription=The specified device has disconnected from us. */
@property (readonly) BOOL isDisconnectByPeer;

@end


#endif /* RTKError_h */
