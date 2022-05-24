//
//  UpdateFileModel.m
//  JWBleDemo
//
//  Created by huang bo on 2020/3/24.
//  Copyright © 2020 wosmart. All rights reserved.
//

#import "UpdateFileModel.h"

@implementation UpdateFileModel

+ (UpdateFileModel *)conversionModelWithFileName:(NSString *)fileName {
//    appMP_V100S_2.1.24.28_7fa3e261-4526ebe6ad3288faf2a8f5cd5971aed9.bin
//    userdata_V08Pro_0.0.0.28_7fa3e261-4526ebe6ad3288faf2a8f5cd5971aed9.bin
    if (fileName && ![fileName isEmpty]) {
        
        UpdateFileModel *fileModel;
        
        NSArray *arr = [fileName componentsSeparatedByString:@"_"];
        if (arr.count == 4) {
            fileModel = [UpdateFileModel new];
            
            fileModel.fileName = fileName;
            fileModel.isFirmware = [arr.firstObject isEqual:@"appMP"];
            fileModel.name = arr[1];
            
            NSArray *versionArr = [arr[2] componentsSeparatedByString:@"."];
            if (versionArr.count == 4) {
                fileModel.version1 = [versionArr[0] integerValue];
                fileModel.version2 = [versionArr[1] integerValue];
                fileModel.version3 = [versionArr[2] integerValue];
                fileModel.version4 = [versionArr[3] integerValue];
                
                return fileModel;
            }
        }
    }
    return nil;
}

@end
