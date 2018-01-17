//
//  PBDragView.h
//  PhotoBatch
//
//  Created by qianjn on 2017/11/25.
//  Copyright © 2017年 SF. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol PBDragViewDelegate <NSObject>
@optional
- (void)dragEnter;
- (void)dragExit;
- (void)dragFileComplete:(NSArray *)filepaths;

@end

@interface PBDragView : NSView
@property (nonatomic, weak) id <PBDragViewDelegate> delegate;
@end
