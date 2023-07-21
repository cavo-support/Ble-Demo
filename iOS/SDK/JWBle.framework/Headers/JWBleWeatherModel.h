//
//  JWBleWeatherModel.h
//  JWBle
//
//  Created by bobobo on 2023/5/23.
//  Copyright © 2023 wosmart. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, JWBleWeatherCode) {
    JWBleWeatherCode_Other = 0,
    JWBleWeatherCode_Sunny,//晴
    JWBleWeatherCode_Cloudy,//多云
    JWBleWeatherCode_Overcast,//阴天
    JWBleWeatherCode_Rain,//雨
    JWBleWeatherCode_LightRain,//小雨
    JWBleWeatherCode_ModerateRain,//中雨
    JWBleWeatherCode_HeavyRain,//大雨
    JWBleWeatherCode_Storm,//暴雨
    JWBleWeatherCode_ShowerRain,//阵雨
    JWBleWeatherCode_HeavyShowerRain,//雷阵雨
    JWBleWeatherCode_FreezingRain,//冰雹
    JWBleWeatherCode_Snow,//雪
    JWBleWeatherCode_LightSnow,//小雪
    JWBleWeatherCode_ModerateSnow,//中雪
    JWBleWeatherCode_HeavySnow,//大雪
    JWBleWeatherCode_Sleet,//雨夹雪
    JWBleWeatherCode_Typhoon,//台风
    JWBleWeatherCode_Duststorm,//沙尘暴
    JWBleWeatherCode_SunnyAtNight,//夜间晴
    JWBleWeatherCode_CloudyAtNight,//夜间多云
    JWBleWeatherCode_Hot,//热
    JWBleWeatherCode_Cold,//冷
    JWBleWeatherCode_Breeze,//微风
    JWBleWeatherCode_Gale,//大风
    JWBleWeatherCode_Mist,//雾霭
    JWBleWeatherCode_CloudyToClear//多云转晴
};

@interface JWBleCurWeatherModel : NSObject

#warning mark 年月日需要与设备日期一致 The year, month, and day need to be consistent with the device date
@property(nonatomic, assign) int year;//2023
@property(nonatomic, assign) int month;
@property(nonatomic, assign) int day;

@property(nonatomic, strong) NSString *cityStr;//最长33个bytes   max 33bytes
@property(nonatomic, assign) JWBleWeatherCode weatherCode;
@property(nonatomic, assign) int temp;//当前温度 需>0，单位摄氏度  The current temperature needs to be >0, in degrees Celsius
@property(nonatomic, assign) int maxTemp;//最高温度，需>0，单位摄氏度 Maximum temperature, must be >0, unit is Celsius
@property(nonatomic, assign) int minTemp;//最低温度，需>0，单位摄氏度 Minimum temperature, must be >0, unit is Celsius
@property(nonatomic, assign) int humidity;//湿度，为0不显示  Humidity, if it is 0, it will not be displayed

/**
 ultraviolet light
  
    Gear position:
    0: invalid
    1: Weakest (0-2)
    2: Weak (3-4)
    3: Medium (5-6)
    4: Strong (7-9)
    5: Strong (>= 10)
 */
@property(nonatomic, assign) int uv;

@property(nonatomic, assign) int pm;//污染指数，为0不显示 Pollution index, if it is 0, it will not be displayed

@end

@interface JWBleFutureWeatherModel : NSObject

@property(nonatomic, assign) JWBleWeatherCode weatherCode;
@property(nonatomic, assign) int maxTemp;
@property(nonatomic, assign) int minTemp;

@end

@interface JWBleWeatherModel : NSObject

@property(nonatomic, assign) bool open;
@property(nonatomic, strong) JWBleCurWeatherModel *curWeatherModel;
@property(nonatomic, strong) NSArray<JWBleFutureWeatherModel *> *futureWeatherArr;// maxlength: 6, curWeatherModel can not be null

@end

