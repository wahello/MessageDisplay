//
//  JKShareMenuView.m
//  MessageDisplay
//
//  Created by Jack on 15/3/26.
//  Copyright (c) 2015年 Jack. All rights reserved.
//
#import "JKMacro.h"
#import "JKShareMenuView.h"
#import "UIScrollView+SQkeyboardControl.h"

#define kShareMenuItemWidth 60
#define kShareMenuItemHeight 80

#define kShareMenuPageControlHeight 30


#define kShareMenuGap 10

// 每行有4个 ipad 10个
#define kShareMenuPerRowItemCount (JKIsiPad ? 8 : 3)
#define kShareMenuPerColum 2


@interface VoiceRecodeView : UIView

@end


@interface ShareMenuItemView : UIView

/**
 *  第三方按钮
 */
@property (nonatomic, weak) UIButton *shareMenuItemButton;
/**
 *  第三方按钮的标题
 */
@property (nonatomic, weak) UILabel *shareMenuItemTitleLabel;

/**
 *  配置默认控件的方法
 */
- (void)setup;

@end

@implementation ShareMenuItemView

- (void)setup {
    if (!_shareMenuItemButton) {
        UIButton *shareMenuItemButton = [UIButton buttonWithType:UIButtonTypeCustom];
        shareMenuItemButton.frame = CGRectMake(0, 0, kShareMenuItemWidth, kShareMenuItemWidth);
        shareMenuItemButton.backgroundColor = [UIColor clearColor];
        [self addSubview:shareMenuItemButton];
        
        self.shareMenuItemButton = shareMenuItemButton;
    }
    
    if (!_shareMenuItemTitleLabel) {
        UILabel *shareMenuItemTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.shareMenuItemButton.frame), kShareMenuItemWidth, kShareMenuItemHeight - kShareMenuItemWidth)];
        shareMenuItemTitleLabel.backgroundColor = [UIColor clearColor];
        shareMenuItemTitleLabel.textColor = [UIColor lightGrayColor];
        shareMenuItemTitleLabel.font = [UIFont systemFontOfSize:12];
        shareMenuItemTitleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:shareMenuItemTitleLabel];
        
        self.shareMenuItemTitleLabel = shareMenuItemTitleLabel;
    }
}

- (void)awakeFromNib {
    [self setup];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

@end



@interface JKShareMenuView ()<UIScrollViewDelegate>

/**
 *  这是背景滚动视图
 */
@property (nonatomic, weak) UIScrollView *shareMenuScrollView;

/**
 *  显示页码的视图
 */
@property (nonatomic, weak) UIPageControl *shareMenuPageControl;



/**
 *  第三方按钮点击的事件
 *
 *  @param sender 第三方按钮对象
 */
- (void)shareMenuItemButtonClicked:(UIButton *)sender;

/**
 *  配置默认控件
 */
- (void)setup;

@end








@implementation JKShareMenuView

- (void)shareMenuItemButtonClicked:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(didSelecteShareMenuItem:atIndex:)]) {
        NSInteger index = sender.tag;
        if (index < self.shareMenuItems.count) {
            [self.delegate didSelecteShareMenuItem:[self.shareMenuItems objectAtIndex:index] atIndex:index];
        }
    }
}

- (void)reloadData {
    
    if (!_shareMenuItems.count)
        return;
    
    [self.shareMenuScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGFloat paddingX = (kBoundsWidth - kShareMenuPerRowItemCount *kShareMenuItemWidth )/(kShareMenuPerRowItemCount +1);
    
    CGFloat paddingY = kShareMenuGap;
    
    for (JKShareMenuItem *shareMenuItem in self.shareMenuItems) {
        NSInteger index = [self.shareMenuItems indexOfObject:shareMenuItem];
        NSInteger page = index / (kShareMenuPerRowItemCount * kShareMenuPerColum);
        CGRect shareMenuItemViewFrame = [self getFrameWithPerRowItemCount:kShareMenuPerRowItemCount
                                                        perColumItemCount:kShareMenuPerColum
                                                                itemWidth:kShareMenuItemWidth
                                                               itemHeight:kShareMenuItemHeight
                                                                 paddingX:paddingX
                                                                 paddingY:paddingY
                                                                  atIndex:index
                                                                   onPage:page];
        
        
        ShareMenuItemView *shareMenuItemView = [[ShareMenuItemView alloc] initWithFrame:shareMenuItemViewFrame];
        shareMenuItemView.shareMenuItemButton.tag = index;
        [shareMenuItemView.shareMenuItemButton addTarget:self action:@selector(shareMenuItemButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [shareMenuItemView.shareMenuItemButton setImage:shareMenuItem.normalIconImage forState:UIControlStateNormal];
        shareMenuItemView.shareMenuItemTitleLabel.text = shareMenuItem.title;
        [self.shareMenuScrollView addSubview:shareMenuItemView];
    }
    
    self.shareMenuPageControl.numberOfPages = (self.shareMenuItems.count / (kShareMenuPerRowItemCount * 2) + (self.shareMenuItems.count % (kShareMenuPerRowItemCount * 2) ? 1 : 0));
    [self.shareMenuScrollView setContentSize:CGSizeMake(((self.shareMenuItems.count / (kShareMenuPerRowItemCount * 2) + (self.shareMenuItems.count % (kShareMenuPerRowItemCount * 2) ? 1 : 0)) * CGRectGetWidth(self.bounds)), CGRectGetHeight(self.shareMenuScrollView.bounds))];
}

/**
 *  通过目标的参数，获取一个grid布局
 *
 *  @param perRowItemCount   每行有多少列
 *  @param perColumItemCount 每列有多少行
 *  @param itemWidth         gridItem的宽度
 *  @param itemHeight        gridItem的高度
 *  @param paddingX          gridItem之间的X轴间隔
 *  @param paddingY          gridItem之间的Y轴间隔
 *  @param index             某个gridItem所在的index序号
 *  @param page              某个gridItem所在的页码
 *
 *  @return 返回一个已经处理好的gridItem frame
 */
- (CGRect)getFrameWithPerRowItemCount:(NSInteger)perRowItemCount
                    perColumItemCount:(NSInteger)perColumItemCount
                            itemWidth:(CGFloat)itemWidth
                           itemHeight:(NSInteger)itemHeight
                             paddingX:(CGFloat)paddingX
                             paddingY:(CGFloat)paddingY
                              atIndex:(NSInteger)index
                               onPage:(NSInteger)page {
    CGRect itemFrame = CGRectMake((index % perRowItemCount) * (itemWidth + paddingX) + paddingX + (page * CGRectGetWidth(self.bounds)), ((index / perRowItemCount) - perColumItemCount * page) * (itemHeight + paddingY) + paddingY, itemWidth, itemHeight);
    return itemFrame;
}

#pragma mark - Life cycle

- (void)setup {
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    if (!_shareMenuScrollView) {
        UIScrollView *shareMenuScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - kShareMenuPageControlHeight)];
        shareMenuScrollView.delegate = self;
        shareMenuScrollView.canCancelContentTouches = NO;
        shareMenuScrollView.delaysContentTouches = YES;
        shareMenuScrollView.backgroundColor = self.backgroundColor;
        shareMenuScrollView.showsHorizontalScrollIndicator = NO;
        shareMenuScrollView.showsVerticalScrollIndicator = NO;
        [shareMenuScrollView setScrollsToTop:NO];
        shareMenuScrollView.pagingEnabled = YES;
        [self addSubview:shareMenuScrollView];
        
        self.shareMenuScrollView = shareMenuScrollView;
    }
    
    if (!_shareMenuPageControl) {
        UIPageControl *shareMenuPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.shareMenuScrollView.frame), CGRectGetWidth(self.bounds), kShareMenuPageControlHeight)];
        shareMenuPageControl.backgroundColor = self.backgroundColor;
        shareMenuPageControl.hidesForSinglePage = YES;
        shareMenuPageControl.defersCurrentPageDisplay = YES;
        [self addSubview:shareMenuPageControl];
        
        self.shareMenuPageControl = shareMenuPageControl;
    }
}

- (void)awakeFromNib {
    [self setup];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

- (void)dealloc {
    self.shareMenuItems = nil;
    self.shareMenuScrollView.delegate = self;
    self.shareMenuScrollView = nil;
    self.shareMenuPageControl = nil;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (newSuperview) {
        [self reloadData];
    }
}

#pragma mark - UIScrollView delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //每页宽度
    CGFloat pageWidth = scrollView.frame.size.width;
    //根据当前的坐标与页宽计算当前页码
    NSInteger currentPage = floor((scrollView.contentOffset.x - pageWidth/2)/pageWidth)+1;
    [self.shareMenuPageControl setCurrentPage:currentPage];
}






@end
