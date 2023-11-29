//
//  RTKANCSStructure.h
//  RTKLEFoundation
//
//  Created by jerome_gu on 2019/2/27.
//  Copyright © 2019 Realtek. All rights reserved.
//

#ifndef RTKANCSStructure_h
#define RTKANCSStructure_h

typedef NS_ENUM(uint8_t, ANCSCategoryID) {
    CategoryIDOther,
    CategoryIDIncomingCall,
    CategoryIDMissedCall,
    CategoryIDVoicemail,
    CategoryIDSocial,
    CategoryIDSchedule,
    CategoryIDEmail,
    CategoryIDNews,
    CategoryIDHealthAndFitness,
    CategoryIDBusinessAndFinance,
    CategoryIDLocation,
    CategoryIDEntertainment,
};

typedef NS_ENUM(uint8_t, ANCSEventID) {
    EventIDNotificationAdded,
    EventIDNotificationModified,
    EventIDNotificationRemoved,
};

typedef NS_OPTIONS(NSUInteger, ANCSEventFlag) {
    EventFlagSilent = 1 << 0,
    EventFlagImportant = 1 << 1,
    EventFlagPreExisting = 1 << 2,
    EventFlagPositiveAction = 1 << 2,
    EventFlagNegativeAction = 1 << 2,
};


#pragma pack(push, 1)
typedef struct {
    uint8_t ID;
    uint8_t flag;
    uint8_t category;
    uint8_t count;
    uint32_t notificationUID;
} ANCSNotificationEvent;


typedef struct {
    uint8_t ID;
    uint16_t length;
    uint8_t attributeStart;
} ANCSNotificationAttributeElement;

typedef struct {
    uint8_t cmdID;
    uint32_t notificationUID;
    ANCSNotificationAttributeElement firstAttribute;
    
} ANCSNotificationAttribute;

#pragma pack(pop)

#endif /* RTKANCSStructure_h */
