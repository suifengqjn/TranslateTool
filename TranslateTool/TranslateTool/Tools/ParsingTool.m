//
//  ParsingTool.m
//  TranslateTool
//
//  Created by qianjn on 2018/1/10.
//  Copyright © 2018年 SF. All rights reserved.
//

#import "ParsingTool.h"

@implementation ParsingTool

+(instancetype)getInstance
{
    static ParsingTool *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
       
    });
    return _instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
         _queue = dispatch_queue_create("com.transtool.file",DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

+(NSArray *)createLines:(NSString *)content
{
    if (!content || content.length == 0) {
        return nil;
    }
    NSString *newCon = [self cleanannotate:content];
    NSArray *strArr = [newCon componentsSeparatedByCharactersInSet: [NSMutableCharacterSet newlineCharacterSet]];
    return strArr;
}

// 清理注释
+(NSString *)cleanannotate:(NSString *)content
{
    NSString *annotationBlockPattern = @"/\\*[\\s\\S]*?\\*/"; //匹配/*...*/这样的注释
    NSString *annotationLinePattern = @"//.*?\\n";//匹配//这样的注释
    NSString *annotationmarkPattern = @"^#pragma mark.*";//#pragma匹配这样的注释
    NSRegularExpression *regexBlock = [NSRegularExpression regularExpressionWithPattern:annotationBlockPattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSRegularExpression *regexLine = [NSRegularExpression regularExpressionWithPattern:annotationLinePattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSRegularExpression *regexmark = [NSRegularExpression regularExpressionWithPattern:annotationmarkPattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *newCon = [regexBlock stringByReplacingMatchesInString:content options:NSMatchingReportCompletion range:NSMakeRange(0, content.length) withTemplate:@" "];
    newCon = [regexLine stringByReplacingMatchesInString:newCon options:NSMatchingReportCompletion range:NSMakeRange(0, newCon.length) withTemplate:@" "];
    newCon = [regexmark stringByReplacingMatchesInString:newCon options:NSMatchingReportCompletion range:NSMakeRange(0, newCon.length) withTemplate:@" "];
    return newCon;

}






@end
