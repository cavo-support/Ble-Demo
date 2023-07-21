//
//  RTKLECentralManager.h
//  RTKLEFoundation
//
//  Created by jerome_gu on 2019/1/7.
//  Copyright © 2019 Realtek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "RTKLEGeneralDefines.h"
#import "RTKLEPeripheral.h"


NS_ASSUME_NONNULL_BEGIN

@class RTKLECentralManager;

/**
 * Two methods a Delegate implements to receive notification of centralManager availability.
 */
@protocol RTKLECentralManagerDelegate <NSObject>

/**
 * Invoked when centralManager change to be available.
 */
- (void)centralManagerDidBecomeAvailable:(RTKLECentralManager *)manager;

/**
 * Invoked when centralManager change to be unavailable.
 */
- (void)centralManagerDidBecomeUnavailable:(RTKLECentralManager *)manager;

@end


/**
 * A set methods RTKLECentralManager use to notify connection state to watcher.
 */
@protocol RTKPeripheralConnetionWatch <NSObject>
@optional
- (void)didConnectPeripheral:(RTKLEPeripheral *)peripheral;

- (void)failToConnectPeripheral:(RTKLEPeripheral *)peripheral withError:(nullable NSError *)err;

- (void)didDisconnectPeripheral:(RTKLEPeripheral *)peripheral withError:(nullable NSError *)err;

@end



/**
 * A Realtek wrapper of CBCentralManager
 * @discussion Used in context of Realtek SDK
 */
@interface RTKLECentralManager : NSObject

@property (weak, nullable) id<RTKLECentralManagerDelegate> delegate;

/**
 * The underlying CBCentralManager instance.
 */
@property (readonly) CBCentralManager *centralManager;

+ (instancetype)sharedManager;

- (instancetype)initWithDelegate:(id<RTKLECentralManagerDelegate>)delegate;


#pragma mark - Scan
@property (readonly) BOOL isScaning;

- (void)scanPeripheralWithServiceIDs:(nullable NSArray<CBUUID*>*)serivceIDs;

- (void)stopScan;

- (void)scanPeripheralWithServiceIDs:(nullable NSArray<CBUUID*>*)serivceIDs discoveryBlock:(void(^)(RTKLEPeripheral*))discoveredHandler;

//- (void)scanPeripheralAdvertiseService:(NSArray<CBUUID*>*)serivceIDs discoveryBlock:(BOOL(^)(CBPeripheral*, NSDictionary<NSString *, id> *, NSNumber*))discoveredHandler forInterval:(NSTimeInterval)timeout timeoutHandler:(void(^)(void))handler;


/**
 * Return a RTKLEPeripheral instance from CBPeripheral.
 * @disscusion If peri is a CBPeripheral in context of another CBCentralManager (not the underlying one of RTKLECentralManager), corresponding CBPeripheral maybe created.
 */
- (nullable RTKLEPeripheral *)peripheralFromCBPeripheral:(CBPeripheral *)peri;


#pragma mark - Connection

- (void)connectTo:(RTKLEPeripheral *)peripheral;

- (void)connectTo:(RTKLEPeripheral *)peripheral withTimeout:(NSTimeInterval)timeout;

- (void)connectPermanentlyTo:(RTKLEPeripheral *)peripheral;

- (void)cancelConnectionWith:(RTKLEPeripheral *)peripheral;


// Block-style connection API
- (void)connectTo:(RTKLEPeripheral *)peripheral completion:(RTKLECompletionBlock)handler;

- (void)connectTo:(RTKLEPeripheral *)peripheral withTimeout:(NSTimeInterval)timeout completionHandler:(void(^)(BOOL success, NSError *_Nullable error))handler;

- (void)cancelConnectionWith:(RTKLEPeripheral *)peripheral completionHandler:(void(^)(BOOL success, NSError *_Nullable error))handler;

- (void)cancelConnectionWith:(RTKLEPeripheral *)peripheral withTimeout:(NSTimeInterval)timeout completionHandler:(void(^)(BOOL success, NSError *_Nullable error))handler;



- (void)addPeripheralConnetionWatcher:(id<RTKPeripheralConnetionWatch>)watcher ofPeripheral:(RTKLEPeripheral *)peripheral;
- (void)removePeripheralConnectionWatcher:(id<RTKPeripheralConnetionWatch>)watcher ofPeripheral:(RTKLEPeripheral *)peripheral;


/**
 * Peripherals managed by this manager.
 */
@property (readonly) NSArray <RTKLEPeripheral *> *managedPeripherals;


@end




@interface RTKPersistentPeripheralManager : RTKLECentralManager

@end

NS_ASSUME_NONNULL_END
