//
//  RTKLog.h
//  RTKLEFoundation
//
//  Created by jerome_gu on 2019/1/21.
//  Copyright © 2019 Realtek. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    RTKLogFacilityDefault,  // NSLog
    RTKLogFacilityCocoaLumberjack,   // use CocoaLumberjack logger facility. Not support now
    RTKLogFacilityCustom,  // provide a custom C function to do actual logging.
} RTKLogFacility;


/**
 * Log level of this module, not global.
 */
typedef NS_ENUM(NSUInteger, RTKLogLevel) {
    RTKLogLevelOff       = 0,
    RTKLogLevelError,
    RTKLogLevelWarning,
    RTKLogLevelInfo,
    RTKLogLevelDebug,
    RTKLogLevelVerbose,
};


/**
 * Module Log related interface class.
 * @discussion The log system print log messsage to Console and Files simultaneously. 
 */
@interface RTKLog : NSObject

// Change the logging direction.
// Before set to RTKLogFacilityCustom, you should call +setLogger to set the logging function first.
+ (void)setFacility:(RTKLogFacility)facility;

+ (void)setLogger:(void(*)(NSString*))logFunc;

/**
 * Set log level of this module
 * @see RTKLogLevel
 */
+ (void)setLogLevel:(RTKLogLevel)level;


/* Internal used log method */
+ (void)_logWithLevel:(RTKLogLevel)level format:(NSString *)format, ...;

@end

NS_ASSUME_NONNULL_END
