//
//  PBDragView.m
//  PhotoBatch
//
//  Created by qianjn on 2017/11/25.
//  Copyright © 2017年 SF. All rights reserved.
//

#import "PBDragView.h"

@implementation PBDragView


- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    self.layer.backgroundColor = [NSColor whiteColor].CGColor;
    [self setNeedsDisplay:YES];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    // 设置支持的文件类型
    [self registerForDraggedTypes:@[NSPasteboardTypePDF, NSPasteboardTypePNG, NSPasteboardTypeURL, NSPasteboardTypeFileURL, NSPasteboardTypeString]];
}

- (NSDragOperation)draggingEntered:(id<NSDraggingInfo>)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(dragEnter)]) {
        [self.delegate dragEnter];
    }
    
    return NSDragOperationGeneric;
}

- (void)draggingExited:(id<NSDraggingInfo>)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(dragExit)]) {
        [self.delegate dragExit];
    }
}

- (BOOL)performDragOperation:(id<NSDraggingInfo>)sender
{
    // 获取所有的路径
    NSArray *arr =  [[sender draggingPasteboard] propertyListForType:NSFilenamesPboardType];
    if (self.delegate && arr.count > 0 && [self.delegate respondsToSelector:@selector(dragFileComplete:)]) {
        [self.delegate dragFileComplete:arr];
    }
    return YES;
}
@end
