//
//  FileModel.m
//  TranslateTool
//
//  Created by qianjn on 2018/1/10.
//  Copyright © 2018年 SF. All rights reserved.
//

#import "FileModel.h"
#import "ParsingTool.h"
#import "LineModel.h"

@interface FileModel()


@end

@implementation FileModel


- (instancetype)initWithFilePath:(NSString *)path
{
    self = [super init];
    if (self) {
        
        _transWords = [NSMutableArray new];
        [self dealFile:path];

    }
    return self;
}

-(void)dealFile:(NSString *)filepath
{
    
    NSString *filename = [filepath componentsSeparatedByString:@"/"].lastObject;
    if ([filepath rangeOfString:@"/Pods/"].location != NSNotFound || [filepath rangeOfString:@"/DerivedData/"].location != NSNotFound || [filepath rangeOfString:@"/Business/"].location != NSNotFound) {
        _type = fileUnKnow;
    }else if ([[filename componentsSeparatedByString:@"."].lastObject isEqualToString:@"h"]) {
        _type = fileH;
    } else if ([[filename componentsSeparatedByString:@"."].lastObject isEqualToString:@"m"]) {
        _type = fileM;
    } else if ([filename isEqualToString:@"Localizable.strings"]) {
        _type = fileL;
    } else {
        _type = fileUnKnow;
    }
    
    if (_type == fileM) {
        NSString *content = [NSString stringWithContentsOfFile:filepath encoding:NSUTF8StringEncoding error:nil];
        
        self.lines = [ParsingTool createLines:content];
        
        //NSLocalizedString(title,nil) 有些国际化文案是变量，使用递归从当前行往上查找
        if (self.lines.count > 0) {
            for (NSString *line in self.lines) {
                LineModel *lm  = [[LineModel alloc] initWithLine:line];
                
                if (lm.type == lineString) {
                    [_transWords addObject:lm.transValue];
                } else if (lm.type == lineVar) {
                    NSString *word = [self upFindLocaltring:[self.lines indexOfObject:line] - 1 localVar:lm.transValue];
                    if (word) {
                        [_transWords addObject:word];
                    }
                }
            }
        }
    } else if (_type == fileL) {
        
        self.localWordsDic = [[NSDictionary alloc] initWithContentsOfFile:filepath];
        
        NSString *countryname = [[filepath componentsSeparatedByString:@"/Localizable.strings"].firstObject description];
        countryname = [[countryname componentsSeparatedByString:@"/"].lastObject description];
        countryname = [[countryname componentsSeparatedByString:@"."].firstObject description];
        
        self.countryName = countryname;
         
    }
   

}

- (NSString *)upFindLocaltring:(NSInteger)index localVar:(NSString *)var
{
    if (index > self.lines.count - 1) {
        return nil;
    }
    if (index == 0) {
        return nil;
    } else if ([[self.lines objectAtIndex:index] rangeOfString:var].location != NSNotFound && [[self.lines objectAtIndex:index] rangeOfString:@"="].location != NSNotFound) {
        //这里分两种情况
        //1. 使用 stringWithFormat
        NSString *varValue = nil;
        if ([[self.lines objectAtIndex:index] rangeOfString:@"stringWithFormat:@\""].location != NSNotFound) {
            varValue = [[[self.lines objectAtIndex:index] componentsSeparatedByString:@"stringWithFormat:@\""].lastObject description];
            varValue = [[varValue componentsSeparatedByString:@"\""].firstObject description];
        } else if ([[self.lines objectAtIndex:index] rangeOfString:@"@\""].location != NSNotFound){
            varValue = [[[self.lines objectAtIndex:index] componentsSeparatedByString:@"@\""].lastObject description];
            varValue = [[varValue componentsSeparatedByString:@"\""].firstObject description];
        }
        if (varValue.length > 0) {
            return varValue;
        }
        return nil;
        
    } else {
        return [self upFindLocaltring:index-1 localVar:var];
    }
}


@end
