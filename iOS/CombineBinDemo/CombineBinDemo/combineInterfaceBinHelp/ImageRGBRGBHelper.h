//
//  ImageRGBRGBHelper.h
//  MallCoo
//
//  Created by admin on 14-9-26.
//  Copyright (c) 2014年 wyj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ImageRGBRGBHelper : NSObject


/** Converts a UIImage to RGBRGB bitmap.
 @param image - a UIImage to be converted
 @return a RGBRGB bitmap, or NULL if any memory allocation issues. Cleanup memory with free() when done.
 */
+ (unsigned char *) convertUIImageToBitmapRGBRGB:(UIImage *)image;

/** A helper routine used to convert a RGBA8 to UIImage
 @return a new context that is owned by the caller
 */
+ (CGContextRef) newBitmapRGBA8ContextFromImage:(CGImageRef)image;


/** Converts a RGBA8 bitmap to a UIImage.
 @param buffer - the RGBA8 unsigned char * bitmap
 @param width - the number of pixels wide
 @param height - the number of pixels tall
 @return a UIImage that is autoreleased or nil if memory allocation issues
 */
+ (UIImage *) convertBitmapRGBA8ToUIImage:(unsigned char *)buffer
                                withWidth:(int)width
                               withHeight:(int)height;
+ (UIImage*)imageFromRGB565:(void*)rawData width:(int)width height:(int)height;

+ (void)getRGBDataFromImage:(UIImage*)image withRGB:(void(^)(unsigned char r,unsigned char g,unsigned char b))completion;

+ (NSString*)fetchSSIDInfo;
@end
