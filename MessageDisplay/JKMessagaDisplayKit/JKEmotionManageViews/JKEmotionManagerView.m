//
//  JKEmotionManagerView.m
//  MessageDisplay
//
//  Created by Jack on 15/3/27.
//  Copyright (c) 2015年 Jack. All rights reserved.
//

#import "JKEmotionManagerView.h"
#import "JKEmojButtonItem.h"
#import "JKEmotionButtonItem.h"
#import "JKEmotionSectionBar.h"
#import "JKMacro.h"


#define deleteButtonx ()

@interface JKEmotionManagerView ()<UIScrollViewDelegate, JKEmotionSectionBarDelegate>

@property (nonatomic, strong ) UIButton *emojDeleteBtn;

/**
 *  显示表情的UIScrollView控件
 */
@property (nonatomic, strong) UIScrollView *emotionScrollView;

/**
 *  显示页码的控件
 */
@property (nonatomic, strong) UIPageControl *emotionPageControl;

@property (nonatomic, assign) NSInteger pageCount;
/**
 *  管理多种类别gif表情的滚动试图
 */
@property (nonatomic, weak)   JKEmotionSectionBar *emotionSectionBar;

@property (nonatomic, strong) UIButton *deleteTextBtn;

/**
 *  当前选择了哪类gif表情标识
 */
@property (nonatomic, assign) NSInteger selectedIndex;

@property (nonatomic, strong) NSMutableArray *previewImageView;


@end


@implementation JKEmotionManagerView


#pragma mark-DataReload
- (void)reloadData {
    NSInteger numberOfEmotionManagers = [self.dataSource numberOfEmotionManagers];
    if (!numberOfEmotionManagers) {
        return ;
    }
    
    self.emotionSectionBar.emotionManagers = [self.dataSource emotionManagersAtManager];
   
    
    
    JKEmotionDataSource *emotionManager = [self.dataSource emotionManagerForColumn:self.selectedIndex];
    
    [_emotionScrollView removeFromSuperview];
    _emotionScrollView = nil;
    if (!_emotionScrollView) {
        _emotionScrollView  = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - kEmotionPageControlHeight-kEmotionSectionBarHeight +10)];
        _emotionScrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"inputViewBackPointColor"]];
        _emotionScrollView.showsHorizontalScrollIndicator = NO;
        _emotionScrollView.showsVerticalScrollIndicator = NO;
        _emotionScrollView.pagingEnabled = YES;
        _emotionScrollView.delegate = self;
        [self addSubview:_emotionScrollView];
    }
    [self addEmojImageViewWith:emotionManager];
}

- (void)addEmojImageViewWith:(JKEmotionDataSource *)emotionManager
{
    NSInteger emotionCount = emotionManager.emotions.count;
    for (long i = 0; i< emotionCount; i++) {
        JKEmotion *emotion = [emotionManager.emotions objectAtIndex:i];
        CGFloat x;
        CGFloat y;
        if (emotionManager.columnNum == kEmotionSmallPerRowItemCount) {
            EmojButtonItem *buttonItem = [EmojButtonItem buttonWithType:UIButtonTypeCustom];
            _pageCount = emotionCount / kEmotionSmallPerPageCount;
            buttonItem.tag = i;
            buttonItem.backgroundColor = [UIColor clearColor];
            [buttonItem setImage:emotion.originalImage forState:UIControlStateNormal];
            [buttonItem setImage:emotion.originalImage forState:UIControlStateHighlighted];
            [buttonItem addTarget:self action:@selector(emojDidSelected:) forControlEvents:UIControlEventTouchUpInside];
            //            [buttonItem setHitTestEdgeInsets:UIEdgeInsetsMake(-5, -5, -5, -5)];
            buttonItem.emojName = emotion.emojName;
            buttonItem.originalImage = emotion.originalImage;
            
            long pageNum = i/kEmotionSmallPerPageCount;
            
            
            //间隙
            float gapx = (CGRectGetWidth(self.bounds) - kEmotionSmallPerRowItemCount *kEmotionSmallSizeWith)/(kEmotionSmallPerRowItemCount +1);
            float gapy = 15;
            x = gapx+ ( kEmotionSmallSizeWith + gapx)*(i%kEmotionSmallPerRowItemCount)  + pageNum *CGRectGetWidth(self.bounds);
            y = (kEmotionSmallSizeWith + gapy) *( (i%kEmotionSmallPerPageCount)/kEmotionSmallPerRowItemCount);
            buttonItem.frame = CGRectMake(x, y, kEmotionSmallSizeWith, kEmotionSmallSizeWith);
            
            if ((i+1)% kEmotionSmallPerPageCount ) {
                [self.emotionScrollView addSubview:buttonItem];
            }
            else
            {
                x = kBoundsWidth - 44 + pageNum*kBoundsWidth;
                UIButton* emojDeleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                [emojDeleteBtn setImage:[UIImage imageNamed:@"wechat_emoticon_delete"] forState:UIControlStateNormal];
                emojDeleteBtn.frame = CGRectMake(x, 141, kEmotionSmallSizeWith, kEmotionSmallSizeWith);
                [self.emotionScrollView addSubview:emojDeleteBtn];
            }
            
            
            
        }
        else if (emotionManager.columnNum == kEmotionBigPerRowItemCount)
        {
            long pageNum = i/kEmotionBigPerPageCount;
            //间隙
            float gapx = (CGRectGetWidth(self.bounds) - kEmotionBigPerRowItemCount *kEmotionBigSizeWith)/(kEmotionBigPerRowItemCount +1);
            float gapy = 10;
            
            x = gapx+ (kEmotionBigSizeWith +gapx)*(i%kEmotionBigPerRowItemCount)+ pageNum *CGRectGetWidth(self.bounds);
            y = 0+ (kEmotionBigSizeWith + gapy)*((i%kEmotionBigPerPageCount)/kEmotionBigPerRowItemCount);
            
            JKEmotionButtonItem *buttonItemview = [[JKEmotionButtonItem alloc]initWithFrame:CGRectMake(x, y, kEmotionBigSizeWith, kEmotionBigSizeWith)];
            [buttonItemview.buttonitem setImage:emotion.originalImage forState:UIControlStateNormal];
            [buttonItemview.buttonitem setImage:emotion.originalImage forState:UIControlStateHighlighted];
            buttonItemview.backgroundColor = [UIColor clearColor];
            buttonItemview.buttonitem.tag = i;
            NSString *tempStr = emotion.emojName;
            tempStr = [tempStr stringByReplacingOccurrencesOfString:@"[:" withString:@""];
            tempStr = [tempStr stringByReplacingOccurrencesOfString:@"[" withString:@""];
            tempStr = [tempStr stringByReplacingOccurrencesOfString:@"]" withString:@""];
            buttonItemview.emotionName.text = tempStr;
            buttonItemview.buttonitem.emojName = emotion.emojName;
            [buttonItemview.buttonitem addTarget:self action:@selector(emotionDidSelected:) forControlEvents:UIControlEventTouchUpInside];
            [self.emotionScrollView addSubview:buttonItemview];
        }
    }
    
    if (emotionManager.columnNum == kEmotionSmallPerRowItemCount) {
        _pageCount = (emotionCount %kEmotionSmallPerPageCount)? emotionCount/kEmotionSmallPerPageCount +1 : emotionCount/kEmotionSmallPerPageCount;
        
        for (int i = 0 ; i< _pageCount; i++) {
            float x = kBoundsWidth - 44 + i*kBoundsWidth;
            UIButton* emojDeleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [emojDeleteBtn setImage:[UIImage imageNamed:@"wechat_emoticon_delete"] forState:UIControlStateNormal];
            emojDeleteBtn.frame = CGRectMake(x, 141, 32, 32);
            [emojDeleteBtn addTarget:self action:@selector(emojDeleteBtnPressed) forControlEvents:UIControlEventTouchUpInside];
            [self.emotionScrollView addSubview:emojDeleteBtn];
        }
        
    }
    else if (emotionManager.columnNum == kEmotionBigPerRowItemCount)
    {
        _pageCount = (emotionCount % kEmotionBigPerPageCount)? emotionCount/kEmotionBigPerPageCount +1 : emotionCount/kEmotionBigPerPageCount;
    }
    _emotionPageControl.numberOfPages = _pageCount;
    self.emotionScrollView.contentSize = CGSizeMake(_pageCount*CGRectGetWidth(self.bounds), _emotionScrollView.bounds.size.height);
}


#pragma mark-表情选择
- (void)emotionDidSelected:(id)sender
{
    EmojButtonItem *item = (EmojButtonItem *)sender;
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelecteEmotion:atIndexPath:)]) {
        JKEmotionDataSource *emotionManager = [self.dataSource emotionManagerForColumn:self.selectedIndex];
        
        [self.delegate didSelecteEmotion:emotionManager.emotions[item.tag] atIndexPath:[NSIndexPath indexPathForRow:self.selectedIndex inSection:item.tag]];
    }
}

-(void)emojDeleteBtnPressed
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didPressedEmojDeleteBtn)]) {
        [self.delegate didPressedEmojDeleteBtn];
    }
}


- (void)emojDidSelected:(id)sender
{
    EmojButtonItem *item = (EmojButtonItem *)sender;
    if (self.delegate && [self.delegate respondsToSelector:@selector(didselecteEmoj:atIndexPath:)]) {
        JKEmotionDataSource *emotionManager = [self.dataSource emotionManagerForColumn:self.selectedIndex];
        [self.delegate didselecteEmoj:emotionManager.emotions[item.tag] atIndexPath:[NSIndexPath indexPathForRow:self.selectedIndex inSection:item.tag]];
    }
}

#pragma mark - XHEmotionSectionBar Delegate
- (void)didSelecteEmotionManager:(JKEmotionDataSource *)emotionManager atSection:(NSInteger)section {
    self.selectedIndex = section;
    self.emotionPageControl.currentPage = 0;
    [self reloadData];
}
- (void)didPressedSendBtnInEmotionView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didPressedSendBtnInSectionBar)]) {
        [self.delegate didPressedSendBtnInSectionBar];
    }
}


- (void)setup {
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"inputViewBackPointColor"]];
//    self.isShowEmotionStoreButton = NO;
    
    _previewImageView = [NSMutableArray array];
    
    if (!_emotionScrollView) {
        _emotionScrollView  = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - kEmotionPageControlHeight-kEmotionSectionBarHeight)];
        _emotionScrollView.backgroundColor = self.backgroundColor;
        _emotionScrollView.showsHorizontalScrollIndicator = NO;
        _emotionScrollView.showsVerticalScrollIndicator = NO;
        _emotionScrollView.pagingEnabled = YES;
        _emotionScrollView.delegate = self;
        [self addSubview:_emotionScrollView];
    }
    
    if (!_emotionPageControl) {
        UIPageControl *emotionPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.emotionScrollView.frame), CGRectGetWidth(self.bounds), kEmotionPageControlHeight)];
        emotionPageControl.currentPageIndicatorTintColor = [UIColor colorWithWhite:0.471 alpha:1.000];
        emotionPageControl.pageIndicatorTintColor = [UIColor colorWithWhite:0.678 alpha:1.000];
        emotionPageControl.backgroundColor = self.backgroundColor;
        emotionPageControl.hidesForSinglePage = YES;
        emotionPageControl.defersCurrentPageDisplay = YES;
        [self addSubview:emotionPageControl];
        self.emotionPageControl = emotionPageControl;
    }
    
    if (!_emotionSectionBar) {
        JKEmotionSectionBar *emotionSectionBar = [[JKEmotionSectionBar alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.emotionPageControl.frame), CGRectGetWidth(self.bounds), kEmotionSectionBarHeight) showEmotionStoreButton:self.isShowEmotionStoreButton];
        emotionSectionBar.delegate = self;
        emotionSectionBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        emotionSectionBar.backgroundColor = self.backgroundColor;
        
        [self addSubview:emotionSectionBar];
        self.emotionSectionBar = emotionSectionBar;
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
    self.emotionPageControl = nil;
    self.emotionSectionBar = nil;
    self.emotionScrollView.delegate = nil;
    self.emotionScrollView = nil;
}




#pragma mark-ScrollViewDelegate
//停止滚动的时候
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_emotionPageControl setCurrentPage:scrollView.contentOffset.x / kBoundsWidth];
    [_emotionPageControl updateCurrentPageDisplay];
}


@end
