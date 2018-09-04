//
//  UIColor+CGColorWithString.m
//  CoGo
//
//  Created by liuxy on 2018/8/31.
//  Copyright © 2018年 彭文鑫. All rights reserved.
//

#import "UIColor+CGColorWithString.h"

@implementation UIColor (CGColorWithString)

+ (UIColor*)colorWithHexString:(NSString *)hexColor
{
   return  [self colorWithHexString:hexColor alpha:1];
}

+ (UIColor*)colorWithHexString:(NSString *)hexColor  alpha:(CGFloat)alpha
{
    if ([hexColor isEqualToString:@"red"]) {
        return [UIColor redColor];
    }
    else if ([hexColor isEqualToString:@"blue"]) {
        return [UIColor blueColor];
    }
    else if ([hexColor isEqualToString:@"black"]) {
        return [UIColor blackColor];
    }
    else if ([hexColor isEqualToString:@"gray"]) {
        return [UIColor grayColor];
    }
    else if ([hexColor isEqualToString:@"lightGray"]) {
        return [UIColor lightGrayColor];
    }
    else if ([hexColor isEqualToString:@"darkGray"]) {
        return [UIColor darkGrayColor];
    }
    else if ([hexColor isEqualToString:@"purple"]) {
        return [UIColor purpleColor];
    }
    else if ([hexColor isEqualToString:@"orange"]) {
        return [UIColor orangeColor];
    }
    else if ([hexColor isEqualToString:@"brown"]) {
        return [UIColor brownColor];
    }
    else if ([hexColor isEqualToString:@"yellow"]) {
        return [UIColor yellowColor];
    }
    else if ([hexColor isEqualToString:@"green"]) {
        return [UIColor greenColor];
    }
    else if ([hexColor isEqualToString:@"white"]) {
        return [UIColor whiteColor];
    }
    else if ([hexColor isEqualToString:@"cyan"]) {
        return [UIColor cyanColor];
    }
    else if ([hexColor isEqualToString:@"clearColor"]) {
        return [UIColor clearColor];
    }
    
    NSString *cString = [[hexColor stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])  cString = [cString substringFromIndex:1];
    
    if ([cString length] != 6) return [UIColor clearColor];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:alpha];

}
@end
