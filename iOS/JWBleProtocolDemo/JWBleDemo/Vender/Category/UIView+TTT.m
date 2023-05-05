//
//  UIView+TTT.m
//  TianTianTui
//
//  Created by 黄博 on 2017/3/7.
//  Copyright © 2017年 TianTianTui. All rights reserved.
//

#import "UIView+TTT.h"

@interface UIView ()

@end

@implementation UIView (TTT)

/**
 *  自动从xib创建视图
 */
+(instancetype)viewFromXIB{
    
    NSString *name=NSStringFromClass(self);
    
    UIView *xibView=[[[NSBundle mainBundle] loadNibNamed:name owner:nil options:nil] firstObject];
    
    if(xibView==nil){
        NSLog(@"CoreXibView：从xib创建视图失败，当前类是：%@",name);
    }
    
    return xibView;
}
@end
