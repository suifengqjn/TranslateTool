//
//  NSArray+beyond.m
//  test
//
//  Created by qianjn on 2016/12/23.
//  Copyright © 2016年 SF. All rights reserved.
//

#import "NSArray+beyond.h"

@implementation NSArray (beyond)
-(id)objectAtIndexCheck:(NSUInteger)index
{
    if (index < self.count) {
        return [self objectAtIndex:index];
    }
    return nil;
}
@end
