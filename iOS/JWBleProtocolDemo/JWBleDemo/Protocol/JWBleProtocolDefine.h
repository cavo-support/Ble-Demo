//
//  JWBleProtocolDefine.h
//  JWBleDemo
//
//  Created by bobobo on 2023/5/5.
//  Copyright © 2023 wosmart. All rights reserved.
//

#import "JWBleProtocolModel.h"

#pragma mark - 状态枚举 State enumeration
//蓝牙连接状态枚举 Bluetooth connection status enumeration
typedef NS_ENUM (NSInteger, ConnectStatus) {
    ConnectStatus_DisConnect = 0,//断开连接 Disconnect
    ConnectStatus_Connect,//已经连接 Already connected
    ConnectStatus_BondSuccess,//绑定成功 Bind successfully
    ConnectStatus_BondFailure,//绑定失败 Bind failed
    ConnectStatus_SyncSuccess,//同步信息成功 Information synchronization succeeded
    ConnectStatus_SyncFailure,//同步信息失败 Sync information failed
    ConnectStatus_DiscoverNewUpdateFirm,//发现可以升级的新固件 Discover new firmware that can be upgraded
    ConnectStatus_BatteryUpdate,//电量改变了 The battery has changed
    ConnectStatus_ChargeStatusChanged,//充电状态改变 Change in state of charge
    ConnectStatus_HeadphoneDeviceStatusChanged,//耳机状态改变 Headphone status changes
    ConnectStatus_TimeOutDisconnect,//通信超时，已主动断开连接 Communication timed out and disconnected actively
    ConnectStatus_DeviceStatusChanges,//设备状态改变（省点模式、飞行模式等） Device status changes (point-saving mode, flight mode, etc.)
    ConnectStatus_BondConfirm_NotAllowed,//绑定失败，用户点击不允许 Binding failed, user click is not allowed
    ConnectStatus_BondConfirm_TimeOut,//绑定失败，用户不操作设备 The binding fails, the user does not operate the device
    ConnectStatus_BleRemovedPairingInformation,//系统绑定的蓝牙设备缓存被删除，一般是被其它手机也系统绑定了 The bluetooth device cache bound by the system is deleted, usually it is bound by other mobile phones
    ConnectStatus_Temp
};


//接收扫描到的设备 Receive scanned device
typedef void(^ScanningDeviceCallBack)(JWBleProtocolModel* peripheral);

//连接设备成功 Device connected successfully
typedef void (^ConnectStatusChangeCallBack)(ConnectStatus deviceConnectStatus);
