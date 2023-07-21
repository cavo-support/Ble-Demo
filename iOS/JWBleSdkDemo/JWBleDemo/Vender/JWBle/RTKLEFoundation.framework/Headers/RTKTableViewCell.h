//
//  RTKTableViewCell.h
//  RtkBand
//
//  Created by jerome_gu on 2018/3/16.
//  Copyright © 2018年 Realtek. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    RTKTableViewCellStyleDefault,   // icon - title - value - >
    RTKTableViewCellStyleSubtitle,  // icon - title - value - >
                                    //       subtitle
    
    RTKTableViewCellStyleWithoutValue, // icon - title
    
    RTKTableViewCellStyleSwitch,    // icon - title - switch
    RTKTableViewCellStyleSubtitleSwitch,    // icon - title - switch - >
                                            //       subtitle
    RTKTableViewCellStyleSwitchWithoutIcon, // title - switch
    
    RTKTableViewCellStyleValueDisclosable, // title - value - >
    RTKTableViewCellStyleValue, // title - value
    
    RTKTableViewCellStyleIconOnRight,  // title - icon - >
    
    RTKTableViewCellStyleTitleOnly  // title - [accessory view]
} RTKTableViewCellStyle;


@interface RTKTableViewCell : UITableViewCell

@property (nonatomic) RTKTableViewCellStyle style;

@property (nonatomic) NSString *titleText;
@property (nonatomic) NSString *subtitleText;
@property (nonatomic) NSString *valueText;
@property (nonatomic) UIImage *iconImage;
@property (nonatomic) BOOL isOn;
@property (nonatomic) UIImage *valueImage;

@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;

// Default YES
@property (nonatomic) BOOL showSeparator;
// Default NO
@property (nonatomic) BOOL showSectionTopSeparator;
// Default NO
@property (nonatomic) BOOL showSectionBottomSeparator;

@property (nonatomic, copy) void (^switchChangedHandler)(BOOL);

@end
