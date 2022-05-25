//
//  NSString+TTT.m
//  TianTianTui
//
//  Created by 黄博 on 2017/2/28.
//  Copyright © 2017年 TianTianTui. All rights reserved.
//

#import "NSString+TTT.h"

@implementation NSString (TTT)

- (BOOL)isEmpty {
    if(!self||[self isKindOfClass:[NSNull class]]||self.length==0) {
        return YES;
    }
    return NO;
}


- (NSDictionary *)getURLParameters {
    NSRange range = [self rangeOfString:@"?"];
    if (range.location == NSNotFound) {
        return nil;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *parametersString = [self substringFromIndex:range.location + 1];
    if ([parametersString containsString:@"&"]) {
        NSArray *urlComponents = [parametersString componentsSeparatedByString:@"&"];
        for (NSString *keyValuePair in urlComponents) {
            NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
            NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
            NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
            if (key == nil || value == nil) {
                continue;
            }
            id existValue = [params valueForKey:key];
            if (existValue != nil) {
                if ([existValue isKindOfClass:[NSArray class]]) {
                    NSMutableArray *items = [NSMutableArray arrayWithArray:existValue];
                    [items addObject:value];
                    [params setValue:items forKey:key];
                } else {
                    [params setValue:@[existValue, value] forKey:key];
                }
            } else {
                [params setValue:value forKey:key];
            }
        }
    } else {
        NSArray *pairComponents = [parametersString componentsSeparatedByString:@"="];
        if (pairComponents.count == 1) {
            return nil;
        }
        NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
        NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
        if (key == nil || value == nil) {
            return nil;
        }
        [params setValue:value forKey:key];
    }
    return params;
}

- (void)enumerateMatchesNumberStringUsingBlock:(void (^)(NSString *, NSRange))block {
    NSString *pattern = @"[0-9.]";
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    [regex enumerateMatchesInString:self
                            options:NSMatchingReportCompletion
                              range:NSMakeRange(0, self.length)
                         usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
                             if (result.range.length > 0) {
                                 if (block) {
                                     block([self substringWithRange:result.range], result.range);
                                 }
                             }
                         }];
}

- (void)enumerateMatchesString:(NSString *)mathStr usingBlock:(void (^)(NSString *, NSRange))block {
    NSString *pattern = mathStr;
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    [regex enumerateMatchesInString:self
                            options:NSMatchingReportCompletion
                              range:NSMakeRange(0, self.length)
                         usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
                             if (result.range.length > 0) {
                                 if (block) {
                                     block([self substringWithRange:result.range], result.range);
                                 }
                             }
                         }];
}

- (NSString *)replaceUnicode {
    if (self != nil) {
        NSString *tempStr1 = [self stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
        NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
        NSString *tempStr3 = [[@"\""stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
        NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
        NSString *returnStr = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:NULL error:NULL];
        return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
    }
    return @"";
}

- (id)jsonStringToObject {
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
}

+ (NSString *)formatFloat:(float)f {
    if (fmodf(f, 1)==0) {//如果有一位小数点
        return [NSString stringWithFormat:@"%.0f",f];
    } else if (fmodf(f*10, 1)==0) {//如果有两位小数点
        return [NSString stringWithFormat:@"%.1f",f];
    } else {
        return [NSString stringWithFormat:@"%.2f",f];
    }
}

- (NSString *)accountEncryption {
    NSMutableString *phoneStr = [NSMutableString stringWithString:self];
    if (phoneStr.length > 4) {
        NSInteger location = floorf(phoneStr.length / 2.0 - 2);
        [phoneStr replaceCharactersInRange:NSMakeRange(location, 4) withString:@"****"];
    }
    return phoneStr;
}

- (CGSize)getSpaceLabelSizeWithWidh:(CGFloat)width font:(UIFont *)font {
    NSMutableParagraphStyle *paragphStyle=[[NSMutableParagraphStyle alloc]init];
    
    paragphStyle.lineSpacing=8;//设置行距为0
    paragphStyle.firstLineHeadIndent=0.0;
    paragphStyle.hyphenationFactor=0.0;
    paragphStyle.paragraphSpacingBefore=0.0;
    
    NSDictionary *dic=@{
                        
                        NSFontAttributeName:font, NSParagraphStyleAttributeName:paragphStyle, NSKernAttributeName:@1.0f
                        
                        };
    CGSize size=[self boundingRectWithSize:CGSizeMake(width, INTMAX_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    return size;
}

/**
 *  正则表达式验证手机号
 *
 *
 *  @return 是否是手机号
 */
- (BOOL)validateMobile {
    // 130-139  150-153,155-159  180-189  145,147  170,171,173,176,177,178
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0-9])|(14[57])|(17[013678]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}

//身份证号
- (BOOL)checkIsIdentityCard {
    //判断是否为空
    if (self==nil||self.length <= 0) {
        return NO;
    }
    //判断是否是18位，末尾是否是x
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    if(![identityCardPredicate evaluateWithObject:self]){
        return NO;
    }
    //判断生日是否合法
    NSRange range = NSMakeRange(6,8);
    NSString *datestr = [self substringWithRange:range];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setCalendar:[NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian]];
    [formatter setDateFormat : @"yyyyMMdd"];
    if([formatter dateFromString:datestr]==nil){
        return NO;
    }
    
    //判断校验位
    if(self.length==18) {
        NSArray *idCardWi= @[ @"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2" ]; //将前17位加权因子保存在数组里
        NSArray * idCardY=@[ @"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2" ]; //这是除以11后，可能产生的11位余数、验证码，也保存成数组
        int idCardWiSum=0; //用来保存前17位各自乖以加权因子后的总和
        for(int i=0;i<17;i++){
            idCardWiSum+=[[self substringWithRange:NSMakeRange(i,1)] intValue]*[idCardWi[i] intValue];
        }
        
        int idCardMod=idCardWiSum%11;//计算出校验码所在数组的位置
        NSString *idCardLast=[self substringWithRange:NSMakeRange(17,1)];//得到最后一位身份证号码
        
        //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
        if(idCardMod==2){
            if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]){
                return YES;
            }else{
                return NO;
            }
        }else{
            //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
            if([idCardLast intValue]==[idCardY[idCardMod] intValue]){
                return YES;
            }else{
                return NO;
            }
        }
    }
    return NO;
}

/**
 *  时间戳转成字符串
 *
 *  @param timestamp 时间戳
 *
 *  @return 格式化后的字符串
 */
+ (NSString *)timeFromTimestamp:(NSInteger)timestamp{
    
    NSDateFormatter *dateFormtter =[[NSDateFormatter alloc] init];
    [dateFormtter setCalendar:[NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian]];
    NSDate *d = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSTimeInterval late=[d timeIntervalSince1970]*1;    //转记录的时间戳
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;   //获取当前时间戳
    NSString *timeString=@"";
    NSTimeInterval cha=now-late;
    // 发表在一小时之内
    if (cha/3600<1) {
        if (cha/60<1) {
            timeString = @"1";
        }
        else
        {
            timeString = [NSString stringWithFormat:@"%f", cha/60];
            timeString = [timeString substringToIndex:timeString.length-7];
        }
        
        timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
    }
    // 在一小时以上24小以内
    else if (cha/3600>1&&cha/86400<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@小时前", timeString];
    }
    // 发表在24以上10天以内
    else if (cha/86400>1&&cha/86400*3<1)     //86400 = 60(分)*60(秒)*24(小时)   3天内
    {
        timeString = [NSString stringWithFormat:@"%f", cha/86400];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@天前", timeString];
    }
    // 发表时间大于10天
    else
    {
        [dateFormtter setDateFormat:@"yyyy-MM-dd"];
        timeString = [dateFormtter stringFromDate:d];
    }
    
    return timeString;
}
/**
 *  根据格式将时间戳转换成时间
 *
 *  @param timestamp    时间戳
 *  @param formtter 日期格式
 *
 *  @return 带格式的日期
 */
+ (NSString *)timeFromTimestamp:(NSInteger)timestamp formtter:(NSString *)formtter{
    NSDateFormatter *dataFormtter =[[NSDateFormatter alloc] init];
    [dataFormtter setDateFormat:formtter];
    [dataFormtter setCalendar:[NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian]];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSString *time = [dataFormtter stringFromDate:date];
    return time;
}

/**
 *  获取当前时间戳
 */
+ (NSString *)timeIntervalGetFromNow {
    
    // 获取时间（非本地时区，需转换）
    NSDate * today = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:today];
    // 转换成当地时间
    NSDate *localeDate = [today dateByAddingTimeInterval:interval];
    // 时间转换成时间戳
    NSString *timeSp = [NSString stringWithFormat:@"%ld",(long)[localeDate timeIntervalSince1970]];
    
    return timeSp;
}

+ (NSString *)curDateStr {
    return [NSString timeFromTimestamp:[NSDate date].timeIntervalSince1970 formtter:@"yyyy-MM-dd"];
}

+ (NSString*)weekDayStr {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *now;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    now=[NSDate date];
    comps = [calendar components:unitFlags fromDate:now];
    int week = [comps weekday];
    
    NSString *weekDayStr = @"";
    switch (week) {
        case 1:
            weekDayStr = NSLocalizedString(@"周日", nil);
            break;
        case 2:
            weekDayStr = NSLocalizedString(@"周一", nil);
            break;
        case 3:
            weekDayStr = NSLocalizedString(@"周二", nil);
            break;
        case 4:
            weekDayStr = NSLocalizedString(@"周三", nil);
            break;
        case 5:
            weekDayStr = NSLocalizedString(@"周四", nil);
            break;
        case 6:
            weekDayStr = NSLocalizedString(@"周五", nil);
            break;
        case 7:
            weekDayStr = NSLocalizedString(@"周六", nil);
            break;
        default:
            weekDayStr = @"";
            break;
    }
    return weekDayStr;
}

+ (NSString *)curHoursStr {
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setCalendar:[NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian]];
    [dateFormatter setDateFormat:@"HH"];
    return [dateFormatter stringFromDate:date];
}

+ (NSString *)curMinuteStr {
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setCalendar:[NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian]];
    [dateFormatter setDateFormat:@"mm"];
    return [dateFormatter stringFromDate:date];
}

//传入 秒  得到 xx:xx:xx
+ (NSString *)getMMSSFromSS:(NSInteger)seconds {
    //format of hour
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",seconds/3600];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds%3600)/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
    //format of time
    NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    
    return format_time;
}

//传入 秒  得到 xx:xx:xx
+ (NSString *)getDDMMSSFromSS:(NSInteger)seconds {
    //format of day
    NSString *str_day = [NSString stringWithFormat:@"%ld",seconds/86400];
    
    NSInteger hourSeconds = seconds;
    //format of hour
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",hourSeconds/3600];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(hourSeconds%3600)/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",hourSeconds%60];
    //format of time
    NSString *format_time;
//    if (seconds/86400.0 > 1) {
//        format_time = [NSString stringWithFormat:@"%@%@ %@:%@:%@",str_day,NSLocalizedString(@"天", nil),str_hour,str_minute,str_second];
//    } else {
        format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
//    }
    
    return format_time;
}

///获取系统当前语言
+ (NSString*) getPreferredLanguage {
    NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
    NSArray* languages = [defs objectForKey:@"AppleLanguages"];
    NSString* preferredLang = [languages objectAtIndex:0];
    return preferredLang;
}

+ (NSString *)notRounding:(float)price afterPoint:(int)position {
    NSDecimalNumberHandler *roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:price];
    NSDecimalNumber *roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    
    float aa = [NSString stringWithFormat:@"%@",roundedOunces].floatValue;//如果值为8.0xx 会直接变成8 所以还是转一下
    return [NSString stringWithFormat:@"%.1f",aa];
}


+ (NSString *)converstionMilliSecondStr:(NSInteger)milliSecond {
    NSInteger singleMinute = (60 * 1000);
    NSInteger singleSecond = 1000;
    
    NSInteger minute = milliSecond / singleMinute;
    NSInteger second = (milliSecond - minute * singleMinute) / singleSecond;
    NSInteger millisecond = milliSecond - (minute * singleMinute) - (second * singleSecond);
    
    return [NSString stringWithFormat:@"%02ld′%02ld″%02ld",(long)minute, (long)second, (long)millisecond/10];
}

+ (NSString *)converstionMinuteSecondMilliSecondStr:(NSInteger)milliSecond {
    NSInteger singleMinute = (60 * 1000);
    NSInteger singleSecond = 1000;
    
    NSInteger minute = milliSecond / singleMinute;
    NSInteger second = (milliSecond - minute * singleMinute) / singleSecond;
    
    return [NSString stringWithFormat:@"%02ld′%02ld″",(long)minute, (long)second];
}


- (int)convertToInt {
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    
    NSData* da = [self dataUsingEncoding:enc];
    
    NSUInteger lengthTest = [da length];
    
    return (int)lengthTest;
}

- (CGFloat)converstionFloatValue {
    
    NSArray *aa = [self componentsSeparatedByString:@"."];
    
    CGFloat floatValue = 0;
    if (aa.count > 0) {
        floatValue += [aa.firstObject integerValue];
    }
    if (aa.count > 1) {
        NSString *floatStr = aa.lastObject;
        
        double floatCount = 1;
        for (int i = 0; i < floatStr.length; i++) {
            floatCount = floatCount * 10.0;
        }
        floatValue += [floatStr integerValue] / floatCount;
    }
    
    return floatValue;
}

- (BOOL)isSomeLengthNumberString:(NSInteger)count {
    if (self.length == count) {
        return [self stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    }
    return false;
}

@end
