//
//  NSString+TTT.h
//  TianTianTui
//
//  Created by 黄博 on 2017/2/28.
//  Copyright © 2017年 TianTianTui. All rights reserved.
//

#import <Foundation/Foundation.h>

static inline NSString *appendPath(NSString *host, NSString *path) {
    return [host stringByAppendingPathComponent:path];
}

//static inline NSString *priceText(CGFloat price) {
//    NSString *str;
//    if (fmodf(price, 1)==0) {//如果有一位小数点
//        str = [NSString stringWithFormat:@"%.0f",price];
//    } else if (fmodf(price*10, 1)==0) {//如果有两位小数点
//        str = [NSString stringWithFormat:@"%.1f",price];
//    } else {
//        str = [NSString stringWithFormat:@"%.2f",price];
//    }
//
//    return [NSString stringWithFormat:@"¥%@",str];
//}

@interface NSString (TTT)

- (BOOL)isEmpty;

/**
 *  截取URL中的参数
 *
 *  @return NSMutableDictionary parameters
 */
- (NSDictionary *)getURLParameters;

/**
 自定义首字母大写

 @return return value description
 */
- (NSString *)customCapitalizedString;

/**
 *  匹配字符
 *
 */
- (void)enumerateMatchesNumberStringUsingBlock:(void (^)(NSString *, NSRange))block;

/**
 *  匹配某个字符串
 *
 */
- (void)enumerateMatchesString:(NSString *)mathStr usingBlock:(void (^)(NSString *, NSRange))block;

/**
 *  替换\\n
 *
 */
- (NSString *)replaceUnicode;

/**
 *  json字符串转换
 *
 */
- (id)jsonStringToObject;

/**
 格式化价格，如果有小数点则显示

 @param f 浮点型数字
 @return return value description
 */
+ (NSString *)formatFloat:(float)f;

/**
 *  加密（验证码参数）
 *
 */
- (NSString *)strEncryption;

/**
 *  加密（账号部分打*）
 *
 */
- (NSString *)accountEncryption;

//- (CGSize)getSpaceLabelSizeWithWidh:(CGFloat)width font:(UIFont *)font;

/**
 *  正则表达式验证手机号
 *
 *
 *  @return 是否是手机号
 */
- (BOOL)validateMobile;

//身份证号
- (BOOL)checkIsIdentityCard;

/**
 *  时间戳转成字符串
 *
 *  @param timestamp 时间戳
 *
 *  @return 格式化后的字符串
 */
+ (NSString *)timeFromTimestamp:(NSInteger)timestamp;

/**
 *  根据格式将时间戳转换成时间
 *
 *  @param timestamp    时间戳
 *  @param formtter 日期格式
 *
 *  @return 带格式的日期
 */
+ (NSString *)timeFromTimestamp:(NSInteger)timestamp formtter:(NSString *)formtter;

/**
 *  获取当前时间戳
 */
+ (NSString *)timeIntervalGetFromNow;

/**
 获取当前yyyy-MM-dd字符串

 @return return value description
 */
+ (NSString *)curDateStr;

/**
 获取今天星期几

 @return 星期几字符串
 */
+ (NSString*)weekDayStr;

/**
 当前小时的 字符

 @return 当前小时的 字符
 */
+ (NSString *)curHoursStr;

/**
 当前分钟的 字符

 @return 当前分钟的 字符
 */
+ (NSString *)curMinuteStr;

/**
 传入 秒  得到 xx:xx:xx

 @param seconds 秒数
 @return  xx:xx:xx
 */
+ (NSString *)getMMSSFromSS:(NSInteger)seconds;

/**
 传入 秒  得到 xx天 xx:xx:xx
 
 @param seconds 秒数
 @return  xx:xx:xx 如果有大于一天 xx天 xx:xx:xx
 */
+ (NSString *)getDDMMSSFromSS:(NSInteger)seconds;

///获取系统当前语言
//+ (NSString*)getPreferredLanguage;

/**
 folat转string，去除四舍五入

 @param price float
 @param position 第几位
 @return string
 */
+ (NSString *)notRounding:(float)price afterPoint:(int)position;

/**
 正则改变 字符串的字体

 @param textStr textStr
 @param fontSize 大小
 @return 改变后的
 */
//+ (NSMutableAttributedString *)regularNumberStr:(NSString *)textStr fontSize:(CGFloat)fontSize;

/**
 转换毫秒为字符串 xx'xx''xx

 @param second 毫秒数
 @return 字符串
 */
+ (NSString *)converstionMilliSecondStr:(NSInteger)second;

/**
 转换毫秒为字符串 xx'xx''
 
 @param second 毫秒数
 @return 字符串
 */
+ (NSString *)converstionMinuteSecondMilliSecondStr:(NSInteger)second;

/**
 转换公英制 字符串
 
 公里 -> 英里
 kg  -> 磅
 ℃   -> ℉

 @param metricStr 公制 字符串
 @return return value description
 */
+ (NSString *)converstionMetricInchStr:(NSString *)metricStr;

/**
 判断中英字符的长度

 @param strtemp strtemp description
 @return return value description
 */
- (int)convertToInt;

/**
 通过截取转换为float

 @return float
 */
//- (CGFloat)converstionFloatValue;

/**
 自动根据系统时间 12进制 或者24进制 进行显示时间

 @param hour 小时
 @param minute 分钟
 @return return value description
 */
+ (NSString *)autoSystemHourType:(NSInteger)hour minute:(NSInteger)minute;

/**
 是否是多个位数的 纯数字 字符

 @param count 多少位数
 @return return value description
 */
- (BOOL)isSomeLengthNumberString:(NSInteger)count;

@end
