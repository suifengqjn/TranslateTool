//
//  LineModel.m
//  TranslateTool
//
//  Created by qianjn on 2018/1/10.
//  Copyright © 2018年 SF. All rights reserved.
//

#import "LineModel.h"

@implementation LineModel

- (instancetype)initWithLine:(NSString *)line
{
    self = [super init];
    if (self) {
        [self dealLine:line];
    }
    return self;
}

- (void)dealLine:(NSString *)line
{
    if ([line rangeOfString:@"NSLocalizedString"].location != NSNotFound) {
        NSString *localStr = @"NSLocalizedString(@\"";
        if ([line rangeOfString:localStr].location != NSNotFound) {
            NSString *newStr =  [[line componentsSeparatedByString:localStr].lastObject description];
            newStr = [[newStr componentsSeparatedByString:@"\""].firstObject description];
            self.transValue = newStr;
            _type = lineString;
        } else if ([line rangeOfString:localStr].location == NSNotFound && [line rangeOfString:@"NSLocalizedString("].location != NSNotFound) {
            
            NSString *newStr =  [[line componentsSeparatedByString:@"NSLocalizedString("].lastObject description];
            newStr = [[newStr componentsSeparatedByString:@","].firstObject description];
            [newStr stringByReplacingOccurrencesOfString:@" " withString:@""];
            self.transValue = newStr;
            _type = lineVar;
        }
    } else {
        _type = lineDefault;
    }
}

@end
