//
//  JKEmotionManagerView.h
//  MessageDisplay
//
//  Created by Jack on 15/3/27.
//  Copyright (c) 2015年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKEmotionDataSource.h"
#import "JKEmotion.h"



@protocol JKEmotionManagerViewDelegate <NSObject>

@optional
/**
 *  第三方gif表情被点击的回调事件
 *
 *  @param emotion   被点击的gif表情Model
 *  @param indexPath 被点击的位置
 */
- (void)didSelecteEmotion:(JKEmotion *)emotion atIndexPath:(NSIndexPath *)indexPath;

/**
 *  小表情被点击
 *
 *  @param emotion   表情Model
 *  @param indexpath 点击位置
 */
- (void)didselecteEmoj:(JKEmotion *)emotion atIndexPath:(NSIndexPath *)indexpath;

/**
 *  点击表情tabBar的发送按钮
 */
- (void)didPressedSendBtnInSectionBar;


- (void)didPressedEmojDeleteBtn;

@end

@protocol JKEmotionManagerViewDataSource <NSObject>

@optional
- (CGFloat)heightForEmotion;


@required
/**
 *  通过数据源获取统一管理一类表情的回调方法
 *
 *  @param column 列数
 *
 *  @return 返回统一管理表情的Model对象
 */
- (JKEmotionDataSource *)emotionManagerForColumn:(NSInteger)column;

/**
 *  通过数据源获取一系列的统一管理表情的Model数组
 *
 *  @return 返回包含统一管理表情Model元素的数组
 */
- (NSArray *)emotionManagersAtManager;

/**
 *  通过数据源获取总共有多少类gif表情
 *
 *  @return 返回总数
 */
- (NSInteger)numberOfEmotionManagers;


@end


@interface JKEmotionManagerView : UIView


@property (nonatomic, weak) id <JKEmotionManagerViewDelegate> delegate;

@property (nonatomic, weak) id <JKEmotionManagerViewDataSource> dataSource;

/**
 *  是否显示表情商店的按钮
 */
@property (nonatomic, assign) BOOL isShowEmotionStoreButton; // default is YES

/**
 *  根据数据源刷新UI布局和数据
 */
- (void)reloadData;





@end
