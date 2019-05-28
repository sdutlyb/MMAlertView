//
//  YBAlertViewConfig.m
//  ybAlertView
//
//  Created by yibin on 2019/3/8.
//  Copyright (c) 2019 liuyibin. All rights reserved.
//

#import "YBAlertViewConfig.h"

@implementation YBAlertViewConfig

static YBAlertViewConfig *_sharedSingleton = nil;

#pragma mark - 生成HKRouter的单例

+ (instancetype)sharedConfig {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedSingleton = [[super allocWithZone:NULL] init];
        [_sharedSingleton defaultConfig];
    });
    return _sharedSingleton;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedSingleton = [super allocWithZone:zone];
    });
    return _sharedSingleton;
}

- (id)copyWithZone:(NSZone *)zone {
    return _sharedSingleton;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return _sharedSingleton;
}

#pragma mark -

- (void)defaultConfig {
    _themeColor = [UIColor colorWithRed:0.2 green:0.8 blue:0.2 alpha:1];
    
    _defaultTitle = @"温馨提示";
    _defaultCountdownText = @"阅读并同意";
    _titleTextFont = [UIFont systemFontOfSize:16.f];
    _titleTextColor = [UIColor whiteColor];
    
    _messageTextFont = [UIFont systemFontOfSize:16.f];
    _messageTextColor = [UIColor darkGrayColor];
    _actionButtonFont = [UIFont systemFontOfSize:16.f];
    _actionButtonTextColor = [UIColor darkGrayColor];
    _preferredActionButtonFont = [UIFont systemFontOfSize:16.f];
    _preferredActionButtonTextColor = [UIColor colorWithRed:0.2 green:0.8 blue:0.8 alpha:1];
}

@end
