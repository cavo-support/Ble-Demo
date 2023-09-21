//
//  CombineInterfaceBinHelp.m
//  JWBleDemo
//
//  Created by bobobo on 2023/9/13.
//  Copyright © 2023 wosmart. All rights reserved.
//

#import "CombineInterfaceBinHelp.h"
#import "ImageRGBRGBHelper.h"
#import "ImgHeadUtil.h"

@implementation CombineInterfaceBinHelp

+ (NSData *)combinWithChipType:(int)chipType
                         image:(UIImage *)bgImage
                  previewImage:(UIImage *)previewImage {
    
    //获取图片的565数据
    NSData *bgImageData565 = [self getImage565:bgImage width:bgImage.size.width height:bgImage.size.height];
    NSData *previewImageData565 = [self getImage565:previewImage width:previewImage.size.width height:previewImage.size.height];
    
    //大小端转换一波
    NSMutableData *tempBgImageData565 = [[NSMutableData alloc] initWithCapacity:0];
    for (int i = 0; i < bgImageData565.length/2; i++) {
        NSData *data1 = [bgImageData565 subdataWithRange:NSMakeRange(i*2, 1)];
        NSData *data2 = [bgImageData565 subdataWithRange:NSMakeRange(i*2+1, 1)];
        [tempBgImageData565 appendData:data2];
        [tempBgImageData565 appendData:data1];
    }
    bgImageData565 = tempBgImageData565;
    
    NSMutableData *tempPreviewImageData565 = [[NSMutableData alloc] initWithCapacity:0];
    for (int i = 0; i < previewImageData565.length/2; i++) {
        NSData *data1 = [previewImageData565 subdataWithRange:NSMakeRange(i*2, 1)];
        NSData *data2 = [previewImageData565 subdataWithRange:NSMakeRange(i*2+1, 1)];
        [tempPreviewImageData565 appendData:data2];
        [tempPreviewImageData565 appendData:data1];
    }
    previewImageData565 = tempPreviewImageData565;
    
    NSMutableData *data = [NSMutableData new];
    [data appendData:bgImageData565];
    [data appendData:previewImageData565];
    NSData *fullData = data;
    
    //获取image、mp header
    NSData *imageHeaderData = nil;
    NSData *mpHeaderData = nil;
    if (chipType == 0) {
        imageHeaderData = [ImgHeadUtil getImgHeader:fullData];
        mpHeaderData = [ImgHeadUtil getMpHeader:fullData];
    } else if (chipType == 1) {
        imageHeaderData = [ImgHeadUtil getImgHeader_VD:fullData];
        mpHeaderData = [ImgHeadUtil getMpHeader_VD:fullData];
    }
    
    //组合目标data
    data = [NSMutableData new];
    [data appendData:mpHeaderData];
    [data appendData:imageHeaderData];
    [data appendData:fullData];
    
    //计算full 数组的长度，确保是4的整数倍，不足补0
    NSUInteger c = data.length/4;
    NSUInteger d = data.length%4;
    NSUInteger targetLen = 0;
    if (d > 0) {
        targetLen = (c+1) * 4;
    }
    
    if (targetLen > 0) {
        for (int i = 0; i > targetLen; i++) {
            [data appendData:[self int2Data:0]];
        }
    }
    
    return data;
}


+ (NSData *)getImage565:(UIImage *)image width:(int)width height:(int)height {
    
    image = [self image:image byScalingToSize:CGSizeMake(width, height)];
    unsigned char *charStr = [ImageRGBRGBHelper convertUIImageToBitmapRGBRGB:image];
    
    NSMutableData *data = [NSMutableData dataWithCapacity:width* height * 3];
    for (int i = 0; i < width* height * 3; i++) {
        int value = (int)charStr[i];
        [data appendData:[NSData dataWithBytes:&value length:1]];
    }
    
    //先创建一个565bmp数据流
    Byte byte[500*500*3] = {0x00};
    
    int span = 3;
    for (NSInteger i = 0; i < width * height; i++) {
        //比如原有的数据是 charStr
        //接下来rgb 3字节转 565 2字节
        UInt8 r = charStr[0+span*i];
        UInt8 g = charStr[1+span*i];
        UInt8 b = charStr[2+span*i];
        
        //组成新的565
        //问一下嵌入式565是rgb还是bgr，如果是bgr，r和b就对调一下
        int newRGBValue = ((r >> 3) << 11) | ((g >> 2) << 5) | (b >> 3);
        UInt8 hightByte = (newRGBValue & 0xFF00) >> 8;
        UInt8 lowByte = (newRGBValue & 0x00FF) >> 0;
        byte[i*2] = lowByte;
        byte[i*2+1] = hightByte;
    }

    //上边高低位嵌入式怎么要求的就怎么来，如果不对对调一下试试
    return [NSData dataWithBytes:byte length:width * height * 2];
}

+ (UIImage *)image:(UIImage*)image byScalingToSize:(CGSize)targetSize {
    UIImage *sourceImage = image;
    UIImage *newImage = nil;
 
    UIGraphicsBeginImageContext(targetSize);
 
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = CGPointZero;
    thumbnailRect.size.width  = targetSize.width;
    thumbnailRect.size.height = targetSize.height;
 
    [sourceImage drawInRect:thumbnailRect];
 
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
 
    return newImage;
}

+ (NSData *)int2Data:(int)value {
    return [NSData dataWithBytes:&value length:1];
}

@end
