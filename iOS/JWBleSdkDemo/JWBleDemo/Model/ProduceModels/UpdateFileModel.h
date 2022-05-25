//
//  UpdateFileModel.h
//  JWBleDemo
//
//  Created by huang bo on 2020/3/24.
//  Copyright © 2020 wosmart. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UpdateFileModel : NSObject

@property(nonatomic, strong) NSString *fileName;
@property(nonatomic, strong) NSString *name;
@property(nonatomic, assign) BOOL isFirmware;
@property(nonatomic, assign) NSInteger version1;
@property(nonatomic, assign) NSInteger version2;
@property(nonatomic, assign) NSInteger version3;
@property(nonatomic, assign) NSInteger version4;

+ (UpdateFileModel *)conversionModelWithFileName:(NSString *)fileName;

@end

