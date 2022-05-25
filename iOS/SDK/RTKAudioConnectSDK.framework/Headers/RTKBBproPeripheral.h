//
//  RTKBBproPeripheral.h
//  RTKAudioConnectSDK
//
//  Created by jerome_gu on 2019/4/11.
//  Copyright © 2019 Realtek. All rights reserved.
//

#import <RTKLEFoundation/RTKLEFoundation.h>

#import "RTKBBproType.h"
#import "RTKANCSNotificationEvent.h"
#import "RTKANCSNotificationAttribute.h"


NS_ASSUME_NONNULL_BEGIN


/*!
 Represents a remote BBpro series peripheral peer.
 
 @discussion This class expose a lot state information by properties. Most properties are KVO applicable, you add observers to properties which you want get notified when those value changed. Those properties have type NSNumber or NSValue (not scalar value), nil indicate the state is not determined. Normally, when property is first accessed and return nil, a get action perform automatically.
 
 When being called, not all RTKBBproPeripheral APIs be available, because the remote peripheral generally support a part.
 */
@interface RTKBBproPeripheral : RTKLEPeripheral <RTKPackageCommunicationClient>

/**
 * eg. "1.2"  =  1*256 + 2
 */
@property (nonatomic, readonly, nullable) NSNumber *versionNumber;

@property (nonatomic, readonly, nullable) NSString *LEName;
@property (nonatomic, readonly, nullable) NSString *BREDRName;

@property (nonatomic, readonly, nullable) RTKBBproLanguageType currentLanguage;
@property (nonatomic, readonly, nullable) NSSet <RTKBBproLanguageType> *supportedLanguages;

@property (nonatomic, readonly, nullable) NSNumber *primaryBatteryLevel;
@property (nonatomic, readonly, nullable) NSNumber *secondaryBatteryLevel;

@property (nonatomic, nullable, readonly) NSNumber *RWSState;
@property (nonatomic, readonly, nullable) NSNumber *RwsChannel;

@property (nonatomic, nullable, readonly) NSNumber *APTState;

@property (nonatomic, readonly, nullable) NSDictionary <NSString*,NSNumber*>* DSPInfo;
@property (nonatomic, nullable) NSData *DSPEQData;


#pragma mark - Name

- (void)getInfoWithCompletion:(void(^)(BOOL success, NSError*_Nullable error, uint16_t ver))handler;



/* SOC Capability info */
@property (readonly, nonatomic) BOOL capabilitySettled;

- (BOOL)isAvailableFor:(RTKBBproCapabilityType)capability;

- (void)getCapabilityWithCompletion:(RTKLECompletionBlock)handler;

/*
 * Get the LE name of BBpro Peripheral.
 * @param completionHandler Called upon completion. If success, name is the LE name of Peripheral, else a error is provided.
 */
- (void)getLENameWithCompletion:(void(^)(BOOL success, NSError*_Nullable error, NSString *name))completionHandler;

/*
 * Set the LE name of BBpro Peripheral.
 * @param completionHandler Called upon completion. If success, success is YES and error is nil, else a error is provided.
 */
- (void)setLEName:(NSString *)name withCompletion:(void(^)(BOOL success, NSError*_Nullable error))completionHandler;

/*
 * Get the LE name of BBpro Peripheral.
 * @param completionHandler Called upon completion. If success, name is the LE name of Peripheral, else a error is provided.
 */
- (void)getBREDRNameWithCompletion:(void(^)(BOOL success, NSError*_Nullable error, NSString *name))completionHandler;

/*
 * Set the LE name of BBpro Peripheral.
 * @param completionHandler Called upon completion. If success, success is YES and error is nil, else a error is provided.
 */
- (void)setBREDRName:(NSString *)name withCompletion:(void(^)(BOOL success, NSError*_Nullable error))completionHandler;


#pragma mark - Language
/*
 * Get the language information of BBpro Peripheral.
 * @param completionHandler Called upon completion. If success, supportedLangs is a NSString array containing supported language and currentLang is a NSString representing current used language, else a error is provided.
 */
- (void)getLanguageWithCompletion:(void(^)(BOOL success, NSError*_Nullable error, NSSet <RTKBBproLanguageType>* supportedLangs, RTKBBproLanguageType currentLang))completionHandler;

/*
 * Set the current used language of BBpro Peripheral.
 * @param lang The language to set. It must be a language in supported languages, which can achive by invoke -getLanguageWithCompletion: method.
 * @param completionHandler Called upon completion. If success, supportedLangs is a NSString array containing supported language and currentLang is a NSString representing current used language, else a error is provided.
 */
- (void)setCurrentLanguage:(RTKBBproLanguageType)lang withCompletion:(void(^)(BOOL success, NSError*_Nullable error))completionHandler;


#pragma mark - Battery
/*
 * Get the battery level of BBpro Peripheral once.
 * @param completionHandler Called upon completion. If success, primary is the level of Primary component and secondary is the level of Secondary component, else a error is provided.
 */
- (void)getBatteryLevelWithCompletion:(void(^)(BOOL success, NSError*_Nullable error, NSUInteger primary, NSUInteger secondary))completionHandler;


#pragma mark - RWS
/*
 * Get the RWS state of BBpro Peripheral.
 * @param completionHandler Called upon completion. If success, state is a boolean indicating whether RWS is on, else a error is provided.
 */
- (void)getRwsStateWithCompletion:(void(^)(BOOL success, NSError*_Nullable error, BOOL state))completionHandler;

/*
 * Get the RWS channel of BBpro Peripheral.
 * @param completionHandler Called upon completion. If success, channel indicate current used channel, else a error is provided.
 */
- (void)getRwsChannelWithCompletion:(void(^)(BOOL success, NSError*_Nullable error, NSUInteger channel))completionHandler;

/*
 * Switch the RWS channel of BBpro Peripheral.
 * @param completionHandler Called upon completion. If success, channel is switched successfully, else switching fail with a error.
 */
- (void)switchRwsChannelWithCompletion:(void(^)(BOOL success, NSError*_Nullable error))completionHandler;


#pragma mark - APT
/*
 * Get the Audio Passthrough (APT) state of BBpro Peripheral.
 * @param completionHandler Called upon completion. If success, state is a boolean indicating wether APT is on or off, else a error is provided.
 */
- (void)getAPTStateWithCompletion:(void(^)(BOOL success, NSError*_Nullable error, BOOL state))completionHandler;

/*
 * Switch the Audio Passthrough (APT) state of BBpro Peripheral.
 * @param completionHandler Called upon completion. If success, APT is switched successfully, else switching fail with a error.
 */
- (void)switchAPTStateWithCompletion:(void(^)(BOOL success, NSError*_Nullable error))completionHandler;





#pragma mark - DSP
/*
 * Get DSP version information of BBpro Peripheral.
 * @param completionHandler Called upon completion. If success, info is a dictionary containning DSP Info element (a example next), else a error is provided. info Dictionary example:  @{@"Scenario": @(0x00), @"SF": @(0x03), @"ROM": @(0x01010101), @"RAM": @(0x01010101), @"Patch": @(0x01010101), @"SDK": @(0x01010101)}
 */
- (void)getDSPInfoWithCompletion:(void(^)(BOOL success, NSError*_Nullable error, NSDictionary <NSString*,NSNumber*>*_Nullable info))completionHandler;
//- (void)getDSPEQWithCompletion:(void(^)(BOOL success, NSError*_Nullable error, NSData*_Nullable))completionHandler;

/**
 * Set DSP EQ
 * @param paramterData Data to modify DSP EQ. The data should be return by call -[RTKBBproEQSetting serializedDataOfNot48K] or -[RTKBBproEQSetting serializedDataOf48K] method.
 * @param completionHandler This block is called upon completion. If the action take effect then success is YES and error is nil. Otherwise success is NO with an error.
 * @discussion Specific to some implementation, you should set EQ for 44.1k(-serializedDataOfNot48K) and 48k(-serializedDataOf48K) all at once to make DSP effective really.
 */
- (void)setDSPEQ:(NSData *)paramterData withCompletion:(void(^)(BOOL success, NSError*_Nullable error))completionHandler;

/**
 * Clear DSP EQ setting
 * @param completionHandler This block is called upon completion. If the action take effect then success is YES and error is nil. Otherwise success is NO with an error.
 */
- (void)clearDSPEQWithCompletion:(void(^)(BOOL success, NSError*_Nullable error))completionHandler;


#pragma mark - ANC

typedef enum : uint8_t {
    RTKBBproANCScenaraio_none,
    RTKBBproANCScenaraio_high,
    RTKBBproANCScenaraio_low,
    RTKBBproANCScenaraio_family,
    RTKBBproANCScenaraio_library,
    RTKBBproANCScenaraio_airplane,
    RTKBBproANCScenaraio_subway,
    RTKBBproANCScenaraio_outdoor,
    RTKBBproANCScenaraio_running    =   0x08,
    
    RTKBBproANCScenaraio_customer0  =   0x80,
    RTKBBproANCScenaraio_customer1,
    RTKBBproANCScenaraio_customer2,
    RTKBBproANCScenaraio_customer3,
    RTKBBproANCScenaraio_customer4,
    RTKBBproANCScenaraio_customer5,
    RTKBBproANCScenaraio_customer6,
    RTKBBproANCScenaraio_customer7  =   0x87,
    
    RTKBBproANCScenaraio_MP1,
    RTKBBproANCScenaraio_MP2,
    
    RTKBBproANCScenaraio_unknown = 0xff
} RTKBBproANCScenaraio;

@property (nonatomic, readonly) NSNumber *ANCEnabled;
@property (nonatomic, readonly) NSNumber *currentANCModeIndex;
@property (nonatomic, readonly) NSArray<NSNumber*> *ANCModes;

- (void)getANCStateWithCompletion:(void (^)(BOOL success, NSError *_Nullable error, BOOL enabled, NSUInteger currentModeIndex, NSArray<NSNumber*> * modes))handler;

- (void)setANCEnable:(BOOL)enabled withCompletionHandler:(RTKLECompletionBlock)handler;

- (void)setCurrentANCModeIndex:(NSUInteger)index withCompletionHandler:(RTKLECompletionBlock)handler;


#pragma mark - LLAPT
@property (nonatomic, readonly) NSNumber *LLAPTEnabled;

- (void)getLLAPTStateWithCompletion:(void (^)(BOOL success, NSError *_Nullable error, BOOL enabled))handler;

- (void)setLLAPTEnable:(BOOL)enabled withCompletionHandler:(RTKLECompletionBlock)handler;


@end


/**
 * EQ related operation.
 * Only available when version >= 1.0
 */
@interface RTKBBproPeripheral (EQ)

@property (nonatomic, readonly) NSNumber *EQStatus;
- (void)getEQStatusWithCompletion:(void(^)(BOOL success, NSError*_Nullable error, BOOL isOn))completionHandler;

- (void)setEQEnable:(BOOL)enable withCompletion:(void(^)(BOOL success, NSError*_Nullable error))completionHandler;

@property (nonatomic, readonly) NSNumber *EQCount;
- (void)getEQEntryCountWithCompletion:(void(^)(BOOL success, NSError*_Nullable error, NSUInteger count))completionHandler;

@property (nonatomic, readonly) NSNumber *EQIndex;
- (void)getCurrentEQIndexWithCompletion:(void(^)(BOOL success, NSError*_Nullable error, NSUInteger EQIndex))completionHandler;

- (void)setCurrentEQIndex:(NSUInteger)index completion:(void(^)(BOOL success, NSError*_Nullable error))completionHandler;

- (void)getEQParameterOfIndex:(NSUInteger)index completion:(void(^)(BOOL success, NSError*_Nullable error, NSData *EQData))completionHandler;

- (void)setEQParameterOfIndex:(NSUInteger)index EQData:(NSData *)data completion:(void(^)(BOOL success, NSError*_Nullable error))completionHandler;

@end






@interface RTKBBproPeripheral (LGProject)

@property (nonatomic, nullable) NSNumber *vibrationEnable;


/**
 *  The last received ANCS event from peripheral.
 * @discussion The lastANCSEvent and lastANCSAttr are the last ANCS  received from peripheral. This is a readonly property. If you want to be notified when receive new ANCS event, use KVO approach.
 */
@property (nonatomic, readonly, nullable) RTKANCSNotificationEvent *lastANCSEvent;

/**
 * The last received ANCS event from peripheral.
 *
 * @discussion The lastANCSEvent and lastANCSAttr are the last ANCS  received from peripheral. This is a readonly property. If you want to be notified when receive new ANCS event, use KVO approach.
*/
@property (nonatomic, readonly, nullable) RTKANCSNotificationAttribute *lastANCSAttr;


#pragma mark -  EQ Index

#warning EQ Index, Vibration and ANCS is only applicable to LG project.

@property (nonatomic, nullable) NSNumber *currentEQIndex;
@property (nonatomic, readonly, nullable) NSNumber *supportedEQIndexes;

/**
 * Get EQ Setting index of peripheral
 *
 * @param completionHandler This block is called upon completion. If the action take effect then success is YES and error is nil, and parameter currentIndex is the the EQ Setting Index current used in Peripheral, supportedIndexes is a bit field which indicate supported Indexes. Otherwise success is NO with an error.
 * @see RTKBBproEQIndex type
 */
- (void)getEQIndexStateWithCompletion:(void(^)(BOOL success, NSError*_Nullable error, RTKBBproEQIndex currentIndex, RTKBBproEQIndex supportedIndexes))completionHandler;

/**
 * Set current used EQ Setting of peripheral
 * @param index A bitmask whose EQ Setting to use bit set 1.
 * @see RTKBBproEQIndex type
 */
- (void)setEQIndex:(RTKBBproEQIndex)index withCompletion:(void(^)(BOOL success, NSError*_Nullable error))completionHandler;


#pragma mark - Vibration
/**
 * Get Peripheral Vibration Status
 * @param completionHandler This block is called upon completion. If the action take effect then success is YES and error is nil, and state indicate whether vibration is on. Otherwise success is NO with an error.
 */
- (void)getVibrationStatusWithCompletion:(void(^)(BOOL success, NSError*_Nullable error, BOOL state))completionHandler;

///**
// *
// */
//- (void)getVibrationModeWithCompletion:(void(^)(BOOL success, NSError*_Nullable error, uint16_t, uint16_t, uint8_t))completionHandler;

/**
 * Enable or disable Vibration
 * @param enabled Control whether peripheral vibration function enable.
 * @param completionHandler This block is called upon completion. If the action take effect then success is YES and error is nil. Otherwise success is NO with an error.
 */
- (void)setVibrationEnable:(BOOL)enabled withCompletion:(void(^)(BOOL success, NSError*_Nullable error))completionHandler;

/**
 * Toggle vibration function
 * @param completionHandler This block is called upon completion. If the action take effect then success is YES and error is nil. Otherwise success is NO with an error.
 */
- (void)toggleVibrationWithCompletion:(void(^)(BOOL success, NSError*_Nullable error))completionHandler;

/**
 * Stop in progress vibration
 * @param completionHandler This block is called upon completion. If the action take effect then success is YES and error is nil. Otherwise success is NO with an error.
 * @discussion Only function when a happening vibration
 */
- (void)stopVibrationWithCompletion:(void(^)(BOOL success, NSError*_Nullable error))completionHandler;

/**
 * Set vibration behavior pattern
 * @param on On period time (10ms/uinit)
 * @param off Off period time (10ms/uinit)
 * @param count Vibrate repeat count
 * @param completionHandler This block is called upon completion. If the action take effect then success is YES and error is nil. Otherwise success is NO with an error.
 */
- (void)setVibrationModeWithOnPeriod:(NSUInteger)on offPeriod:(NSUInteger)off repeat:(NSUInteger)count completion:(void(^)(BOOL success, NSError*_Nullable error))completionHandler;


#pragma mark - ANCS

/**
 * Make SOC to use ANCS
 * @param completionHandler This block is called upon completion. If the action take effect then success is YES and error is nil. Otherwise success is NO with an error.
 * @discussion Only function when a happening vibration
 */
- (void)registerANCSWithCompletion:(void(^)(BOOL success, NSError*_Nullable error))completionHandler;


#pragma mark - Find me
/**
 * The find me status of peripheral. This may trigger send a get requrest to peripheral.
 * This property is KVO-capable.
 */
@property (nonatomic, nullable, readonly) NSNumber *leftBudFindmeEnabled;
@property (nonatomic, nullable, readonly) NSNumber *rightBudFindmeEnabled;

/**
 * Start get the find me status of remote peripheral.
 */
- (void)getFindmeStatusWithCompletionHandler:(RTKLECompletionBlock)handler;

/**
 * Set find me status.
 */
- (void)setFindmeState:(BOOL)isOn ofBud:(BOOL)isRightBud withCompletionHandler:(RTKLECompletionBlock)handler;


#pragma mark - Customized feature
- (void)getSerialNumberDataWithCompletionHandler:(void(^)(BOOL success, NSError*_Nullable error, NSData *readedData))handler;


/**
 * Indicate whether peripehral is in voice notifying status.
 *
 * @discussion Add a KVO observer if you want to be notified when value change.
 */
@property (nonatomic, readonly) NSNumber *isVoiceNotifying;

/**
 * Notify peripheral that voice notificaiton will begin.
 */
- (void)indicateVoiceNotificationStartWithCompletionHandler:(RTKLECompletionBlock)handler;

/**
 * Notify peripheral that voice notificaiton will end.
*/
- (void)indicateVoiceNotificationTerminationWithCompletionHandler:(RTKLECompletionBlock)handler;



#pragma mark - Volume Control
@property (nonatomic, readonly) NSNumber *volumeLevel;
@property (nonatomic, readonly) NSNumber *maxVolumeLevel;

- (void)getVolumeStatusWithCompletionHandler:(RTKLECompletionBlock)handler;

- (void)setVolumeLevelTo:(uint8_t)level withCompletion:(void(^)(BOOL success, NSError*_Nullable error))completionHandler;


#pragma mark - Meridian sound effect
@property (nonatomic, readonly) NSNumber *meridianEffectMode;

- (void)getMeridianSoundEffectWithCompletionHandler:(RTKLECompletionBlock)handler;

- (void)setMeridianSoundEffectModeTo:(RTKBBproMeridianSoundEffect)mode withCompletion:(void(^)(BOOL success, NSError*_Nullable error))completionHandler;


#pragma mark - Gaming mode control
@property (nonatomic, readonly) NSNumber *gamingModeEnabled;

- (void)getGamingModeWithCompletionHandler:(RTKLECompletionBlock)handler;

- (void)switchGamingModeWithCompletionHandler:(RTKLECompletionBlock)handler;


#pragma mark - Classic Profile
- (void)connectProfile:(RTKBBproLegacyProfile)profile withCompletion:(RTKLECompletionBlock)handler;

- (void)cancelProfileConnection:(RTKBBproLegacyProfile)profile withCompletion:(RTKLECompletionBlock)handler;


@end




@interface RTKBBproPeripheral (MMI)

@property (nonatomic, readonly, nullable) NSArray <NSNumber*> *supportedMMIs;
- (void)getSupportedMMIsWithCompletionHandler:(RTKLECompletionBlock)handler;

@property (nonatomic, readonly, nullable) NSArray <NSNumber*> *supportedClicks;
- (void)getSupportedClicksWithCompletionHandler:(RTKLECompletionBlock)handler;


@property (nonatomic, readonly, nullable) NSArray <NSNumber*> *supportedPhoneStatus;
- (void)getSupportedPhoneStatusWithCompletionHandler:(RTKLECompletionBlock)handler;

@property (nonatomic, readonly, nullable) NSArray <NSValue*> *MMIKeyMappings;
- (void)getMMIKeyMappingWithCompletionHandler:(RTKLECompletionBlock)handler;

- (void)setMMIKeyMapping:(RTKBBproMMIMapping)mapping withCompletionHandler:(RTKLECompletionBlock)handler;

@property (nonatomic, readonly, nullable) NSNumber *buttonLocked;
- (void)getMMIButtonLockStateWithCompletionHandler:(RTKLECompletionBlock)handler;

- (void)switchMMIButtonLockStateWithCompletionHandler:(RTKLECompletionBlock)handler;


- (void)requestEnterToPairingModeWithCompletionHandler:(RTKLECompletionBlock)handler;
- (void)requestExitToPairingModeWithCompletionHandler:(RTKLECompletionBlock)handler;

- (void)powerOffWithCompletionHandler:(RTKLECompletionBlock)handler;

@end




@interface RTKBBproPeripheral (APTGain)

@property (nonatomic, readonly, nullable) NSNumber *APTNRStatus;

- (void)getAPTNRStatusWithCompletionHandler:(void(^)(BOOL success, NSError*_Nullable error))handler;

- (void)switchAPTNROnOffWithCompletion:(RTKLECompletionBlock)completionHandler;

@property (nonatomic, readonly, nullable) NSNumber *APTGainLevel;

/* KVO not applicable */
@property (nonatomic, readonly, nullable) NSNumber *maximumAPTGainLevel;

- (void)getAPTGainLevelWithCompletionHandler:(void(^)(BOOL success, NSError*_Nullable error, NSUInteger gain, NSUInteger maxGain))handler;

- (void)setAPTGainLevel:(NSUInteger)level withCompletionHandler:(RTKLECompletionBlock)handler;

- (void)increaseAPTGainLevelWithCompletionHandler:(RTKLECompletionBlock)handler;
- (void)decreaseAPTGainLevelWithCompletionHandler:(RTKLECompletionBlock)handler;

@end


NS_ASSUME_NONNULL_END
