//
//  JWLogModel.h
//  JWBle
//
//  Created by huang bo on 2019/11/22.
//  Copyright © 2019 wosmart. All rights reserved.
//

#import "JWBleDBModel.h"

# define JWNSLog(...) [JWLogModel log:__VA_ARGS__]

@interface JWLogModel : JWBleDBModel

@property(nonatomic, assign) NSTimeInterval t;
@property(nonatomic, strong) NSString *str;

+ (NSArray *)getLog;

+ (void)log:(NSString *)formatStr, ...NS_FORMAT_FUNCTION(1,2);

@end

