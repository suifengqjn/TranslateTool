//
//  FileModel.h
//  TranslateTool
//
//  Created by qianjn on 2018/1/10.
//  Copyright © 2018年 SF. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, filetype) {
    fileUnKnow = 0,
    fileH,
    fileM,
    fileL //翻译文件
};


@interface FileModel : NSObject

@property (nonatomic, assign) filetype type; // 文件类型
@property (nonatomic, strong) NSArray *lines; //根据行数分割
@property (nonatomic, strong) NSMutableArray *transWords;  //需要翻译的文案


@property (nonatomic, copy) NSString *countryName;  //哪国的翻译
@property (nonatomic, strong) NSDictionary *localWordsDic;// 工程中已经存在的翻译文案

- (instancetype)initWithFilePath:(NSString *)path;

@end
