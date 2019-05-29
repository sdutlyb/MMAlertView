//
//  MMAlertViewConfig.h
//  MMAlertView
//
//  Created by yibin on 2019/3/8.
//  Copyright (c) 2019 liuyibin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MMAlertViewConfig : NSObject

+ (instancetype)sharedConfig;

@property(strong, nonatomic) UIColor *themeColor;

@property(strong, nonatomic) NSString *defaultTitle;
@property(strong, nonatomic) NSString *defaultCountdownText;

@property(strong, nonatomic) UIFont *titleTextFont;
@property(strong, nonatomic) UIColor *titleTextColor;

@property(strong, nonatomic) UIFont *messageTextFont;
@property(strong, nonatomic) UIColor *messageTextColor;

@property(strong, nonatomic) UIFont *actionButtonFont;
@property(strong, nonatomic) UIColor *actionButtonTextColor;

@property(strong, nonatomic) UIFont *preferredActionButtonFont;
@property(strong, nonatomic) UIColor *preferredActionButtonTextColor;

@end

NS_ASSUME_NONNULL_END
