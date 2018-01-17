//
//  NSColor+Hex.m
//  PhotoBatch
//
//  Created by qianjn on 2017/11/29.
//  Copyright © 2017年 SF. All rights reserved.
//

#import "NSColor+Hex.h"

@implementation NSColor (Hex)
+(NSColor *)colorWithRGB:(NSUInteger)hex
                  alpha:(CGFloat)alpha
{
    float r, g, b, a;
    a = alpha;
    b = hex & 0x0000FF;
    hex = hex >> 8;
    g = hex & 0x0000FF;
    hex = hex >> 8;
    r = hex;
    
    if (r > 255) {
        r = 255;
    }
    
    return [NSColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a];
}

+ (NSColor *)colorWithHexString:(NSString *)hexString {
    return [NSColor colorWithHexString:hexString alpha:1.0];
}

+ (NSColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha {
    if ([hexString hasPrefix:@"0x"] || [hexString hasPrefix:@"0X"]) {
        hexString = [hexString substringFromIndex:2];
    } else if ([hexString hasPrefix:@"#"]) {
        hexString = [hexString substringFromIndex:1];
    }
    
    unsigned int value = 0;
    BOOL flag = [[NSScanner scannerWithString:hexString] scanHexInt:&value];
    if(NO == flag)
        return [NSColor clearColor];
    float r, g, b, a;
    a = alpha;
    b = value & 0x0000FF;
    value = value >> 8;
    g = value & 0x0000FF;
    value = value >> 8;
    r = value;
    
    return [NSColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a];
}
@end
