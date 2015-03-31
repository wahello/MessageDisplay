//
//  DemoMessageTableViewController.h
//  MessageDisplay
//
//  Created by Jack on 15/3/30.
//  Copyright (c) 2015年 Jack. All rights reserved.
//

#import "JKMessageTableViewController.h"

@interface DemoMessageTableViewController : JKMessageTableViewController

- (void)loadDemoDataSource;

- (instancetype)initWithChatter:(NSString *)chatter;
@property (nonatomic, strong) NSString *chatter;

@end
