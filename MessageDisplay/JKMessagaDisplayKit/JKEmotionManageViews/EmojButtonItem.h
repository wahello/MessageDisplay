//
//  EmojButtonItem.h
//  Whosv
//
//  Created by Jack on 14/12/30.
//  Copyright (c) 2014年 Shanghai Shequan Network Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "UIButton+Extensions.h"
@interface EmojButtonItem : UIButton

@property (nonatomic, strong) NSString *emojName;
@property (nonatomic, strong) NSString *emojType;
@property (nonatomic, strong) NSString *emojKey;
@property (nonatomic, strong) NSString *emojImageName;

@property (nonatomic, strong) UIImage *originalImage;
@property (nonatomic, strong) UIImage *thumbnailImage;
@property (nonatomic, strong) UIImage *coverPhotoImage;

@end
