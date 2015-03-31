//
//  JKShareMenuView.h
//  MessageDisplay
//
//  Created by Jack on 15/3/26.
//  Copyright (c) 2015年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKShareMenuItem.h"

typedef NS_ENUM(NSInteger, JKShareMenuViewShowType)
{
    JKShareMenuViewShowTypeNomal =0, //普通选择和栏
    JKShareMenuViewShowTypeVoiceRecode  //录音显示动画
};

@protocol JKShareMenuViewDelegate <NSObject>

@optional
/**
 *  点击第三方功能回调方法
 *
 *  @param shareMenuItem 被点击的第三方Model对象，可以在这里做一些特殊的定制
 *  @param index         被点击的位置
 */
- (void)didSelecteShareMenuItem:(JKShareMenuItem *)shareMenuItem atIndex:(NSInteger)index;


/**
 *  开始录音
 */
- (void)didStartRecordingVoiceAction;
/**
 *  手指向上滑动取消录音
 */
- (void)didCancelRecordingVoiceAction;
/**
 *  松开手指完成录音
 */
- (void)didFinishRecoingVoiceAction;
/**
 *  当手指离开按钮的范围内时，主要为了通知外部的HUD
 */
- (void)didDragOutsideAction;
/**
 *  当手指再次进入按钮的范围内时，主要也是为了通知外部的HUD
 */
- (void)didDragInsideAction;



@end

@interface JKShareMenuView : UIView
/**
 *  第三方功能Models
 */
@property (nonatomic, strong) NSArray *shareMenuItems;

@property (nonatomic, weak) id <JKShareMenuViewDelegate> delegate;

/**
 *  根据数据源刷新第三方功能按钮的布局
 */
- (void)reloadData;


@end
