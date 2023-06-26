//
//  WeatherViewController.m
//  JWBleDemo
//
//  Created by bobobo on 2023/6/21.
//  Copyright © 2023 wosmart. All rights reserved.
//

#import "WeatherViewController.h"

@interface WeatherViewController ()

@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Weather";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    JWBleWeatherModel *weatherModel = [JWBleWeatherModel new];
    weatherModel.open = true;
    
    //the day
    {
        JWBleCurWeatherModel *curWeatherModel = [JWBleCurWeatherModel new];
        curWeatherModel.year = 2023;
        curWeatherModel.month = 6;
        curWeatherModel.day = 6;
        
        curWeatherModel.cityStr = @"shenzhen";//Up to 33 bytes;
        curWeatherModel.weatherCode = JWBleWeatherCode_Sunny;
        curWeatherModel.maxTemp = 37;
        curWeatherModel.minTemp = 16;
        curWeatherModel.temp = 25;
        //Humidity, ultraviolet light, pm currently have no numerical limit range, all can be 0
        curWeatherModel.humidity = 23;
        curWeatherModel.uv = 23;
        curWeatherModel.pm = 0;
        weatherModel.curWeatherModel = curWeatherModel;
    }
    
    //Future weather, max6, can be empty
    NSMutableArray<JWBleFutureWeatherModel *> *futureWeatherArr = [NSMutableArray new];
    for (int i = 0; i < 6; i++) {
        JWBleFutureWeatherModel *futureModel = [JWBleFutureWeatherModel new];
        futureModel.weatherCode = JWBleWeatherCode_Sunny;
        futureModel.maxTemp = 37;
        futureModel.minTemp = 16;
        [futureWeatherArr addObject:futureModel];
    }
    
    weatherModel.futureWeatherArr = [futureWeatherArr mutableCopy];
    
    [JWBleAction jwWeatherAction:weatherModel callBack:^(JWBleCommunicationStatus status) {
                            
    }];
}


@end
