//
//  JKEmojButtonItem.h
//  MessageDisplay
//
//  Created by Jack on 15/3/27.
//  Copyright (c) 2015年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+Extensions.h"

@interface JKEmojButtonItem : UIButton


@property (nonatomic, strong) NSString *emojName;
@property (nonatomic, strong) NSString *emojType;
@property (nonatomic, strong) NSString *emojKey;
@property (nonatomic, strong) NSString *emojImageName;

@property (nonatomic, strong) UIImage *originalImage;
@property (nonatomic, strong) UIImage *thumbnailImage;
@property (nonatomic, strong) UIImage *coverPhotoImage;


@end
