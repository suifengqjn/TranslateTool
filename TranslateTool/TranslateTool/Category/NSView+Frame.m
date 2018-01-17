//
//  NSView+Frame.m
//  PhotoBatch
//
//  Created by qianjn on 2017/12/12.
//  Copyright © 2017年 SF. All rights reserved.
//

#import "NSView+Frame.h"

@implementation NSView (Frame)
- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}


- (void)setLeft:(CGFloat)left top:(CGFloat)top
{
    CGRect frame = self.frame;
    frame.origin.x = left;
    frame.origin.y = top;
    self.frame = frame;
}

- (void)setLeft:(CGFloat)left bottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.x = left;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (void)setRight:(CGFloat)right top:(CGFloat)top
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    frame.origin.y = top;
    self.frame = frame;
}

- (void)setRight:(CGFloat)right bottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (void)removeAllSubviews {
    while (self.subviews.count) {
        NSView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}
@end
