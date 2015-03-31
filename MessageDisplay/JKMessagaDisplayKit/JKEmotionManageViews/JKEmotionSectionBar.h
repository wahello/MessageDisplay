//
//  JKEmotionSectionBar.h
//  MessageDisplay
//
//  Created by Jack on 15/3/27.
//  Copyright (c) 2015年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKEmotionDataSource.h"

@protocol JKEmotionSectionBarDelegate <NSObject>

/**
 *  点击某一类gif表情的回调方法
 *
 *  @param emotionManager 被点击的管理表情Model对象
 *  @param section        被点击的位置
 */
- (void)didSelecteEmotionManager:(JKEmotionDataSource *)emotionManager atSection:(NSInteger)section;

- (void)didPressedSendBtnInEmotionView;

@end


@interface JKEmotionSectionBar : UIView

@property (nonatomic, weak) id <JKEmotionSectionBarDelegate> delegate;

/**
 *  数据源
 */
@property (nonatomic, strong) NSArray *emotionManagers;

- (instancetype)initWithFrame:(CGRect)frame showEmotionStoreButton:(BOOL)isShowEmotionStoreButtoned;


- (void)reloadData;


@end
