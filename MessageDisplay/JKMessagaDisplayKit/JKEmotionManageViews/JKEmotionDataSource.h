//
//  JKEmotionDataSource.h
//  MessageDisplay
//
//  Created by Jack on 15/3/27.
//  Copyright (c) 2015年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JKEmotionDataSource : NSObject

@property (nonatomic, copy) NSString *emotionName;
/**
 *  某一类表情的数据源
 */
@property (nonatomic, strong) NSMutableArray *emotions;

@property (nonatomic, assign) CGSize imageSize;

@property (nonatomic, assign) NSInteger columnNum; // 表情列数

@property (nonatomic, assign) NSInteger lineNum; // 行数

@property (nonatomic, strong) UIImage *emotionCoverImage;

@property (nonatomic, strong) NSString *emotionCoverImageName;



@end
