//
//  ImgHeadUtil.h
//  JWBle
//
//  Created by Bo 黄 on 2020/9/1.
//  Copyright © 2020 wosmart. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImgHeadUtil : NSObject

+ (NSData *)getImgHeader:(NSData *)originData;

+ (NSData *)getMpHeader:(NSData *)originData;

+ (NSData *)getImgHeader_VD:(NSData *)originData;

+ (NSData *)getMpHeader_VD:(NSData *)originData;

/**
 *将图片缩放到指定的CGSize大小
 * UIImage image 原始的图片
 * CGSize size 要缩放到的大小
 */
+(UIImage*)image:(UIImage *)image scaleToSize:(CGSize)size;

@end

