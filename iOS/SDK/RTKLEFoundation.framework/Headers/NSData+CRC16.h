//
//  NSData+CRC16.h
//  RTKOTASDK
//
//  Created by jerome_gu on 2019/4/25.
//  Copyright © 2019 Realtek. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (CRC16)

@property (nonatomic, readonly) uint16_t crc16Value;

@end

NS_ASSUME_NONNULL_END
