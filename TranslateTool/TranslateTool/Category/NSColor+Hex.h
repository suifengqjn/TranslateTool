//
//  NSColor+Hex.h
//  PhotoBatch
//
//  Created by qianjn on 2017/11/29.
//  Copyright © 2017年 SF. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSColor (Hex)
+ (NSColor *)colorWithRGB:(NSUInteger)hex alpha:(CGFloat)alpha;
+ (NSColor *)colorWithHexString:(NSString *)hexString;
+ (NSColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;
@end
