//
//  JKEmotionButtonItem.m
//  MessageDisplay
//
//  Created by Jack on 15/3/27.
//  Copyright (c) 2015年 Jack. All rights reserved.
//

#import "JKEmotionButtonItem.h"
#define itemWith 70


@implementation JKEmotionButtonItem


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initSubView];
        
    }
    return self;
}

- (void)initSubView
{
    self.buttonitem = [EmojButtonItem buttonWithType:UIButtonTypeCustom];
    _buttonitem.frame = CGRectMake(5, 0, 60, 60);
    [_buttonitem setImage:[UIImage imageNamed:@"cat_animate_02_0010"] forState:UIControlStateNormal];
    
    [self addSubview:_buttonitem];
    _emotionName = [[UILabel alloc]initWithFrame:CGRectMake(0, 60, 70, 10)];
    _emotionName.backgroundColor = [UIColor clearColor];
    _emotionName.textAlignment = NSTextAlignmentCenter;
    _emotionName.font = [UIFont boldSystemFontOfSize:12];
    _emotionName.textColor = [UIColor lightGrayColor];
    _emotionName.text = @"可爱";
    [self addSubview:_emotionName];
}


@end
