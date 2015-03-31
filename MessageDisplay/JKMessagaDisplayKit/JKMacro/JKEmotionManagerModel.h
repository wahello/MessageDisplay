//
//  JKEmotionManagerModel.h
//  MessageDisplay
//
//  Created by Jack on 15/3/27.
//  Copyright (c) 2015年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JKEmotionManagerModel : NSObject

@property (nonatomic, strong) NSMutableArray *allEmotionArr;
@property (nonatomic, strong) NSMutableDictionary *mapEmotionDic; //图片名做Key
@property (nonatomic, strong) NSMutableDictionary *mapEmotionNameKey; //图片表示内容做Key
@property (nonatomic, strong) NSMutableArray *allEmotionNameArr;//所有的Emotion名字
@property (nonatomic, strong) NSMutableArray *allEmojNameArr; //小表情数组
+(JKEmotionManagerModel*)ShareEmotionManagerData;

@end
