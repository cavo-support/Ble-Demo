//
//  RTKOTABin.h
//  RTKOTASDK
//
//  Created by jerome_gu on 2019/4/16.
//  Copyright © 2019 Realtek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RTKOTAFormat.h"


NS_ASSUME_NONNULL_BEGIN

/**
 * A binary installed in Realtek peripheral.
 */
@interface RTKOTABin : NSObject

/* Bin type */
@property (readonly) RTKOTAImageType type;


@property (assign) RTKOTAICType IC;

/**
 * Version in integer.
 */
@property (readonly) uint32_t version;


/**
 * The binary name.
 */
@property (readonly) NSString *name;

/**
 * Human-readable version string.
 */
@property (readonly) NSString *versionString;


- (instancetype)initWithType:(RTKOTAImageType)type version:(uint32_t)verInt ofIC:(RTKOTAICType)ic;


/**
 * The maximum length of thie image section in SOC.
 * @discussion When 0 is returned, means section size is undefined.
 */
@property (readonly) NSUInteger sectionSize;

- (instancetype)initWithType:(RTKOTAImageType)type version:(uint32_t)verInt ofIC:(RTKOTAICType)ic sectionSize:(NSUInteger)size;

@end


NS_ASSUME_NONNULL_END
