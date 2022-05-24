//
//  RTKGATTProfileClient.h
//  RTKLEFoundation
//
//  Created by jerome_gu on 2019/2/1.
//  Copyright © 2019 Realtek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RTKLECentralManager.h"
#import "RTKLEPeripheral.h"


NS_ASSUME_NONNULL_BEGIN

//typedef NS_ENUM(NSUInteger, RTKGATTProfileState) {
//    RTKGATTProfileStateInitial,
//    RTKGATTProfileStateDiscovering,
//    RTKGATTProfileStateInactive,
//    RTKGATTProfileStateSetuping,
//    RTKGATTProfileStateInService,
//    RTKGATTProfileStateTearingDown,
//
//    RTKGATTProfileStateDisconnection,
//
//    RTKGATTProfileStateError,   /* can't restart */
//};


@class RTKGATTProfileClient;

/**
 * A set methods a RTKGATTProfileDelegate implements to receive event of a RTKGATTProfileClient instance.
 */
@protocol RTKGATTProfileDelegate <NSObject>
@required

//- (void)GATTProfileDidUpdateState:(RTKGATTProfileClient *)client withError:(nullable NSError *)error;

/**
 * Invoked when Profile have discovered all required Service and Characterisitcs.
 * @discussion After all required Attributes discovered, client can make more operation.
 */
- (void)GATTProfileClientDidDiscoverRequiredGATTAttribute:(RTKGATTProfileClient *)profile;

/**
 * Invoked when Profile cannot discover all required Service and Characterisitcs.
 */
- (void)GATTProfileClient:(RTKGATTProfileClient *)profile failToDiscoverRequiredGATTAttributeWithError:(NSError *)error;

/**
 * Invoked when the Profile did start specific service.
 */
- (void)GATTProfileClientDidStartService:(RTKGATTProfileClient *)profile;

/**
 * Invoked when the Profile cannot start specific service.
 * @param error The error explain why this happened.
 */
- (void)GATTProfileClient:(RTKGATTProfileClient *)profile failToStartServiceWithError:(NSError *)error;

/**
 * Invoked when the specific service of Profile have stopped.
 */
- (void)GATTProfileClientDidStopService:(RTKGATTProfileClient *)profile;

/**
 * Invoked when the specific service of Profile cannot be stopped.
 * @param error The error explain why this happened.
 */
- (void)GATTProfileClient:(RTKGATTProfileClient *)profile failToStopServiceWithError:(NSError *)error;

@end



/**
 * Represent Client role of a GATT Profile.
 * @discussion Represent a use case with one LE peripheral. Abstraction class, need to be subclassed. 
 */
@interface RTKGATTProfileClient : NSObject <RTKPeripheralConnetionWatch> {
//@protected
//    RTKGATTProfileState _state;
}

/**
 * Designated initializer
 * @param peripheral The RTKLEPeripheral instance which Profile work on.
 * @param centralManager The RTKLECentralManager instance who manage the peripheral.
 */
- (instancetype)initWithPeripheral:(RTKLEPeripheral *)peripheral ofCentralManager:(RTKLECentralManager *)centralManager;

//@property (readonly) RTKGATTProfileState state;

/**
 * The RTKLECentralManager instance who manage the peripheral.
 */
@property (readonly) RTKLECentralManager *centralManager;

/**
 * The RTKLEPeripheral instance which Profile work on
 */
@property (readonly) RTKLEPeripheral *peripheral;

/**
 * Delegate instance to receive event of RTKGATTProfileClient.
 */
@property (weak, nullable) id<RTKGATTProfileDelegate> delegate;


/**
 * Return Primary Service IDs specific to this Profile.
 * @discussion Not support currently.
 */
+ (nullable NSArray<CBUUID*> *)primaryServiceIDs;

/**
 * Start discover GATT Service specific to this Profile.
 */
- (void)discoverServices;


/**
 * Start service specific to this Profile.
 */
- (void)start;

/**
 * Stop service specific to this Profile.
 */
- (void)stop;


// TODO: 实现下面的具体的操作接口
//- (void)connect;
//- (void)discoverServiceAttribute;
//- (void)prepare;
//- (void)start;
//- (void)disconnect;

@end

NS_ASSUME_NONNULL_END
