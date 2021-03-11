//
//  Utilitie.m
//  KokoDemo
//
//  Created by Alex Zhang on 2021/3/9.
//  Copyright © 2021 Alex Zhang. All rights reserved.
//

#import "Utilitie.h"

@implementation Utilitie


/// 字串轉日期
/// @param string DateString
+ (NSDate *)StringToDate:(NSString *)string {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    NSDate *date = [formatter dateFromString:string];
    return date;
}


/// 判斷是否為日期格式
/// @param string DateString
+ (BOOL)isDateFormatString:(NSString *)string {
    NSString *keyString = @"/";
    if (![string containsString:keyString] || [self countOccurencesOfString:keyString AllString:string] != 2) {
        return false;
    }
    return true;
}


/// 判斷關鍵字出現幾次
/// @param searchString 關鍵字
/// @param allString 要被收尋的字
+ (NSInteger)countOccurencesOfString:(NSString*)searchString AllString:(NSString *)allString {
    NSInteger strCount = [allString length] - [[allString stringByReplacingOccurrencesOfString:searchString withString:@""] length];
    return strCount / [searchString length];
}


/// 補齊日期字串 "/"
/// @param string DateString
+ (NSString *)ModifyStringFormat:(NSString *)string {
    NSMutableString *tempString = [[NSMutableString alloc]initWithString:string];
    [tempString insertString:@"/" atIndex:4];
    [tempString insertString:@"/" atIndex:7];
    return (NSString *)tempString;
}

+ (CGFloat)getScreenWidth {
    return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat)getScreenheight {
    return [UIScreen mainScreen].bounds.size.height;
}

+ (UIColor *)getKoKoMainColor {
    return [UIColor colorWithRed:236/255.0 green:0/255.0 blue:140/255.0 alpha:1.0];
}

@end
