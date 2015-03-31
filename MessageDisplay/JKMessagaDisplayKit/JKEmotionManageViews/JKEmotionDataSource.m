//
//  JKEmotionDataSource.m
//  MessageDisplay
//
//  Created by Jack on 15/3/27.
//  Copyright (c) 2015年 Jack. All rights reserved.
//

#import "JKEmotionDataSource.h"

@implementation JKEmotionDataSource

- (void)dealloc {
    [self.emotions removeAllObjects];
    self.emotions = nil;
}

@end
