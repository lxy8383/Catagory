//
//  UIColor+CGColorWithString.h
//  CoGo
//
//  Created by liuxy on 2018/8/31.
//  Copyright © 2018年 彭文鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (CGColorWithString)

/**
 16进制
 
 @param hexColor 参数
 @return 颜色值
 */
+ (UIColor*)colorWithHexString:(NSString *)hexColor;

+ (UIColor*)colorWithHexString:(NSString *)hexColor  alpha:(CGFloat)alpha;

@end
