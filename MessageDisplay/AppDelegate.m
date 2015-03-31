//
//  AppDelegate.m
//  MessageDisplay
//
//  Created by Jack on 15/3/23.
//  Copyright (c) 2015年 Jack. All rights reserved.
//
//Macro


static NSString * const EamoapnsCertName = @"DevEnterPrise";  //ProEnterPrise
//环信服务名
#warning 证书环境必须修改
static NSString * const EamoAppKey = @"whosv-sh#whosv";
//Host 服务器api地址
static NSString * const kNetworkDomain = @"http://staging.whosv.net:80" ;

#import "AppDelegate.h"
#import "EaseMob.h"

#import "DetailViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIUserNotificationSettings *uns = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound) categories:nil];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:uns];
    } else {
        UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeBadge);
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
    }

    
    [[EaseMob sharedInstance] registerSDKWithAppKey:EamoAppKey
                                       apnsCertName:EamoapnsCertName];

    return YES;
}

// 将得到的deviceToken传给SDK
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    
    NSString* deviceTokenstr = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"deviceToken:%@", deviceTokenstr);
    
    [[EaseMob sharedInstance] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
    
    
}



// 绑定deviceToken回调
- (void)didBindDeviceWithError:(EMError *)error
{
    if (error) {
        //        [tooles showAlert:NSLocalizedString(@"apns.failToBindDeviceToken", @"Fail to bind device token") detail:nil];
        NSLog(@"%@",error);
    }
}

// 网络状态变化回调
- (void)didConnectionStateChanged:(EMConnectionState)connectionState
{
//    _connectionState = connectionState;
    
}

// 打印收到的apns信息
-(void)didReiveceRemoteNotificatison:(NSDictionary *)userInfo{
    //    NSError *parseError = nil;
    //    NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:userInfo
    //                                                        options:NSJSONWritingPrettyPrinted error:&parseError];
    //    NSString *str =  [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    //
    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"推送内容"
    //                                                    message:str
    //                                                   delegate:nil
    //                                          cancelButtonTitle:NSLocalizedString(@"ok", @"OK")
    //                                          otherButtonTitles:nil];
    //    [alert show];
    
    NSLog(@"%@",userInfo);
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
