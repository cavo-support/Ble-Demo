//
//  ScanViewControllerTableViewCell.m
//  CoreBluetoothDemo
//
//  Created by Bo 黄 on 2019/2/13.
//  Copyright © 2019 Jone. All rights reserved.
//

#import "ScanViewControllerTableViewCell.h"

@interface ScanViewControllerTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLB;
@property (weak, nonatomic) IBOutlet UILabel *macLB;
@property (weak, nonatomic) IBOutlet UILabel *rssiLB;

@end

@implementation ScanViewControllerTableViewCell

- (void)setProtocolModel:(JWBleProtocolModel *)protocolModel {
    _protocolModel = protocolModel;
    
    self.nameLB.text = [NSString stringWithFormat:@"Name: %@",protocolModel.per.name];
    self.rssiLB.text = [NSString stringWithFormat:@"RSSI: %ld",protocolModel.per.RSSI.integerValue];
    self.macLB.text = [self convertToNSStringWithNSData:protocolModel.advertisementData];
}


- (NSString *)convertToNSStringWithNSData:(NSDictionary *)advertisementData {
    NSData *data = [advertisementData objectForKey:@"kCBAdvDataManufacturerData"];
    
    NSMutableString *strTemp = [NSMutableString stringWithCapacity:[data length]*2];
    
    const unsigned char *szBuffer = [data bytes];
    
    for (NSInteger i=0; i < [data length]; ++i) {
        [strTemp appendFormat:@"%02lx",(unsigned long)szBuffer[i]];
    }
    
    NSString *resultMac = @"";
    NSString *cutstomerMac = [strTemp stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (cutstomerMac.length > 4) {
        cutstomerMac = [cutstomerMac substringFromIndex:4];
        for (int i = 0; i < cutstomerMac.length; i++) {
            resultMac = [NSString stringWithFormat:@"%@%@",resultMac,[cutstomerMac substringWithRange:NSMakeRange(i, 1)]];
            if (i % 2 != 0 && i != cutstomerMac.length -1) {
                resultMac = [NSString stringWithFormat:@"%@:",resultMac];
            }
        }
    }
    
    return resultMac;
}


@end
