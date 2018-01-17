//
//  CountryModel.h
//  TranslateTool
//
//  Created by qianjn on 2018/1/16.
//  Copyright © 2018年 SF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CountryModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSDictionary *transValue;

@end
