//
//  JWOxygenModel.h
//  JWBle
//
//  Created by Bo 黄 on 2021/1/19.
//  Copyright © 2021 wosmart. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JWOxygenModel : NSObject

@property(nonatomic, assign) int mCurValue; //当前血氧值 Current blood oxygen value
@property(nonatomic, assign) int mHighValue; //最高血氧值 Maximum blood oxygen value
@property(nonatomic, assign) int mLowValue; //最低血氧值 Minimum blood oxygen value

@property(nonatomic, assign) NSInteger time; //时间戳 timestamp


@end
