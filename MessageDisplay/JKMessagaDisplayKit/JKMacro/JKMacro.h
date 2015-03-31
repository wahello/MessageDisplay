//
//  JKMacro.h
//  MessageDisplay
//
//  Created by Jack on 15/3/26.
//  Copyright (c) 2015年 Jack. All rights reserved.
//

#ifndef MessageDisplay_JKMacro_h
#define MessageDisplay_JKMacro_h

#import <UIKit/UIKit.h>


#define kBoundsHeight [[UIScreen mainScreen] bounds].size.height
#define kBoundsWidth [[UIScreen mainScreen] bounds].size.width

// block self
#define JKWEAKSELF typeof(self) __weak weakSelf = self;
#define JKSTRONGSELF typeof(weakSelf) __strong strongSelf = weakSelf;

// device verson float value
#define JKCURRENT_SYS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

// iPad
#define JKIsiPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

// image STRETCH
#define JK_STRETCH_IMAGE(image, edgeInsets) [image resizableImageWithCapInsets:edgeInsets resizingMode:UIImageResizingModeStretch]

#define MDK_SCREEN_WIDTH  [[UIScreen mainScreen] bounds].size.width
#define MDK_SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height





// iPad
#define JKIsiPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)


#define kEmotionPageControlHeight 30
#define kEmotionSectionBarHeight 34


#define  kEmotionSmallSizeWith 32  //小表情宽高
#define  kEmotionBigSizeWith 70    //大表情宽高



#define kEmotionSmallPerPageCount  (JKIsiPad ? 64 : 28)

#define kEmotionSmallPerRowItemCount (JKIsiPad ? 16 : 7)

#define kEmotionBigPerPageCount  (JKIsiPad ? 18 : 8)

#define kEmotionBigPerRowItemCount (JKIsiPad ? 9 : 4)

// Max record Time
#define kVoiceRecorderTotalTime 60.0

#endif
