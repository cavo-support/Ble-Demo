//
//  JWBleCustomizeMainInterfaceAction.h
//  JWBle
//
//  Created by Bo 黄 on 2020/9/1.
//  Copyright © 2020 wosmart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JWBleCustomizeMainInterfaceActionConfigModel.h"

typedef NS_ENUM (NSInteger, JWBleCustomizeMainInterfaceActionStatus) {
    JWBleCustomizeMainInterfaceActionStatus_MakingResourcePack,//制作资源包中
    JWBleCustomizeMainInterfaceActionStatus_PictureIsEmpty,//图片为空
    JWBleCustomizeMainInterfaceActionStatus_FailedToParseImage,//解析图片失败
    JWBleCustomizeMainInterfaceActionStatus_FailedToMakeResourcePack,//制作资源包失败
    JWBleCustomizeMainInterfaceActionStatus_Transmission,//传输中
    JWBleCustomizeMainInterfaceActionStatus_Success,
    JWBleCustomizeMainInterfaceActionStatus_Failure,
};

typedef void (^JWBleCustomizeMainInterfaceActionCallBack)(JWBleCustomizeMainInterfaceActionStatus actionStatus);

typedef void (^JWBleCustomizeMainInterfaceCombinedDataSuccessCallBack)(NSDictionary *dataDic);

@interface JWBleCustomizeMainInterfaceAction : NSObject

+ (void)startWithImage:(UIImage *)bgImage
          previewImage:(UIImage *)previewImage
            configModel:(JWBleCustomizeMainInterfaceActionConfigModel *)configModel
        actionCallBack:(JWBleCustomizeMainInterfaceActionCallBack)actionCallBack
        updateCallBack:(JWBleDFUCallBack)updateCallBack;

+ (void)startWithImage:(UIImage *)bgImage
          previewImage:(UIImage *)previewImage
          previewWidth:(int)previewWidth
            configModel:(JWBleCustomizeMainInterfaceActionConfigModel *)configModel
        actionCallBack:(JWBleCustomizeMainInterfaceActionCallBack)actionCallBack
        updateCallBack:(JWBleDFUCallBack)updateCallBack;

/**
 动态图片大小
 */
+ (void)startWithImage:(UIImage *)bgImage
          previewImage:(UIImage *)previewImage
          deviceWidth:(int)deviceWidth
           deviceHeight:(int)deviceHeight
            configModel:(JWBleCustomizeMainInterfaceActionConfigModel *)configModel
        actionCallBack:(JWBleCustomizeMainInterfaceActionCallBack)actionCallBack
        updateCallBack:(JWBleDFUCallBack)updateCallBack;
/**
 动态图片大小
 */
+ (void)startWithImage:(UIImage *)bgImage
          previewImage:(UIImage *)previewImage
          deviceWidth:(int)deviceWidth
           deviceHeight:(int)deviceHeight
            configModel:(JWBleCustomizeMainInterfaceActionConfigModel *)configModel
        actionCallBack:(JWBleCustomizeMainInterfaceActionCallBack)actionCallBack
combinedDataSuccessCallBack:(JWBleCustomizeMainInterfaceCombinedDataSuccessCallBack)combinedDataSuccessCallBack
        updateCallBack:(JWBleDFUCallBack)updateCallBack;

+ (unsigned char *) convertUIImageToBitmapRGBRGB:(UIImage *) image;

@end

