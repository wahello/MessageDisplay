//
//  JKMessage.h
//  MessageDisplay
//
//  Created by Jack on 15/3/26.
//  Copyright (c) 2015年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>



typedef NS_ENUM(NSInteger, JKBubbleMessageType) {
    JKBubbleMessageTypeSending = 0, // 发送
    JKBubbleMessageTypeReceiving // 接收
};

typedef NS_ENUM(NSUInteger, JKBubbleImageViewStyle) {
    JKBubbleImageViewStyleWeChat = 0
};

typedef NS_ENUM(NSInteger, JKBubbleMessageMediaType) {
    JKBubbleMessageMediaTypeText = 0,
    JKBubbleMessageMediaTypePhoto = 1,
    JKBubbleMessageMediaTypeVideo = 2,
    JKBubbleMessageMediaTypeVoice = 3,
    JKBubbleMessageMediaTypeEmotion = 4,
    JKBubbleMessageMediaTypeLocalPosition = 5,
    JKBubbleMessageMediaTypeCard = 6,
};

typedef NS_ENUM(NSInteger, JKBubbleMessageMenuSelecteType) {
    JKBubbleMessageMenuSelecteTypeTextCopy = 0,
    JKBubbleMessageMenuSelecteTypeTextTranspond = 1,
    JKBubbleMessageMenuSelecteTypeTextFavorites = 2,
    JKBubbleMessageMenuSelecteTypeTextMore = 3,
    
    JKBubbleMessageMenuSelecteTypePhotoCopy = 4,
    JKBubbleMessageMenuSelecteTypePhotoTranspond = 5,
    JKBubbleMessageMenuSelecteTypePhotoFavorites = 6,
    JKBubbleMessageMenuSelecteTypePhotoMore = 7,
    
    JKBubbleMessageMenuSelecteTypeVideoTranspond = 8,
    JKBubbleMessageMenuSelecteTypeVideoFavorites = 9,
    JKBubbleMessageMenuSelecteTypeVideoMore = 10,
    
    JKBubbleMessageMenuSelecteTypeVoicePlay = 11,
    JKBubbleMessageMenuSelecteTypeVoiceFavorites = 12,
    JKBubbleMessageMenuSelecteTypeVoiceTurnToText = 13,
    JKBubbleMessageMenuSelecteTypeVoiceMore = 14,
};


@interface JKMessage : NSObject <NSCopying, NSCopying>

@property (nonatomic, copy)     NSString *text;

@property (nonatomic, assign)   CGSize  size;
@property (nonatomic, assign)   CGSize thumbnailSize;
@property (nonatomic, strong)   UIImage *photo;
@property (nonatomic, copy)     NSString *thumbnailUrl;
@property (nonatomic, copy)     NSString *originPhotoUrl;

@property (nonatomic, strong)   UIImage *videoConverPhoto;
@property (nonatomic, copy)     NSString *videoPath;
@property (nonatomic, copy)     NSString *videoUrl;

@property (nonatomic, copy)     NSString *voicePath;
@property (nonatomic, copy)     NSString *voiceUrl;
@property (nonatomic, copy)     NSString *voiceDuration;

@property (nonatomic, copy)     NSString *emotionPath;

@property (nonatomic, strong)   UIImage *localPositionPhoto;
@property (nonatomic, copy)     NSString *geolocations;
@property (nonatomic, strong)   CLLocation *location;

@property (nonatomic, strong)   UIImage *avatar;
@property (nonatomic, copy)     NSString *avatarUrl;

@property (nonatomic, copy)     NSString *sender;

@property (nonatomic, strong)   NSDate *timestamp;

@property (nonatomic, assign)   long long timesplong;

@property (nonatomic, assign)   BOOL sended;

@property (nonatomic, assign)   JKBubbleMessageMediaType messageMediaType;

@property (nonatomic, assign)   JKBubbleMessageType bubbleMessageType;

@property (nonatomic, assign)   BOOL isRead;

@property (nonatomic, assign)   BOOL isBubbleShow;
@property (nonatomic, assign)   BOOL isChatGroup;  //是否是群聊
@property (nonatomic, assign)   BOOL isOfflineMessage;//是否离线消息

@property (nonatomic, strong)   NSAttributedString *attStrContent; //conten显示内容
@property (nonatomic, strong)   UIImage *emotionImage;// 自带表情图片
@property (nonatomic, assign)   CGSize contenSize; //message显示内容 大小
@property (nonatomic, assign)   CGSize imageSize;
@property (nonatomic, assign)   CGFloat cellheigh; //tableview 的cell高度

@property (nonatomic, assign) BOOL isTimestampShow;//是否显示时间

/**
 *  初始化文本消息
 *
 *  @param text   发送的目标文本
 *  @param sender 发送者的名称
 *  @param date   发送的时间
 *
 *  @return 返回Message model 对象
 */
- (instancetype)initWithText:(NSString *)text
                      sender:(NSString *)sender
                   timestamp:(NSDate *)timestamp;

/**
 *  初始化图片类型的消息
 *
 *  @param photo          目标图片
 *  @param thumbnailUrl   目标图片在服务器的缩略图地址
 *  @param originPhotoUrl 目标图片在服务器的原图地址
 *  @param sender         发送者
 *  @param date           发送时间
 *
 *  @return 返回Message model 对象
 */
- (instancetype)initWithPhoto:(UIImage *)photo
                 thumbnailUrl:(NSString *)thumbnailUrl
               originPhotoUrl:(NSString *)originPhotoUrl
                       sender:(NSString *)sender
                    timestamp:(NSDate *)timestamp;

/**
 *  初始化视频类型的消息
 *
 *  @param videoConverPhoto 目标视频的封面图
 *  @param videoPath        目标视频的本地路径，如果是下载过，或者是从本地发送的时候，会存在
 *  @param videoUrl         目标视频在服务器上的地址
 *  @param sender           发送者
 *  @param date             发送时间
 *
 *  @return 返回Message model 对象
 */
- (instancetype)initWithVideoConverPhoto:(UIImage *)videoConverPhoto
                               videoPath:(NSString *)videoPath
                                videoUrl:(NSString *)videoUrl
                                  sender:(NSString *)sender
                               timestamp:(NSDate *)timestamp;

/**
 *  初始化语音类型的消息
 *
 *  @param voicePath        目标语音的本地路径
 *  @param voiceUrl         目标语音在服务器的地址
 *  @param voiceDuration    目标语音的时长
 *  @param sender           发送者
 *  @param date             发送时间
 *
 *  @return 返回Message model 对象
 */
- (instancetype)initWithVoicePath:(NSString *)voicePath
                         voiceUrl:(NSString *)voiceUrl
                    voiceDuration:(NSString *)voiceDuration
                           sender:(NSString *)sender
                        timestamp:(NSDate *)timestamp;

/**
 *  初始化语音类型的消息。增加已读未读标记
 *
 *  @param voicePath        目标语音的本地路径
 *  @param voiceUrl         目标语音在服务器的地址
 *  @param voiceDuration    目标语音的时长
 *  @param sender           发送者
 *  @param date             发送时间
 *  @param isRead           已读未读标记
 *
 *  @return 返回Message model 对象
 */
- (instancetype)initWithVoicePath:(NSString *)voicePath
                         voiceUrl:(NSString *)voiceUrl
                    voiceDuration:(NSString *)voiceDuration
                           sender:(NSString *)sender
                        timestamp:(NSDate *)timestamp
                           isRead:(BOOL)isRead;

/**
 *  初始化gif表情类型的消息
 *
 *  @param emotionPath 表情的路径
 *  @param sender      发送者
 *  @param timestamp   发送时间
 *
 *  @return 返回Message model 对象
 */
- (instancetype)initWithEmotionPath:(NSString *)emotionPath
                             sender:(NSString *)sender
                          timestamp:(NSDate *)timestamp;

/**
 *  初始化地理位置的消息
 *
 *  @param localPositionPhoto 地理位置默认显示的图
 *  @param geolocations       地理位置的信息
 *  @param location           地理位置的经纬度
 *  @param sender             发送者
 *  @param timestamp          发送时间
 *
 *  @return 返回Message model 对象
 */
- (instancetype)initWithLocalPositionPhoto:(UIImage *)localPositionPhoto
                              geolocations:(NSString *)geolocations
                                  location:(CLLocation *)location
                                    sender:(NSString *)sender
                                 timestamp:(NSDate *)timestamp;



@end
