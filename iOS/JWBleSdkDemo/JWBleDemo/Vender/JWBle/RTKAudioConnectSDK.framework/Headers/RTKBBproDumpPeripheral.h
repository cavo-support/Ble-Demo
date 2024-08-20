//
//  RTKBBproDumpPeripheral.h
//  RTKAudioConnectSDK
//
//  Created by jerome_gu on 2019/10/23.
//  Copyright © 2019 jerome_gu. All rights reserved.
//

#import <RTKAudioConnectSDK/RTKAudioConnectSDK.h>

typedef enum : NSUInteger {
    RTKBBproIC_RTL8763B = 0x0B,
    RTKBBproIC_RTL8773B = 0x16,
} RTKBBproIC;

typedef NS_OPTIONS(NSUInteger, RTKBBProDumpBinSupportMask) {
    RTKBBProDumpBinSupportMask_SystemConfig = 1 << 0,
    RTKBBProDumpBinSupportMask_Patch = 1 << 1,
    RTKBBProDumpBinSupportMask_App = 1 << 2,
    RTKBBProDumpBinSupportMask_DSPSys = 1 << 3,
    RTKBBProDumpBinSupportMask_DSPApp = 1 << 4,
    RTKBBProDumpBinSupportMask_FTLData = 1 << 5,
    RTKBBProDumpBinSupportMask_ANCImage = 1 << 6,
};

typedef NS_ENUM(NSUInteger, DumpFlashType) {
    DumpFlashType_SystemConfig = 0x00,
    DumpFlashType_RomPatch = 0x01,
    DumpFlashType_App = 0x02,
    DumpFlashType_DSPSys = 0x03,
    DumpFlashType_DSPApp = 0x04,
    DumpFlashType_FTLData = 0x05,
    DumpFlashType_ANCImage = 0x06,
    
    DumpFlashType_Invalid = 0xFE,   /* Use unused 0xFE as invalid type code, due to 0xFF used as All type. */
    DumpFlashType_All = 0xFF,
};


NS_ASSUME_NONNULL_BEGIN

@interface RTKBBproDumpPeripheral : RTKBBproPeripheral

@property (nonatomic, readonly, nullable) NSNumber *IC;
@property (nonatomic, readonly, nullable) NSNumber *packageID;
- (void)getPackageIDWithCompletion:(RTKLECompletionBlock)completionHandler;



@property (nonatomic, readonly, nullable) NSString *addressString;

- (void)getBDAddressStringWithCompletion:(void(^)(BOOL success, NSError*_Nullable error, NSString *address))completionHandler;

@property (nonatomic, readonly) BOOL versionSettle;
@property (nonatomic, readonly, nullable) NSString *appVer;
@property (nonatomic, readonly, nullable) NSString *patchVer;
@property (nonatomic, readonly, nullable) NSString *MCUToolVer;
@property (nonatomic, readonly, nullable) NSString *DSPToolVer;
@property (nonatomic, readonly, nullable) NSString *DSPAppVer;
@property (nonatomic, readonly, nullable) NSString *DSPSysVer;

- (void)getFWVersionWithCompletion:(RTKLECompletionBlock)completionHandler;


@property (nonatomic, readonly, nullable) NSNumber *supportedImages;
- (void)getSupportedImagesWithCompletion:(void(^)(BOOL success, NSError*_Nullable error, RTKBBProDumpBinSupportMask mask))completionHandler;


@property (nonatomic, readonly) BOOL isTranfering;

- (void)getFlashOfImage:(DumpFlashType)type
           withProgress:(void(^)(float progress))progressHandler
             completion:(void(^)(BOOL success, NSError*_Nullable error, NSData *binData))completionHandler;

- (void)cancelOngoingTransfering;

@end

NS_ASSUME_NONNULL_END
