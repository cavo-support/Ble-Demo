
//
//  RTKProfileAttributeKey.h
//  RTKLEFoundation
//
//  Created by jerome_gu on 2019/1/21.
//  Copyright © 2019 Realtek. All rights reserved.
//

#ifndef RTKProfileAttributeKey_h
#define RTKProfileAttributeKey_h

#import <Foundation/Foundation.h>

/* RTKProfileAttribute的索引Key */
typedef NSString *RTKProfileAttributeKey NS_EXTENSIBLE_STRING_ENUM;

extern RTKProfileAttributeKey const RTKPeripheralNoneAttributeKey;   /* 表示不存在 */
extern RTKProfileAttributeKey const RTKPeripheralNameAttributeKey;   /* 表示外设名称 */
extern RTKProfileAttributeKey const RTKPeripheralRSSIAttributeKey;   /* 表示RSSI值 */

#endif /* RTKProfileAttributeKey_h */
