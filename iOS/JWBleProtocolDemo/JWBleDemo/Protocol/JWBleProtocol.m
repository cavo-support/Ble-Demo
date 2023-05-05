//
//  JWBleProtocol.m
//  JWBleDemo
//
//  Created by bobobo on 2023/5/5.
//  Copyright © 2023 wosmart. All rights reserved.
//

#import "JWBleProtocol.h"
#import "JWBleProtocolModel.h"
#import "JWBleProtocolMethod.h"

#define SERVICE_WRISTBAND @"000001ff-3C17-D293-8E48-14FE2E4DA212" // main service
#define SERVICE_WRISTBAND_WRITE @"FF02" // write service
#define SERVICE_WRISTBAND_READ @"FF03" // read service

@interface JWBleProtocol ()
<
    CBCentralManagerDelegate,
    CBPeripheralDelegate
>

@property (nonatomic, strong) CBCentralManager *centralManager;
@property (nonatomic, strong) CBPeripheral *peripheral;
@property (nonatomic, strong) JWBleProtocolMethod *protocolMethod;
@property (nonatomic, strong) CBCharacteristic *writeCharacteristic, *notifyCharacteristic;

@property (nonatomic, copy) ScanningDeviceCallBack scanningDeviceCallBack;

@end

static JWBleProtocol *_sharedClient = nil;
static dispatch_once_t onceToken;

@implementation JWBleProtocol

+ (JWBleProtocol *)shareInstance {
    dispatch_once(&onceToken, ^{
        _sharedClient = [[JWBleProtocol alloc] init];
    });
    return _sharedClient;
}

- (instancetype)init {
    if (self = [super init]) {
        self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
        self.protocolMethod = [JWBleProtocolMethod new];
        self.protocolMethod.centralManager = self.centralManager;
    }
    return self;
}

#pragma mark - public
- (void)scanDeviceWithCallBack:(ScanningDeviceCallBack)callBack {
    self.scanningDeviceCallBack = callBack;
    
    [self.centralManager scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:SERVICE_WRISTBAND]] options:nil];
}

- (void)connectDevice:(JWBleProtocolModel *)model {
    [self.centralManager connectPeripheral:model.per options:nil];
    [self.centralManager stopScan];
}

#pragma mark - CBCentralManagerDelegate
- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    if (central.state == CBCentralManagerStatePoweredOn) {
    } else {
        
    }
}

- (void)centralManager:(CBCentralManager *)central willRestoreState:(NSDictionary<NSString *, id> *)dict {
    
}

-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI {
    
    if (self.scanningDeviceCallBack) {
        JWBleProtocolModel *model = [JWBleProtocolModel new];
        model.per = peripheral;
        model.RSSI = RSSI;
        model.advertisementData = advertisementData;
        self.scanningDeviceCallBack(model);
    }
    
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    
    self.peripheral = peripheral;
    
    [self.peripheral setDelegate:self];
    [self.peripheral discoverServices:nil];
}

-(void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
   NSLog(@"%@",error);
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error {
    [self.centralManager connectPeripheral:peripheral options:nil];
}

-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
    for (CBService *s in peripheral.services) {
        [peripheral discoverCharacteristics:nil forService:s];
    }
}

-(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
    
    if ([[service.UUID UUIDString] isEqualToString:@"000001FF-3C17-D293-8E48-14FE2E4DA212"]) {
        for (CBCharacteristic *characteristic in service.characteristics) {
            if ([[characteristic.UUID UUIDString] isEqualToString:SERVICE_WRISTBAND_WRITE]) {
                NSLog(@"SERVICE_WRISTBAND_WRITE characteristic.uuid = %@",characteristic.UUID);
                self.writeCharacteristic = characteristic;
            } else if ([[characteristic.UUID UUIDString] isEqualToString:SERVICE_WRISTBAND_READ]) {
                NSLog(@"SERVICE_WRISTBAND_READ characteristic.uuid = %@",characteristic.UUID);
                [peripheral setNotifyValue:true forCharacteristic:characteristic];
                self.notifyCharacteristic = characteristic;
            }
        }
        
        if (self.writeCharacteristic && self.notifyCharacteristic) {
            self.protocolMethod.peripheral = self.peripheral;
            self.protocolMethod.writeCharacteristic = self.writeCharacteristic;
            self.protocolMethod.notifyCharacteristic = self.notifyCharacteristic;
            
            //bond
            NSString *identifierForVendor = @"JWBle";
            NSData *data1 = [identifierForVendor dataUsingEncoding:NSUTF8StringEncoding];

            UInt8 byte64[64] = {0};
            NSMutableData *myD = [NSMutableData dataWithBytes:byte64 length:64];
            [myD replaceBytesInRange:NSMakeRange(0, identifierForVendor.length) withBytes:data1.bytes length:identifierForVendor.length];
            UInt8 *bondID = (UInt8 *) [myD bytes];
            [self.protocolMethod wBLoginWithID:bondID isBond:true];
        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:SERVICE_WRISTBAND_READ]]) {
        [self.protocolMethod analysisNotifyData:characteristic.value];
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    if (error) {
         NSLog(@"Error changing notification state: %@", error.localizedDescription);
    }
    if (characteristic.isNotifying) {
        [peripheral readValueForCharacteristic:characteristic];
    } else {
        NSLog(@"Notification stopped on %@.  Disconnecting", characteristic);
    }
}

@end
