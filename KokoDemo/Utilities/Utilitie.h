//
//  Utilitie.h
//  KokoDemo
//
//  Created by Alex Zhang on 2021/3/9.
//  Copyright © 2021 Alex Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface Utilitie : NSObject
+ (NSDate *)StringToDate:(NSString *)string;

+ (BOOL)isDateFormatString:(NSString *)string;

+ (NSInteger)countOccurencesOfString:(NSString*)searchString AllString:(NSString *)allString;

+ (NSString *)ModifyStringFormat:(NSString *)string;

+ (CGFloat)getScreenWidth;
+ (CGFloat)getScreenheight;

+ (UIColor *)getKoKoMainColor;
+ (UIColor *)getKoKosoftPinkColor;
+ (UIColor *)getKokoBrownGreyColor;
@end

NS_ASSUME_NONNULL_END
