//
//  JKVoiceRecordHelper.h
//  MessageDisplayExample
//
//  Created by HUAJIE-1 on 14-5-13.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef BOOL(^JKPrepareRecorderCompletion)();
typedef void(^JKStartRecorderCompletion)();
typedef void(^JKStopRecorderCompletion)();
typedef void(^JKPauseRecorderCompletion)();
typedef void(^JKResumeRecorderCompletion)();
typedef void(^JKCancellRecorderDeleteFileCompletion)();
typedef void(^JKRecordProgress)(float progress);
typedef void(^JKPeakPowerForChannel)(float peakPowerForChannel);


@interface JKVoiceRecordHelper : NSObject

@property (nonatomic, copy) JKStopRecorderCompletion maxTimeStopRecorderCompletion;
@property (nonatomic, copy) JKRecordProgress recordProgress;
@property (nonatomic, copy) JKPeakPowerForChannel peakPowerForChannel;
@property (nonatomic, copy, readonly) NSString *recordPath;
@property (nonatomic, copy) NSString *recordDuration;
@property (nonatomic) float maxRecordTime; // 默认 60秒为最大
@property (nonatomic, readonly) NSTimeInterval currentTimeInterval;

- (void)prepareRecordingWithPath:(NSString *)path prepareRecorderCompletion:(JKPrepareRecorderCompletion)prepareRecorderCompletion;
- (void)startRecordingWithStartRecorderCompletion:(JKStartRecorderCompletion)startRecorderCompletion;
- (void)pauseRecordingWithPauseRecorderCompletion:(JKPauseRecorderCompletion)pauseRecorderCompletion;
- (void)resumeRecordingWithResumeRecorderCompletion:(JKResumeRecorderCompletion)resumeRecorderCompletion;
- (void)stopRecordingWithStopRecorderCompletion:(JKStopRecorderCompletion)stopRecorderCompletion;
- (void)cancelledDeleteWithCompletion:(JKCancellRecorderDeleteFileCompletion)cancelledDeleteCompletion;

@end
