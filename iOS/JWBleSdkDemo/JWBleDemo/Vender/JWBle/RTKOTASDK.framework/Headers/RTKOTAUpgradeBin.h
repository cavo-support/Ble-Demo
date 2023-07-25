//
//  RTKOTAImage.h
//  RTKOTASDK
//
//  Created by jerome_gu on 2019/1/28.
//  Copyright © 2019 Realtek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RTKOTABin.h"

typedef NS_ENUM(NSUInteger, RTKOTABinBankInfo) {
    RTKOTABinBankInfo_Unknown,
    RTKOTABinBankInfo_Bank0,
    RTKOTABinBankInfo_Bank1,
};

NS_ASSUME_NONNULL_BEGIN

/**
 * 代表一个OTA升级的bin单元
 */
@interface RTKOTAUpgradeBin : RTKOTABin

@property (readonly) NSUInteger otaVersion;

@property (readonly) NSUInteger secVersion;

@property (readonly) NSUInteger imageId;

@property (readonly) NSData *data;

@property (nonatomic) RTKOTABinBankInfo bank;


- (instancetype)initWithPureData:(NSData *)data;

- (instancetype)initWithMPBinData:(NSData *)data ic:(RTKOTAICType)ic;


+ (nullable NSArray <RTKOTAUpgradeBin*> *)imagesExtractFromMPPackFilePath:(NSString *)path error:(NSError *__nullable *__nullable)errPtr;

+ (nullable NSArray <RTKOTAUpgradeBin*> *)imagesExtractFromMPPackFileData:(NSData *)data error:(NSError *__nullable *__nullable)errPtr;



@end

NS_ASSUME_NONNULL_END
