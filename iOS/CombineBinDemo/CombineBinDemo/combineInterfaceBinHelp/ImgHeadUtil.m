//
//  ImgHeadUtil.m
//  JWBle
//
//  Created by Bo 黄 on 2020/9/1.
//  Copyright © 2020 wosmart. All rights reserved.
//

#import "ImgHeadUtil.h"

@implementation ImgHeadUtil

+ (NSData *)getImgHeader:(NSData *)originData {
    int len = 1024;
    Byte data[1024] = {0x00};
    
    for (int i = 0; i < len; i++) {
        data[i] = (Byte) 0xff;
    }
    
    data[0] = 0x05;
    data[1] = 0x00;
    data[2] = 0x70;
    data[3] = (Byte) 0xFD;
    data[4] = (Byte) 0xFE;
    data[5] = (Byte) 0xFF;
    
    int crc16 = gen_crc16((const uint8_t *)originData.bytes, (uint16_t)originData.length);
    data[6] = (Byte) (crc16 & 0xFF);
    data[7] = (Byte) ((crc16 & 0xFF) >> 8);
    
    NSUInteger originLen = originData.length;
    data[8] = (Byte) (originLen & 0xFF);
    data[9] = (Byte) ((originLen >> 8) & 0xFF);
    data[10] = (Byte) ((originLen >> 16) & 0xFF);
    data[11] = (Byte) ((originLen >> 24) & 0xFF);
//    data[8] = 0x88;
//    data[9] = 0xB9;
//    data[10] = 0x02;
//    data[11] = 0x00;
    
    NSData *resultData = [NSData dataWithBytes:data length:1024];
    Byte uuid[16] = {0x6d, 0x67, (Byte) 0xde, (Byte) 0xf1, 0x3e, 0x33, (Byte) 0xe8, 0x11, (Byte) 0xb1, 0x02, 0x4d, 0x2d, (Byte) 0xf4, 0x0c, (Byte) 0xde, 0x01};
    NSData *uuidData = [NSData dataWithBytes:uuid length:16];
    
    NSMutableData *aaa = [NSMutableData new];
    [aaa appendData:[resultData subdataWithRange:NSMakeRange(0, 12)]];
    [aaa appendData:uuidData];
    [aaa appendData:[resultData subdataWithRange:NSMakeRange(aaa.length, 1024-aaa.length)]];
    
    return [aaa mutableCopy];
}

+ (NSData *)getMpHeader:(NSData *)originData {
    int len = 512;
    Byte data[512] = {0x00};
    
    for (int i = 0; i < len; i++) {
        data[i] = 0x00;
    }
    
    // bin
    data[0] = 0x01;
    data[1] = 0x00;
    data[2] = 0x02;
    data[3] = 0x02;
    data[4] = 0x09;

    //version
    data[5] = 0x02;
    data[6] = 0x00;
    data[7] = 0x04;
    data[8] = 0x00;
    data[9] = 0x00;
    data[10] = 0x00;
    data[11] = 0x08;

    //part number
    data[12] = 0x03;
    data[13] = 0x00;
    data[14] = 0x20;
    data[15] = 0x00;
    for (int i = 0; i < 31; i++) {
        data[16 + i] = (Byte) 0xFF;
    }

    //origin data length
    data[47] = 0x04;
    data[48] = 0x00;
    data[49] = 0x04;
    int originLen = originData.length + 1024;// + 512;
    data[50] = (Byte) (originLen & 0xFF);
    data[51] = (Byte) ((originLen >> 8) & 0xFF);
    data[52] = (Byte) ((originLen >> 16) & 0xFF);
    data[53] = (Byte) ((originLen >> 24) & 0xFF);
//    data[50] = 0x88;
//    data[51] = 0xbd;
//    data[52] = 0x02;
//    data[53] = 0x00;

    // ota version
    data[54] = 0x11;
    data[55] = 0x00;
    data[56] = 0x01;
    data[57] = 0x01;

    //image id
    data[58] = 0x12;
    data[59] = 0x00;
    data[60] = 0x02;
    data[61] = (Byte) 0xFE;
    data[62] = (Byte) 0xFF;

    //full image size
    data[63] = 0x14;
    data[64] = 0x00;
    data[65] = 0x04;
    
    int fullLength = originData.length + 1024;
    data[66] = (Byte) (fullLength & 0xFF);
    data[67] = (Byte) ((fullLength >> 8) & 0xFF);
    data[68] = (Byte) ((fullLength >> 16) & 0xFF);
    data[69] = (Byte) ((fullLength >> 24) & 0xFF);
//    data[66] = 0x88;
//    data[67] = 0xbd;
//    data[68] = 0x02;
//    data[69] = 0x00;

    //secure version
    data[70] = 0x15;
    data[71] = 0x00;
    data[72] = 0x01;
    data[73] = 0x00;

    //image version
    data[74] = 0x16;
    data[75] = 0x00;
    data[76] = 0x04;
    data[77] = 0x00;
    data[78] = 0x00;
    data[79] = 0x00;
    data[80] = 0x08;
    
//    data[81] = 0x22;
//    data[82] = 0x00;
//    data[83] = 0x01;
//    data[84] = 0x02;
    
    return [NSData dataWithBytes:data length:512];
}

+ (NSData *)getImgHeader_VD:(NSData *)originData {
    
    int len = 1024;
    Byte data[1024] = {0x00};

    for (int i = 0; i < len; i++) {
        data[i] = (Byte) 0xff;
    }

    data[0] = 0x09;
    data[1] = 0x00;
    data[2] = 0x70;
    data[3] = (Byte) 0xFD;
    data[4] = (Byte) 0xFE;
    data[5] = (Byte) 0xFF;

    data[6] = 0x00;
    data[7] = 0x00;

    NSUInteger originLen = originData.length;
    data[8] = (Byte) (originLen & 0xFF);
    data[9] = (Byte) ((originLen >> 8) & 0xFF);
    data[10] = (Byte) ((originLen >> 16) & 0xFF);
    data[11] = (Byte) ((originLen >> 24) & 0xFF);

    NSData *resultData = [NSData dataWithBytes:data length:1024];
    Byte uuid[16] = {0x6d, 0x67, (Byte) 0xde, (Byte) 0xf1, 0x3e, 0x33, (Byte) 0xe8, 0x11, (Byte) 0xb1, 0x02, 0x4d, 0x2d, (Byte) 0xf4, 0x0c, (Byte) 0xde, 0x01};
    NSData *uuidData = [NSData dataWithBytes:uuid length:16];

    NSMutableData *data68 = [NSMutableData new];
    for (int i = 0; i < 68; i++) {
        Byte bb[1] = {(Byte)0xFF};
        [data68 appendData:[NSData dataWithBytes:bb length:1]];
    }

    Byte cc[4] = {0x00};
    cc[0] = 0x00;
    cc[1] = 0x00;
    cc[2] = 0x00;
    cc[3] = 0x10;
    [data68 appendData:[NSData dataWithBytes:cc length:4]];

    NSMutableData *aaa = [NSMutableData new];
    [aaa appendData:[resultData subdataWithRange:NSMakeRange(0, 12)]];
    [aaa appendData:uuidData];
    [aaa appendData:data68];
    [aaa appendData:[resultData subdataWithRange:NSMakeRange(aaa.length, 1024-aaa.length)]];

    return [aaa mutableCopy];
}

+ (NSData *)getMpHeader_VD:(NSData *)originData {
    int len = 512;
    Byte data[512] = {0x00};
    
    for (int i = 0; i < len; i++) {
        data[i] = 0x00;
    }
    
    // bin
    data[0] = 0x01;
    data[1] = 0x00;
    data[2] = 0x02;
    data[3] = 0x01;
    data[4] = 0x09;

    //version
    data[5] = 0x02;
    data[6] = 0x00;
    data[7] = 0x04;
    data[8] = 0x00;
    data[9] = 0x00;
    data[10] = 0x00;
    data[11] = 0x10; //--change

    //part number
    data[12] = 0x03;
    data[13] = 0x00;
    data[14] = 0x20;
    data[15] = 0x00;
    for (int i = 0; i < 32; i++) {
        data[16 + i] = (Byte) 0xFF;
    }

    //origin data length
    data[47] = 0x04;
    data[48] = 0x00;
    data[49] = 0x04;
    int originLen = originData.length + 1024;// + 512;
    data[50] = (Byte) (originLen & 0xFF);
    data[51] = (Byte) ((originLen >> 8) & 0xFF);
    data[52] = (Byte) ((originLen >> 16) & 0xFF);
    data[53] = (Byte) ((originLen >> 24) & 0xFF);

    // ota version
    data[54] = 0x11;
    data[55] = 0x00;
    data[56] = 0x01;
    data[57] = 0x01;

    //image id
    data[58] = 0x12;
    data[59] = 0x00;
    data[60] = 0x02;
    data[61] = (Byte) 0xFE;
    data[62] = (Byte) 0xFF;

    //full image size
    data[63] = 0x14;
    data[64] = 0x00;
    data[65] = 0x04;
    
    int fullLength = originData.length + 1024;
    data[66] = (Byte) (fullLength & 0xFF);
    data[67] = (Byte) ((fullLength >> 8) & 0xFF);
    data[68] = (Byte) ((fullLength >> 16) & 0xFF);
    data[69] = (Byte) ((fullLength >> 24) & 0xFF);
    
    //secure version
    data[70] = 0x15;
    data[71] = 0x00;
    data[72] = 0x01;
    data[73] = 0x00;

    //image version
    data[74] = 0x16;
    data[75] = 0x00;
    data[76] = 0x04;
    data[77] = 0x00;
    data[78] = 0x00;
    data[79] = 0x00;
    data[80] = 0x10; //---change
    
    data[81] = 0x22;
    data[82] = 0x00;
    data[83] = 0x01;
    data[84] = 0x02;
    
    return [NSData dataWithBytes:data length:512];
}


#define PLOY 0X1021
uint16_t gen_crc16(const uint8_t *data, uint16_t size) {
    uint16_t crc = 0;
    uint8_t i;
    for (; size > 0; size--) {
        crc = crc ^ (*data++ <<8);
        for (i = 0; i < 8; i++) {
            if (crc & 0X8000) {
                crc = (crc << 1) ^ PLOY;
            }else {
                crc <<= 1;
            }
        }
        crc &= 0XFFFF;
    }
    return crc;
}


/**
 *将图片缩放到指定的CGSize大小
 * UIImage image 原始的图片
 * CGSize size 要缩放到的大小
 */
+(UIImage*)image:(UIImage *)image scaleToSize:(CGSize)size {
    
    // 得到图片上下文，指定绘制范围
    UIGraphicsBeginImageContext(size);
    
    // 将图片按照指定大小绘制
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    // 从当前图片上下文中导出图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 当前图片上下文出栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}

@end
