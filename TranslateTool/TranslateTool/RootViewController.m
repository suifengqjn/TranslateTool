//
//  RootViewController.m
//  TranslateTool
//
//  Created by qianjn on 2018/1/9.
//  Copyright © 2018年 SF. All rights reserved.
//

#import "RootViewController.h"
#import "PBDragView.h"
#import "XCFileManager.h"
#import "FileModel.h"
#import "ParsingTool.h"
#import "CountryModel.h"
@interface RootViewController ()<PBDragViewDelegate>
@property (weak) IBOutlet PBDragView *dragView;
@property (weak) IBOutlet NSTextField *projectPath;
@property (weak) IBOutlet NSTextField *outPath;
@property (weak) IBOutlet NSTextField *mfileCount;
@property (weak) IBOutlet NSTextField *countryCount;
@property (weak) IBOutlet NSTextField *currentFile;
@property (weak) IBOutlet NSProgressIndicator *indicator;
@property (weak) IBOutlet NSButton *startBtn;

@property (weak) IBOutlet NSTextField *excludeLists;

@property(nonatomic, copy ) NSString *temprojectPath;
@property(nonatomic, copy ) NSString *tempexcludeLists;

@property (nonatomic, strong) NSMutableArray *allFilePath;
@property (nonatomic, strong) NSMutableArray *mfiles;
@property (nonatomic, strong) NSMutableSet *transWords;


@property(nonatomic, strong)NSMutableArray *compareArr;


@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view.window setMinSize:NSMakeSize(800, 600)];
    [self.view.window setMaxSize:NSMakeSize(800, 600)];
    
    self.dragView.delegate = self;

    self.indicator.hidden = YES;
    
    self.mfiles = [NSMutableArray new];
    self.transWords = [NSMutableSet new];
    self.compareArr = [NSMutableArray new];
    
}

- (IBAction)startAction:(id)sender {
    
    self.startBtn.enabled = NO;
    [self clearshow];
    [self checkProjectFile];
}

- (void)clearshow
{
    [self.mfiles removeAllObjects];
    [self.transWords removeAllObjects];
    [self.compareArr removeAllObjects];
    self.temprojectPath = self.projectPath.stringValue;
    self.tempexcludeLists = self.excludeLists.stringValue;
    
    self.outPath.stringValue = @"";
    self.mfileCount.stringValue = @"";
    self.countryCount.stringValue = @"";
    
}

//检索工程所有文件
- (void)checkProjectFile
{
    
     [self startAnimation];
    __weak __typeof(self)weakSelf = self;
    
    //目录是文件
    if ([XCFileManager isFileAtPath:self.projectPath.stringValue]) {
        [self dealFileWithpath:self.projectPath.stringValue];
        weakSelf.mfileCount.stringValue = [NSString stringWithFormat:@" 1 个"];
        weakSelf.countryCount.stringValue = [NSString stringWithFormat:@" %ld 个", self.transWords.count];
        [self stopAnimation];
    } else {  //目录是文件夹
        
        NSArray *allFiles = [XCFileManager listFilesInDirectoryAtPath:self.projectPath.stringValue deep:YES];
        
        dispatch_async([ParsingTool getInstance].queue, ^{
        
            for (NSString *filepath in allFiles) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakSelf.currentFile.stringValue = [filepath description];
                });
                //取到的路径是相对路径，需要转换成绝对路径
                [self dealFileWithpath:[NSString stringWithFormat:@"%@/%@", self.temprojectPath, filepath]];
            }
            
            
            [weakSelf compare];

            
            dispatch_async([ParsingTool getInstance].queue, ^{
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakSelf.mfileCount.stringValue = [NSString stringWithFormat:@" %ld 个", self.mfiles.count];
                    weakSelf.countryCount.stringValue = [NSString stringWithFormat:@" %ld 个", self.transWords.count];
                    [weakSelf stopAnimation];
                });
            });
        });
    }
    
    
    
    
    
    
    
    
    
}

-(FileModel *)dealFileWithpath:(NSString *)filepath
{
    FileModel *file = [[FileModel alloc] initWithFilePath:filepath];
    if (file.type == fileM) {
        [self.mfiles addObject:file];
        [self.transWords addObjectsFromArray:file.transWords];
    } else if (file.type == fileL) {
        if (file.countryName && file.localWordsDic) {
            CountryModel *model = [[CountryModel alloc] init];
            model.name = file.countryName;
            model.transValue = file.localWordsDic;
            [self.compareArr addObject:model];
        }
    }
    return file;
}


- (void)startAnimation
{
    [self.indicator setHidden:NO];
    [self.indicator startAnimation:nil];
}

- (void)stopAnimation
{
    [self.indicator setHidden:YES];
    [self.indicator stopAnimation:nil];
}
#pragma mark - PBDragViewDelegate
- (void)dragFileComplete:(NSArray *)filepaths
{
    NSLog(@"%@", filepaths);
    if (filepaths.count > 0) {
       self.projectPath.stringValue = [filepaths.firstObject description];
    }
    NSMutableArray *arr = [NSMutableArray new];
    // 对文件夹路径进行处理
    for (NSString *path in filepaths) {
        if ([[path description] hasPrefix:@"file:///"]) {
            NSString *newpath = [[path description] substringFromIndex:7];
            if ([newpath hasSuffix:@"/"]) {
                newpath  = [newpath substringToIndex:newpath.length - 1];
            }
            [arr addObject:newpath];
            
        } else {
            if ([[path description] hasSuffix:@"/"]) {
                NSString *tempStr = [path description];
                [arr addObject:[tempStr substringToIndex:tempStr.length - 1]];
            } else {
                [arr addObject:[path description]];
            }
            
        }
    }
    self.allFilePath = arr;
    
}

/**
 将数据源拼成字符串，每组（行）数据用\n隔开，每组数据中每个数据之间用\t隔开，然后采用utf16的编码格式生成NSData类型的数据，存储为.xls后缀的文件。

 姓名\t 年龄 \t身高\t体重\n
 xxx1\t 19 \t 180\t56 \n
 xxx2\t 20 \t 175\t78 \n
 */
#pragma mark - 翻译比较
- (void)compare
{
    
    
    NSArray *exLists = [[self.tempexcludeLists stringByReplacingOccurrencesOfString:@" " withString:@""] componentsSeparatedByString:@","];
    NSMutableArray *compare = [self.compareArr mutableCopy];
    for (CountryModel *model in self.compareArr) {
        if ([exLists containsObject:model.name]) {
            [compare removeObject:model];
        }
    }
    
    self.compareArr = compare;
     __weak __typeof(self)weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        if(weakSelf.compareArr.count == 0) {
            weakSelf.startBtn.enabled = YES;
            return;
        }
    });
    

   
    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.indicator.hidden = YES;
        weakSelf.outPath.stringValue = @"数据处理中...请勿重复点击开始按钮";
    });
    NSMutableArray *result = [NSMutableArray array];
    //写入标题
    [result addObject:@"原始文案"];
    for (int j = 0; j < self.compareArr.count; j++) {
        CountryModel *model = self.compareArr[j];
        [result addObject:model.name];
    }
    // 写入文案
    NSMutableArray *row = [NSMutableArray arrayWithCapacity:self.compareArr.count +1];
    NSArray *allwords = [self.transWords allObjects];
    for (int i = 0; i < allwords.count ; i++) {
        NSString *currentWord = allwords[i];
        [row removeAllObjects];
        [row addObject:currentWord];
        BOOL trans = YES;
        for (int j = 0; j < self.compareArr.count; j++) {
            CountryModel *model = self.compareArr[j];
            if ([model.transValue valueForKey:currentWord]) {
                [row addObject:[model.transValue valueForKey:currentWord]];
            } else {
                trans = NO;
                [row addObject:@""];
            }
        }
        if (trans == NO) {
            [result addObjectsFromArray:row];
        }
    }
    
    NSMutableString *resultStr = [NSMutableString new];
    for (int i = 0; i < result.count; i++) {
        
        if ((i+1)%(self.compareArr.count +1) == 0) {
            [resultStr appendFormat:@"%@\n", result[i]];
        } else {
             [resultStr appendFormat:@"%@\t", result[i]];
        }
    }
    
    NSData *fileData = [resultStr dataUsingEncoding:NSUTF8StringEncoding];
    NSString *filePath = [NSString stringWithFormat:@"%@/result.xls", self.temprojectPath];

    [[NSFileManager defaultManager] createFileAtPath:filePath contents:fileData attributes:nil];
    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.startBtn.enabled = YES;
        
        weakSelf.outPath.stringValue = filePath;
    });
   
    
    
}


@end
