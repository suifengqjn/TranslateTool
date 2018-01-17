//
//  ParsingTool.h
//  TranslateTool
//
//  Created by qianjn on 2018/1/10.
//  Copyright © 2018年 SF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParsingTool : NSObject


@property(strong, atomic, readonly)dispatch_queue_t queue;

+(instancetype)getInstance;

//将文件拆分成行
+(NSArray *)createLines:(NSString *)content;


@end
