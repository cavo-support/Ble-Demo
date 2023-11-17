//
//  RTKBBproType.h
//  RTKLEFoundation
//
//  Created by jerome_gu on 2020/3/13.
//  Copyright © 2020 jerome_gu. All rights reserved.
//

#ifndef RTKBBproType_h
#define RTKBBproType_h

#import <Foundation/Foundation.h>

/**
 The language current used of remote peripheral .
 */
typedef NSString* RTKBBproLanguageType;

extern RTKBBproLanguageType const RTKBBproLanguageDefault;

extern RTKBBproLanguageType const RTKBBproLanguageEnglish;
extern RTKBBproLanguageType const RTKBBproLanguageChinese;
extern RTKBBproLanguageType const RTKBBproLanguageFrench;
extern RTKBBproLanguageType const RTKBBproLanguagePortuguese;

extern RTKBBproLanguageType const RTKBBproLanguageUnknown;



typedef NS_ENUM(NSUInteger, RTKBBproCapabilityType) {
    RTKBBproCapabilityType_LENameAccess,
    RTKBBproCapabilityType_BREDRNameAccess,
    RTKBBproCapabilityType_LanguageAccess,
    RTKBBproCapabilityType_BatteryLevelAccess,
    RTKBBproCapabilityType_OTA,
    RTKBBproCapabilityType_TTS,
    RTKBBproCapabilityType_RWS,
    RTKBBproCapabilityType_APT,
    RTKBBproCapabilityType_EQ,
    RTKBBproCapabilityType_VAD,
    RTKBBproCapabilityType_ANC,
    RTKBBproCapabilityType_LLAPT,
    
    RTKBBproCapabilityType_ANCS,
    RTKBBproCapabilityType_Vibration,
    RTKBBproCapabilityType_MFB,
    RTKBBproCapabilityType_GamingMode,
};


typedef NS_ENUM(uint8_t, RTKBBproPeripheralMMIType) {
    RTKBBproPeripheralMMIType_Null      = 0x00,
    RTKBBproPeripheralMMIType_VoiceDail = 0x09,
    RTKBBproPeripheralMMIType_VolUp     = 0x30,
    RTKBBproPeripheralMMIType_VolDown   = 0x31,
    RTKBBproPeripheralMMIType_PlayPause = 0x32,
    RTKBBproPeripheralMMIType_Forward   = 0x34,
    RTKBBproPeripheralMMIType_Backward  = 0x35,
    RTKBBproPeripheralMMIType_APT       = 0x65,
    RTKBBproPeripheralMMIType_EQSwitch  = 0x6B,
    
    RTKBBproPeripheralMMIType_NotSet  = 0xFF,
};

typedef NS_ENUM(uint8_t, RTKBBproPeripheralBudType) {
    RTKBBproPeripheralBudType_Default,
    RTKBBproPeripheralBudType_Left,
    RTKBBproPeripheralBudType_Right,
};

typedef NS_ENUM(uint8_t, RTKBBproPeripheralMMIStatus) {
    RTKBBproPeripheralMMIStatus_Idle,
    RTKBBproPeripheralMMIStatus_InCall,
};

typedef NS_ENUM(uint8_t, RTKBBproPeripheralMMIClickType) {
    RTKBBproPeripheralMMIClickType_None,
    RTKBBproPeripheralMMIClickType_Single = 0x01,
    RTKBBproPeripheralMMIClickType_Multi2,
    RTKBBproPeripheralMMIClickType_Multi3,
    RTKBBproPeripheralMMIClickType_LongPress,
    RTKBBproPeripheralMMIClickType_UtralLongPress,
};

typedef struct {
    RTKBBproPeripheralBudType bud;
    RTKBBproPeripheralMMIStatus status;
    RTKBBproPeripheralMMIClickType click;
    RTKBBproPeripheralMMIType MMI;
} RTKBBproMMIMapping;



typedef enum : uint8_t {
    RTKBBproMeridianSoundEffect_Off,
    RTKBBproMeridianSoundEffect_Bass,
    RTKBBproMeridianSoundEffect_Flat,
    RTKBBproMeridianSoundEffect_Treble,
} RTKBBproMeridianSoundEffect;




/**
 * A bitmask value indicate the EQ Setting index.
 * @discussion When used as current EQ Index only one current Index bit set to 1, when usded as supported EQ Indexes, all supported EQ index set to 1.
 */
typedef NS_OPTIONS(uint16_t, RTKBBproEQIndex) {
    RTKBBproEQIndexOff = 1 << 0,
    RTKBBproEQIndexCustomer1 = 1 << 1,  /* Bass Boost */
    RTKBBproEQIndexCustomer2 = 1 << 2,  /* Normal */
    RTKBBproEQIndexCustomer3 = 1 << 3,  /* Treble */
    RTKBBproEQIndexBuiltin1 = 1 << 4,
    RTKBBproEQIndexBuiltin2 = 1 << 5,
    RTKBBproEQIndexBuiltin3 = 1 << 6,
    RTKBBproEQIndexBuiltin4 = 1 << 7,
    RTKBBproEQIndexBuiltin5 = 1 << 8,
    RTKBBproEQIndexRealtime = 1 << 9,       /* The EQ can be adjusted in UI */
    RTKBBproEQIndexRealtime2 = 1 << 10,       /* The EQ can be adjusted in UI */
};

typedef NS_OPTIONS(uint8_t, RTKBBproLegacyProfile) {
    RTKBBproLegacyProfile_A2DP = 1 << 0,
    RTKBBproLegacyProfile_AVRCP = 1 << 1,
    RTKBBproLegacyProfile_HFHS = 1 << 2,
    RTKBBproLegacyProfile_Vendor = 1 << 3,
    RTKBBproLegacyProfile_SPP = 1 << 4,
    RTKBBproLegacyProfile_iAP = 1 << 5,
    RTKBBproLegacyProfile_PBAP = 1 << 6,
};

#endif /* RTKBBproType_h */
