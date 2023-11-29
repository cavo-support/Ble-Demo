//
//  RTKBBproProfile+Dump.h
//  RTKAudioConnectSDK
//
//  Created by jerome_gu on 2019/10/28.
//  Copyright © 2019 jerome_gu. All rights reserved.
//

#import <RTKAudioConnectSDK/RTKAudioConnectSDK.h>
#import <CoreBluetooth/CoreBluetooth.h>


NS_ASSUME_NONNULL_BEGIN

@interface RTKBBproProfile (Dump)

- (nullable NSObject *)instantiateDumpPeripheralWithCBPeripheral:(CBPeripheral *)peripheral;

@end

NS_ASSUME_NONNULL_END
