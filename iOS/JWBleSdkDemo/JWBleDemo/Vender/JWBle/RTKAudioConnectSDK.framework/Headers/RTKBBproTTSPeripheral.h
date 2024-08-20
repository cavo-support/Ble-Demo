//
//  RTKBBproTTSPeripheral.h
//  RTKAudioConnectSDK
//
//  Created by jerome_gu on 2019/4/12.
//  Copyright © 2019 Realtek. All rights reserved.
//

#import <RTKAudioConnectSDK/RTKAudioConnectSDK.h>

NS_ASSUME_NONNULL_BEGIN


/**
 * TTS服务状态
 */
typedef NS_ENUM(NSUInteger, RTKBBproTTSState) {
    RTKBBproTTSStateIdle,         /* 空闲中，等待来电事件 */
    RTKBBproTTSStateNameLookup,     /* 查找来电者名字 */
    RTKBBproTTSStateSynthesizing,       /* 合成语音中 */
    RTKBBproTTSStateTransfering,        /* 传输语音数据中 */
};

/*
@class RTKBBproTTSPeripheral;

@protocol RTKBBproTTSPeripheralDelegate <RTKLEPeripheralDelegate>
@required
- (void)BBproPeripheral:(RTKBBproTTSPeripheral *)client willSynthesizeForCaller:(NSString *)name;
- (void)BBproPeripheral:(RTKBBproTTSPeripheral *)client failToSynthesizeForCaller:(NSString *)name error:(nullable NSError *)error;
- (void)BBproPeripheralWillReceiveSpeechData:(RTKBBproTTSPeripheral *)client;
- (void)BBproPeripheralDidFinishReceiveSpeechData:(RTKBBproTTSPeripheral *)client withError:(nullable NSError *)error;
- (void)BBproPeripheralDidAbortReceiveSpeechData:(RTKBBproTTSPeripheral *)client;

@end
 */


@interface RTKBBproTTSPeripheral : RTKBBproPeripheral



//@property (weak, nullable) id<RTKBBproTTSPeripheralDelegate> delegate;

@property (readonly, nullable) NSDate *lastIncomeCallDate;
@property (readonly, nullable) NSString *lastCaller;
@property (readonly) float lastTransmissionRate;

@end

NS_ASSUME_NONNULL_END
