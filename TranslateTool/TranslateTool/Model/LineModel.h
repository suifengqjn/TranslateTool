//
//  LineModel.h
//  TranslateTool
//
//  Created by qianjn on 2018/1/10.
//  Copyright © 2018年 SF. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, linetype) {
    lineDefault = 0,
    lineString,  //包含国际化，里面是常量
    lineVar, //包含国际化，里面是变量，需要往上找实际的值
};

@interface LineModel : NSObject

@property(nonatomic, assign) linetype type;
@property(nonatomic, copy  ) NSString *transValue;

- (instancetype)initWithLine:(NSString *)line;

@end
