//
//  JKEmotion.h
//  MessageDisplay
//
//  Created by Jack on 15/3/27.
//  Copyright (c) 2015年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface JKEmotion : NSObject
/**
 *  gif表情的封面图
 */
@property (nonatomic, strong) UIImage *emotionConverPhoto;

/**
 *  gif表情的路径
 */
@property (nonatomic, copy) NSString *emotionPath;

@property (nonatomic, assign) CGSize imageSize;

@property (nonatomic, strong) NSString *emojName;
@property (nonatomic, strong) NSString *emojType;
@property (nonatomic, strong) NSString *emojKey;

@property (nonatomic, strong) NSString *emojImageName;

@property (nonatomic, strong) UIImage *originalImage;
@property (nonatomic, strong) UIImage *thumbnailImage;

@property (nonatomic, strong) UIImage *coverPhotoImage;



@end
