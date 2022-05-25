//
//  RTKAccessoryBBpro.h
//  RTKLEFoundation
//
//  Created by jerome_gu on 2020/3/4.
//  Copyright © 2020 jerome_gu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RTKBBproInteraction.h"
#import "RTKBBproType.h"


NS_ASSUME_NONNULL_BEGIN

@interface RTKBBproGeneralInteraction : RTKBBproInteraction

- (void)getInfoWithCompletion:(void(^)(BOOL success, NSError*_Nullable error, uint16_t ver))handler;

- (void)getLENameWithCompletion:(void(^)(BOOL success, NSError*_Nullable error, NSString *name))completionHandler;

- (void)setLEName:(NSString *)name withCompletion:(void(^)(BOOL success, NSError*_Nullable error))completionHandler;

- (void)getBREDRNameWithCompletion:(void(^)(BOOL success, NSError*_Nullable error, NSString *name))completionHandler;

- (void)setBREDRName:(NSString *)name withCompletion:(void(^)(BOOL success, NSError*_Nullable error))completionHandler;

- (void)getLanguageWithCompletion:(void(^)(BOOL success, NSError*_Nullable error, NSSet <RTKBBproLanguageType>* supportedLangs, RTKBBproLanguageType currentLang))completionHandler;

- (void)setCurrentLanguage:(RTKBBproLanguageType)lang withCompletion:(void(^)(BOOL success, NSError*_Nullable error))completionHandler;


- (void)getBatteryLevelWithCompletion:(void(^)(BOOL success, NSError*_Nullable error, NSUInteger primary, NSUInteger secondary))completionHandler;


- (void)getRwsStateWithCompletion:(void(^)(BOOL success, NSError*_Nullable error, BOOL state))completionHandler;

- (void)getRwsChannelWithCompletion:(void(^)(BOOL success, NSError*_Nullable error, NSUInteger channel))completionHandler;

- (void)switchRwsChannelWithCompletion:(void(^)(BOOL success, NSError*_Nullable error))completionHandler;


- (void)getAPTStateWithCompletion:(void(^)(BOOL success, NSError*_Nullable error, BOOL state))completionHandler;

- (void)switchAPTStateWithCompletion:(void(^)(BOOL success, NSError*_Nullable error))completionHandler;

@end



@interface RTKBBproGeneralInteraction (EQ)

- (void)getEQStatusWithCompletion:(void(^)(BOOL success, NSError*_Nullable error, BOOL isOn))completionHandler;

- (void)setEQEnable:(BOOL)enable withCompletion:(void(^)(BOOL success, NSError*_Nullable error))completionHandler;


- (void)getEQEntryCountWithCompletion:(void(^)(BOOL success, NSError*_Nullable error, NSUInteger count))completionHandler;


- (void)getCurrentEQIndexWithCompletion:(void(^)(BOOL success, NSError*_Nullable error, NSUInteger EQIndex))completionHandler;

- (void)setCurrentEQIndex:(NSUInteger)index completion:(void(^)(BOOL success, NSError*_Nullable error))completionHandler;

- (void)getEQParameterOfIndex:(NSUInteger)index completion:(void(^)(BOOL success, NSError*_Nullable error, NSData *EQData))completionHandler;

- (void)setEQParameterOfIndex:(NSUInteger)index EQData:(NSData *)data completion:(void(^)(BOOL success, NSError*_Nullable error))completionHandler;

@end



@interface RTKBBproGeneralInteraction (Cache)

@property (nonatomic, readonly) NSNumber *versionNumber;

@property (nonatomic, readonly) NSString *LEName;
@property (nonatomic, readonly) NSString *BREDRName;

@property (nonatomic, readonly) RTKBBproLanguageType currentLanguage;
@property (nonatomic, readonly) NSSet <RTKBBproLanguageType> *supportedLanguages;

@property (nonatomic, readonly) NSNumber *primaryBatteryLevel;
@property (nonatomic, readonly) NSNumber *secondaryBatteryLevel;

@property (nonatomic, readonly) NSNumber *RWSState;
@property (nonatomic, readonly) NSNumber *RwsChannel;

@property (nonatomic, readonly) NSNumber *APTState;

/* EQ */
@property (nonatomic, readonly) NSNumber *EQStatus;
@property (nonatomic, readonly) NSNumber *EQCount;
@property (nonatomic, readonly) NSNumber *EQIndex;

@end



@interface RTKBBproAccessory : RTKBBproGeneralInteraction

- (instancetype)initWithAccessory:(RTKAccessory *)accessory;
@property (readonly) RTKAccessory *accessory;

- (instancetype)initWithExistMessageCommunication:(RTKPackageCommunication *)communication;

@end

NS_ASSUME_NONNULL_END
