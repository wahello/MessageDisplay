//
//  DemoMessageTableViewController.m
//  MessageDisplay
//
//  Created by Jack on 15/3/30.
//  Copyright (c) 2015年 Jack. All rights reserved.
//

#import "DemoMessageTableViewController.h"
#import "JKEmotionManagerModel.h"



@interface DemoMessageTableViewController ()

@property (nonatomic, strong) NSArray *emotionManagers;

@end

@implementation DemoMessageTableViewController



- (JKMessage *)getTextMessageWithBubbleMessageType:(JKBubbleMessageType)bubbleMessageType {
    JKMessage *textMessage = [[JKMessage alloc] initWithText:@"Call Me 15915895880. 这是华捷微信，为什么模仿这个页面效果呢？希望微信团队能看到我们在努力，请微信团队给个机会，让我好好的努力靠近大神，希望自己也能发亮，好像有点过分的希望了，如果大家喜欢这个开源库，请大家帮帮忙支持这个开源库吧！我是Jack，叫华仔也行，曾宪华就是我啦！" sender:@"华仔" timestamp:[NSDate distantPast]];
    textMessage.avatar = [UIImage imageNamed:@"avatar"];
    textMessage.avatarUrl = @"http://www.pailixiu.com/jack/meIcon@2x.png";
    textMessage.bubbleMessageType = bubbleMessageType;
    
    return textMessage;
}

- (JKMessage *)getPhotoMessageWithBubbleMessageType:(JKBubbleMessageType)bubbleMessageType {
    JKMessage *photoMessage = [[JKMessage alloc] initWithPhoto:[UIImage imageNamed:@"placeholderImage"] thumbnailUrl:@"http://d.hiphotos.baidu.com/image/pic/item/30adcbef76094b361721961da1cc7cd98c109d8b.jpg" originPhotoUrl:nil sender:@"Jack" timestamp:[NSDate date]];
    photoMessage.avatar = [UIImage imageNamed:@"avatar"];
    photoMessage.avatarUrl = @"http://www.pailixiu.com/jack/JieIcon@2x.png";
    photoMessage.bubbleMessageType = bubbleMessageType;
    
    return photoMessage;
}

//- (JKMessage *)getVideoMessageWithBubbleMessageType:(JKBubbleMessageType)bubbleMessageType {
//    NSString *videoPath = [[NSBundle mainBundle] pathForResource:@"IMG_1555.MOV" ofType:@""];
//    JKMessage *videoMessage = [[JKMessage alloc] initWithVideoConverPhoto:[JKMessageVideoConverPhotoFactory videoConverPhotoWithVideoPath:videoPath] videoPath:videoPath videoUrl:nil sender:@"Jayson" timestamp:[NSDate date]];
//    videoMessage.avatar = [UIImage imageNamed:@"avatar"];
//    videoMessage.avatarUrl = @"http://www.pailixiu.com/jack/JieIcon@2x.png";
//    videoMessage.bubbleMessageType = bubbleMessageType;
//    
//    return videoMessage;
//}

- (JKMessage *)getVoiceMessageWithBubbleMessageType:(JKBubbleMessageType)bubbleMessageType {
    JKMessage *voiceMessage = [[JKMessage alloc] initWithVoicePath:nil voiceUrl:nil voiceDuration:@"1" sender:@"Jayson" timestamp:[NSDate date] isRead:NO];
    voiceMessage.avatar = [UIImage imageNamed:@"avatar"];
    voiceMessage.avatarUrl = @"http://www.pailixiu.com/jack/JieIcon@2x.png";
    voiceMessage.bubbleMessageType = bubbleMessageType;
    
    return voiceMessage;
}

- (JKMessage *)getEmotionMessageWithBubbleMessageType:(JKBubbleMessageType)bubbleMessageType {
    JKMessage *emotionMessage = [[JKMessage alloc] initWithEmotionPath:[[NSBundle mainBundle] pathForResource:@"emotion1.gif" ofType:nil] sender:@"Jayson" timestamp:[NSDate date]];
    emotionMessage.avatar = [UIImage imageNamed:@"avatar"];
    emotionMessage.avatarUrl = @"http://www.pailixiu.com/jack/JieIcon@2x.png";
    emotionMessage.bubbleMessageType = bubbleMessageType;
    
    return emotionMessage;
}

- (JKMessage *)getGeolocationsMessageWithBubbleMessageType:(JKBubbleMessageType)bubbleMessageType {
    JKMessage *localPositionMessage = [[JKMessage alloc] initWithLocalPositionPhoto:[UIImage imageNamed:@"Fav_Cell_Loc"] geolocations:@"中国广东省广州市天河区东圃二马路121号" location:[[CLLocation alloc] initWithLatitude:23.110387 longitude:113.399444] sender:@"Jack" timestamp:[NSDate date]];
    localPositionMessage.avatar = [UIImage imageNamed:@"avatar"];
    localPositionMessage.avatarUrl = @"http://www.pailixiu.com/jack/meIcon@2x.png";
    localPositionMessage.bubbleMessageType = bubbleMessageType;
    
    return localPositionMessage;
}

- (NSMutableArray *)getTestMessages {
    NSMutableArray *messages = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < 2; i ++) {
        [messages addObject:[self getPhotoMessageWithBubbleMessageType:(i % 5) ? JKBubbleMessageTypeSending : JKBubbleMessageTypeReceiving]];
        
//        [messages addObject:[self getVideoMessageWithBubbleMessageType:(i % 6) ? JKBubbleMessageTypeSending : JKBubbleMessageTypeReceiving]];
        
        [messages addObject:[self getVoiceMessageWithBubbleMessageType:(i % 4) ? JKBubbleMessageTypeSending : JKBubbleMessageTypeReceiving]];
        
        [messages addObject:[self getEmotionMessageWithBubbleMessageType:(i % 2) ? JKBubbleMessageTypeSending : JKBubbleMessageTypeReceiving]];
        
        [messages addObject:[self getGeolocationsMessageWithBubbleMessageType:(i % 7) ? JKBubbleMessageTypeSending : JKBubbleMessageTypeReceiving]];
        
        [messages addObject:[self getTextMessageWithBubbleMessageType:(i % 2) ? JKBubbleMessageTypeSending : JKBubbleMessageTypeReceiving]];
    }
    return messages;
}


- (void)loadDemoDataSource {
    JKWEAKSELF
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray *messages = [weakSelf getTestMessages];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.messages = messages;
            [weakSelf.messageTableView reloadData];
            
            [weakSelf scrollToBottomAnimated:NO];
        });
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedStringFromTable(@"聊天", @"MessageDisplayKitString", @"Chat");

    // 添加第三方接入数据
    NSMutableArray *shareMenuItems = [NSMutableArray array];
    NSArray *plugIcons = @[@"whosv_chatframe_image", @"whosv_chatframe_camera",@"whosv_chatframe_image", @"whosv_chatframe_camera",@"whosv_chatframe_image", @"whosv_chatframe_camera",@"whosv_chatframe_image", @"whosv_chatframe_camera",@"whosv_chatframe_image", @"whosv_chatframe_camera"];
    NSArray *plugTitle = @[@"照片", @"拍摄",@"位置",@"视频",@"名片", @"我的收藏", @"实时对讲机", @"语音输入", @"大众点评", @"应用"];
    
    for (NSString *plugIcon in plugIcons) {
        JKShareMenuItem *shareMenuItem = [[JKShareMenuItem alloc] initWithNormalIconImage:[UIImage imageNamed:plugIcon] title:[plugTitle objectAtIndex:[plugIcons indexOfObject:plugIcon]]];
        [shareMenuItems addObject:shareMenuItem];
    }
    self.shareMenuItems = shareMenuItems;
    [self.shareMenuView reloadData];
    
    //表情发送组件
    self.emotionManagers =  [JKEmotionManagerModel ShareEmotionManagerData].allEmotionArr;
    [self.emotionManagerView reloadData];
    
    [self loadDemoDataSource];
}




#pragma mark - SQEmotionManagerView DataSource

- (NSInteger)numberOfEmotionManagers {
    return self.emotionManagers.count;
}

- (JKEmotionDataSource *)emotionManagerForColumn:(NSInteger)column {
    return [self.emotionManagers objectAtIndex:column];
}

- (NSArray *)emotionManagersAtManager {
    return self.emotionManagers;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
