//
//  CombineInterfaceBinHelp.h
//  JWBleDemo
//
//  Created by bobobo on 2023/9/13.
//  Copyright © 2023 wosmart. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CombineInterfaceBinHelp : NSObject

+ (NSData *)combinWithChipType:(int)chipType
                        image:(UIImage *)bgImage
                  previewImage:(UIImage *)previewImage;

@end
