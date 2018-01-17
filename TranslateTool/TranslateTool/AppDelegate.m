//
//  AppDelegate.m
//  TranslateTool
//
//  Created by qianjn on 2018/1/9.
//  Copyright © 2018年 SF. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
    [[NSApplication sharedApplication].keyWindow setMinSize:NSMakeSize(800, 600)];
    [[NSApplication sharedApplication].keyWindow setMaxSize:NSMakeSize(800, 600)];
    
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
