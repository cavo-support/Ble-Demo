//
//  RTKBBproError.h
//  RTKAudioConnectSDK
//
//  Created by jerome_gu on 2019/1/23.
//  Copyright © 2019 Realtek. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSErrorDomain const RTKBBproErrorDomain;

/* RTKBBproErrorDomain Error code */
typedef enum : NSUInteger {
    RTKBBproErrorCMDDisallow,
    RTKBBproErrorCMDUnknown,
    RTKBBproErrorCMDParameterError,
    RTKBBproErrorCMDSOCBusy,
    RTKBBproErrorCMDOthers,
    
    RTKBBproErrorParameterInvalid,
    
    RTKBBproErrorSOCNotSupport = 10,
    RTKBBproErrorTTSInstantiation,   /* TTS(Text to Speech)实例化失败 */
    RTKBBproErrorMessageSendFail,
    RTKBBproErrorTTSSynthesizeFail,
    
    RTKBBproErrorEQParameterWaitTimeout,
    
    RTKBBproErrorPreviousNotFinished,
    
    RTKBBproError_prepareFailed,
    RTKBBproError_unkownReason,
} RTKBBproErrorCode;

