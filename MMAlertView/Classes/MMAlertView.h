//
//  CustomIOSAlertView.h
//  CustomIOSAlertView
//
//  Created by Richard on 20/09/2013.
//  Copyright (c) 2013-2015 Wimagguc.
//
//  Lincesed under The MIT License (MIT)
//  http://opensource.org/licenses/MIT
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YBAlertTitleBarStyle)
{
    YBAlertTitleBarStyleThemeColor = 0,
    YBAlertTitleBarStyleGray,       // 白底黑字样式
};

typedef NS_ENUM(NSInteger, YBAlertPreferredActionButtonPosition)
{
    YBAlertPreferredActionButtonPositionLeft = 0,
    YBAlertPreferredActionButtonPositionRight,
    YBAlertPreferredActionButtonPositionAll
};

#define kCustomIOSAlertViewTopTitleHeight 44
#define kCustomIOSAlertViewDefaultButtonHeight 44
#define kCustomIOSAlertViewCornerRadius 6
#define kCustomIOSAlertViewBodyMinHeight 44
#define kCustomIOSAlertViewBodyDefaultWidthRatio 0.85

@interface MMAlertView : UIView

@property(nonatomic, strong) UIView *parentView;    // The parent view this 'dialog' is attached to
@property(nonatomic, strong) UIView *dialogView;    // Dialog's container view
@property(nonatomic, strong) UIView *contentView; // Container within the dialog (place your ui elements here)

@property(assign, nonatomic) YBAlertTitleBarStyle titleBarStyle;
@property(assign, nonatomic) YBAlertPreferredActionButtonPosition preferredActionButtonPosition;

@property(strong, nonatomic) UIFont *titleTextFont;
@property(assign, nonatomic) BOOL shouldShowTopRightCloseButton;

@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSArray *buttonTitles;

/**
 偏好动作按钮index,初始值为-1,表示最右边的按钮为偏好按钮，显示为主题色
 */
@property(nonatomic, assign) NSInteger preferredActionIndex;

@property(nonatomic, assign) CGFloat bodyMarginHorizontal;
@property(nonatomic, assign) CGFloat bodyMarginVertical;

@property(nonatomic, assign) BOOL closeOnTouchUpOutside;

/**
 AlertView body内可定制部分的宽度（可定制区域在alert的body部分四个方向有10个点的margin）
 */
@property(assign, nonatomic) CGFloat contentViewWidth;

@property (copy) void (^onButtonTouchUpInside)(MMAlertView *alertView, NSUInteger buttonIndex);

// =================== instance method==================
- (id)init;

- (void)show;
- (void)close;

- (void)setOnButtonTouchUpInside:(void (^)(MMAlertView *alertView, NSUInteger buttonIndex))onButtonTouchUpInside;

- (void)deviceOrientationDidChange:(NSNotification *)notification;
- (void)dealloc;

@end
