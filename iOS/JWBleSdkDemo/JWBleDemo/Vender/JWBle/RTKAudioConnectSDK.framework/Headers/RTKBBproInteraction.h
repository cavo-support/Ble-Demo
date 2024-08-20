//
//  RTKBBproInteraction.h
//  RTKLEFoundation
//
//  Created by jerome_gu on 2020/3/31.
//  Copyright © 2020 jerome_gu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RTKLEFoundation/RTKLEFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@class RTKBBproInteraction;

/**
 RTKBBproInteractionDelegate protocol define methods for inform RTKBBproInteraction object preparatory work result.
 */
@protocol RTKBBproInteractionDelegate <NSObject>

/**
 Invoked when BBproInteraction object is ready to start upper layer operation.
 */
- (void)BBproInteractionDidGetReady:(RTKBBproInteraction *)interaction;

/**
 Invoked when BBproInteraction object can not complete preparatory work. This may be caused by underlying stream open failure.
 */
- (void)BBproInteraction:(RTKBBproInteraction *)interaction canNotInteractionWithError:(NSError *)err;

@end


/**
 A abstract class which represent a communicaton with a remote BBpro-series device.
 
 This class is expected to only be subclass internal in this framwork. Code outside this framework should use concreate subclass directly.
 */
@interface RTKBBproInteraction : NSObject

/**
 Initialize and return a interaction instance which have a underlying message-layer communicaiton.
 
 @param messageCom A message communication used for underlying message exchange.
 */
- (instancetype)initWithMessageCommunication:(RTKPackageCommunication *)messageCom;

/**
 The current using message communication for underlying message exchange.
 */
@property (readonly) RTKPackageCommunication *messageCommunication;


/**
 The delegate object that will receive interaction events.
 */
@property (weak, nonatomic) id<RTKBBproInteractionDelegate> delegate;

/**
 When RTKBBproInteraction is create, before excute any upper interaction, -prepareForInteraction should be invoked. When RTKBBproInteraction object get ready, the delegate -BBproInteractionDidGetReady: will be called.
 */
- (void)prepareForInteraction;

@end


NS_ASSUME_NONNULL_END
