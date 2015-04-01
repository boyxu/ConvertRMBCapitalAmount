//
//  XYJNumberConverter.m
//  HvmingI8
//
//  Created by 徐英杰 on 15/3/23.
//  Copyright (c) 2015年 Hvming Soft. All rights reserved.
//

#import "XYJNumberConverter.h"

@implementation XYJNumberConverter

+ (NSString *)chineseCapitalForNumber:(NSNumber *)number{
    NSDecimalNumber *decimalNumber = [[NSDecimalNumber alloc] initWithDouble:[number doubleValue]];
    NSDecimal decimal = [decimalNumber decimalValue];
    NSDecimal resultDecimal;
    NSDecimalRound(&resultDecimal, &decimal, 2, NSRoundPlain);
    NSDecimalNumber *resultNumber = [[NSDecimalNumber alloc] initWithDecimal:resultDecimal];
    
    NSString *tempString;
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_Hans_CN"]];
    numberFormatter.numberStyle = NSNumberFormatterSpellOutStyle;
    tempString = [numberFormatter stringFromNumber:resultNumber];
    
    //大写对照表
    NSDictionary *capitalUntils = @{@"〇": @"零",
                                    @"一": @"壹",
                                    @"二": @"贰",
                                    @"三": @"叁",
                                    @"四": @"肆",
                                    @"五": @"伍",
                                    @"六": @"陆",
                                    @"七": @"柒",
                                    @"八": @"捌",
                                    @"九": @"玖",
                                    @"十": @"拾",
                                    @"百": @"佰",
                                    @"千": @"仟",
                                    @"万": @"万",
                                    @"亿": @"亿",
                                    @"兆": @"兆",
                                    @"京": @"京",
                                    };
    
    NSMutableString *resultString = [NSMutableString string];
    for (int i = 0; i < [tempString length]; i++) {
        NSString *digital = [tempString substringWithRange:NSMakeRange(i, 1)];
        if ([digital isEqualToString:@"点"]) {
            [resultString appendString:@"元"];
        }else{
            NSString *capitalDigital = capitalUntils[digital];
            if (![self isNullString:capitalDigital]) {
                [resultString appendString:capitalDigital];
            }else{
                [resultString appendString:digital];
            }
        }
    }
    if (!([resultString rangeOfString:@"元"].length > 0)) {
        [resultString appendString:@"元"];
    }else{
        NSArray *tempArray = [resultString componentsSeparatedByString:@"元"];
        NSString *firstString = tempArray[0];
        NSString *secondString = tempArray[1];
        
        NSMutableString *tempString = [NSMutableString string];
        if (![self isNullString:firstString] && ![firstString isEqualToString:@"零"]) {
            [tempString appendFormat:@"%@元",firstString];
        }
        if (![self isNullString:secondString]) {
            if ([secondString length] == 1) {
                [tempString appendFormat:@"%@角",secondString];
            }else if ([secondString length] == 2){
                if ([[secondString substringToIndex:1] isEqualToString:@"零"]) {
                    [tempString appendFormat:@"%@分",[secondString substringFromIndex:1]];
                }else{
                    [tempString appendFormat:@"%@角",[secondString substringToIndex:1]];
                    [tempString appendFormat:@"%@分",[secondString substringFromIndex:1]];
                }
            }
        }
        resultString = tempString;
    }
    return resultString;
    
}

+ (BOOL)isNullString:(NSString *)string{
    BOOL isNull = [string isKindOfClass:[NSString class]] && ([string length] > 0);
    return !isNull;
}

@end

