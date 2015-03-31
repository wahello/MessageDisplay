//
//  JKEmotionSectionBar.m
//  MessageDisplay
//
//  Created by Jack on 15/3/27.
//  Copyright (c) 2015年 Jack. All rights reserved.
//

#import "JKEmotionSectionBar.h"
#import "JKEmotionSectionBarTableViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "JKMacro.h"

#define kXHStoreManagerItemWidth 70

@interface JKEmotionSectionBar ()<UITableViewDelegate,UITableViewDataSource>

/**
 *  是否显示表情商店的按钮
 */
@property (nonatomic, assign) BOOL isShowEmotionStoreButton; // default is YES
@property (nonatomic, strong) UITableView *tableview;

@property (nonatomic, strong) NSIndexPath *oldSelectIndexPath;

@property (nonatomic, weak) UIButton *storeManagerItemButton;

@property (nonatomic, strong) UIButton *sendBtn;

@end



@implementation JKEmotionSectionBar

- (void)reloadData
{
    [self.tableview reloadData];
}
#pragma mark - Lefy cycle

- (void)setup {
    
    
    if (!_tableview) {
        _tableview = [[UITableView alloc]init];
        _tableview.backgroundColor = self.backgroundColor;
        _tableview.transform = CGAffineTransformMakeRotation(M_PI/-2);
        _tableview.showsVerticalScrollIndicator = NO;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.frame = CGRectMake(0, 0,  kBoundsWidth, 38);
        _tableview.backgroundColor = [UIColor clearColor];
        [self addSubview:_tableview];
        [_tableview selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        _oldSelectIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    }
    if (!_sendBtn) {
        _sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendBtn.backgroundColor = [UIColor blackColor];
        _sendBtn.frame = CGRectMake(kBoundsWidth - 70, 0.5, 70, 38);
        [_sendBtn setTitle:@"发送" forState:UIControlStateNormal];
        _sendBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_sendBtn setBackgroundColor:[UIColor orangeColor]];
        [_sendBtn addTarget:self action:@selector(sendBtnPressed) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_sendBtn];
    }
    
    UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), 0.5)];
    lineLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"separatorLinePoint"]];
    [self addSubview:lineLabel];
    
    
}

- (void)sendBtnPressed
{
    if ([self.delegate respondsToSelector:@selector(didPressedSendBtnInEmotionView)]) {
        [self.delegate didPressedSendBtnInEmotionView];
    }
}


#pragma mark-TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.emotionManagers.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    JKEmotionSectionBarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[JKEmotionSectionBarTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                       reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.backgroundColor = self.backgroundColor;
    }
    if (indexPath.row == 0 && _oldSelectIndexPath == nil) {
        _oldSelectIndexPath = indexPath;
    }
    JKEmotionDataSource *emotionManager = [self.emotionManagers objectAtIndex:indexPath.row];
    cell.iconImage.image = emotionManager.emotionCoverImage;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_oldSelectIndexPath.row == indexPath.row) {
        return;
    }
    [tableView deselectRowAtIndexPath:_oldSelectIndexPath animated:YES];
    _oldSelectIndexPath = indexPath;
    if ([self.delegate respondsToSelector:@selector(didSelecteEmotionManager:atSection:)]) {
        NSInteger section = indexPath.row;
        if (section < self.emotionManagers.count) {
            [self.delegate didSelecteEmotionManager:[self.emotionManagers objectAtIndex:section] atSection:section];
        }
    }
    
}



- (instancetype)initWithFrame:(CGRect)frame showEmotionStoreButton:(BOOL)isShowEmotionStoreButtoned {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.isShowEmotionStoreButton = isShowEmotionStoreButtoned;
        [self setup];
    }
    return self;
}

- (void)dealloc {
    self.emotionManagers = nil;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (newSuperview) {
        
    }
}




@end
