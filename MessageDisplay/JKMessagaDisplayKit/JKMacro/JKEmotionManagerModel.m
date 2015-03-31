//
//  JKEmotionManagerModel.m
//  MessageDisplay
//
//  Created by Jack on 15/3/27.
//  Copyright (c) 2015年 Jack. All rights reserved.
//

#import "JKEmotionManagerModel.h"
#import "JKEmotionDataSource.h"
#import "JKEmotion.h"
#import "JKMacro.h"

@implementation JKEmotionManagerModel



static JKEmotionManagerModel *sharedata = nil;
+(JKEmotionManagerModel*)ShareEmotionManagerData
{
    @synchronized(self)
    {
        if (sharedata == nil) {
            sharedata = [[JKEmotionManagerModel alloc]init];
        }
        return sharedata;
    }
}



- (id)init
{
    self = [super init];
    if (self) {
        _allEmotionArr = [NSMutableArray array];
        _allEmotionNameArr = [NSMutableArray array];
        _allEmojNameArr = [NSMutableArray array];
        [self initEmotion];
    }
    return self;
}


- (void)initEmotion
{
    NSString *filePath ;
    
    NSMutableArray *emotionManagers = [NSMutableArray array];
    for ( NSInteger i = 1 ; i< 3; i++) {
        NSInteger emotionCount = 0;
        JKEmotionDataSource *emotionManager = [[JKEmotionDataSource alloc]init];
        filePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"wechat_emotion_0%ldArr",(long)i] ofType:@"plist"];
        NSArray *tempArr = [NSArray arrayWithContentsOfFile:filePath];
        emotionCount = tempArr.count;;
        
        if (i == 1) {
            emotionManager.columnNum = kEmotionSmallPerRowItemCount;
            emotionManager.lineNum = 4;
            emotionManager.emotionName = @"坨坨金";
            emotionManager.imageSize = CGSizeMake(kEmotionSmallSizeWith, kEmotionSmallSizeWith);
            emotionManager.emotionCoverImage = [UIImage imageNamed:@"wechat_emoticon_01Cover"];
            [_allEmojNameArr addObjectsFromArray:tempArr];
        }
        else if (i == 2)
        {
            emotionManager.columnNum = kEmotionBigPerRowItemCount;
            emotionManager.lineNum = 2;
            emotionManager.emotionName = @"喵咪";
            emotionManager.imageSize = CGSizeMake(60, 60);
            emotionManager.emotionCoverImage = [UIImage imageNamed:@"wechat_emoticon_02Cover"];
            [_allEmotionNameArr addObjectsFromArray:tempArr];
        }
        
        
        NSMutableArray *emotionsArr = [NSMutableArray array];
        for ( NSInteger j = 0; j<emotionCount; j++) {
            JKEmotion *emotion = [[JKEmotion alloc] init];
            NSString *imageName = tempArr[j];
            // NSLog(@"%@",imageName);
            emotion.emojImageName = imageName;
            emotion.emojName = imageName;
            emotion.originalImage = [UIImage imageNamed:imageName];
            if (emotion.originalImage) {
                [emotionsArr addObject:emotion];
            }
        }
        emotionManager.emotions = emotionsArr;
        [emotionManagers addObject:emotionManager];
        self.allEmotionArr = emotionManagers;
    }
}



@end
