//
//  NSView+Frame.h
//  PhotoBatch
//
//  Created by qianjn on 2017/12/12.
//  Copyright © 2017年 SF. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSView (Frame)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;
/**
 设左上角坐标
 */
- (void)setLeft:(CGFloat)left top:(CGFloat)top;

/**
 设左下角坐标
 */
- (void)setLeft:(CGFloat)left bottom:(CGFloat)bottom;

/**
 设右上角坐标
 */
- (void)setRight:(CGFloat)right top:(CGFloat)top;

/**
 设右下角坐标
 */
- (void)setRight:(CGFloat)right bottom:(CGFloat)bottom;

- (void)removeAllSubviews;

@end
