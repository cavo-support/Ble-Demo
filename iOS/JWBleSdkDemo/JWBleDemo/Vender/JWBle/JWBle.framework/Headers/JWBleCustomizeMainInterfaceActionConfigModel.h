//
//  JWBleCustomizeMainInterfaceActionConfigModel.h
//  JWBle
//
//  Created by Bo 黄 on 2020/9/1.
//  Copyright © 2020 wosmart. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM (NSInteger, JWBleCustomizeMainInterfaceActionConfigModelColor) {
    JWBleCustomizeMainInterfaceActionConfigModelColor_White,
    JWBleCustomizeMainInterfaceActionConfigModelColor_Black,
};

typedef NS_ENUM(NSInteger, JWBleCustomizeMainInterfaceActionConfigModelPosition) {
    JWBleCustomizeMainInterfaceActionConfigModelPosition_Top_Left = 0,
    JWBleCustomizeMainInterfaceActionConfigModelPosition_Top_Middle,
    JWBleCustomizeMainInterfaceActionConfigModelPosition_Top_Right,
    
    JWBleCustomizeMainInterfaceActionConfigModelPosition_Middle_Left,
    JWBleCustomizeMainInterfaceActionConfigModelPosition_Middle_Middle,
    JWBleCustomizeMainInterfaceActionConfigModelPosition_Middle_Right,
    
    JWBleCustomizeMainInterfaceActionConfigModelPosition_Bottom_Left,
    JWBleCustomizeMainInterfaceActionConfigModelPosition_Bottom_Middle,
    JWBleCustomizeMainInterfaceActionConfigModelPosition_Bottom_Right,
};

@interface JWBleCustomizeMainInterfaceActionConfigModel : NSObject

@property(nonatomic, assign) JWBleCustomizeMainInterfaceActionConfigModelColor color;
@property(nonatomic, assign) JWBleCustomizeMainInterfaceActionConfigModelPosition position;

/**
 设备对应的坐标
 {
   "JWBleCustomizeMainInterfaceActionConfigModelPosition_Top_Middle": {"x":2,"y":5},{"x":2,"y":5}
 }
 */
@property(nonatomic, strong) NSDictionary *devicePositionDic;

@property(nonatomic, assign) int chipType;

@end

