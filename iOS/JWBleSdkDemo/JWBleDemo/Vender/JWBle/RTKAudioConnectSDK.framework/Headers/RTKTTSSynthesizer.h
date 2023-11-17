//
//  RTKTTSSynthesizer.h
//  RTKAudioConnectSDK
//
//  Created by jerome_gu on 2019/1/17.
//  Copyright © 2019 Realtek. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, RTKTTSLanguage) {
    RTKTTSLanguageUnknown,
    RTKTTSLanguageEnglish,
    RTKTTSLanguageChinese,
};

typedef NS_ENUM(NSUInteger, RTKAudioSampleRate) {
    RTKAudioSampleRate_Default  =   0,
    RTKAudioSampleRate_8K       =   1,
    RTKAudioSampleRate_16K      =   0,
};


@interface RTKTTSSynthesizer : NSObject

/**
 * 设置百度TTS的凭证
 */
+ (void)setBDAPPID:(NSString *)appID appKey:(NSString *)key appSecret:(NSString *)secret;

- (nullable instancetype)init;

- (void)synthesizePhoneNumber:(NSString *)numberText inLanguage:(RTKTTSLanguage)lang toAudioSampleRate:(RTKAudioSampleRate)sampleRate withCompletionHandler:(void(^)(BOOL, NSError *_Nullable, NSData *_Nullable))handler;

- (void)synthesizeCaller:(NSString *)name inLanguage:(RTKTTSLanguage)lang toAudioSampleRate:(RTKAudioSampleRate)sampleRate withCompletionHandler:(void(^)(BOOL, NSError *_Nullable, NSData *_Nullable))handler;

@end

NS_ASSUME_NONNULL_END
