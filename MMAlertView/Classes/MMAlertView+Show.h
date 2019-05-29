//
//  MMAlertView+Show.h
//  MMAlertView
//
//  Created by yibin on 2019/3/28.
//  Copyright (c) 2019 liuyibin. All rights reserved.
//

#import "MMAlertView.h"

#import "MMAlertViewConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface MMAlertView (Show)

#pragma mark - 提示弹框

/**
 提示类弹框（内容部分居中显示）

 @param title 标题
 @param message 消息内容
 @param onTouchedActionButtons 确定按钮点击回调
 @return MMAlertView实例
 */
+ (instancetype)showReminder:(nullable NSString *)title
                     message:(NSString *)message
      onTouchedActionButtons:(void (^)(MMAlertView *alertView))onTouchedActionButtons;

/**
 提示类弹框
 
 @param title 标题
 @param message 消息内容
 @param messageAlignment 消息内容文字的对齐方式
 @param onTouchedActionButtons 确定按钮点击回调
 @return MMAlertView实例
 */
+ (instancetype)showReminder:(nullable NSString *)title
                     message:(NSString *)message
            messageAlignment:(NSTextAlignment)messageAlignment
      onTouchedActionButtons:(void (^)(MMAlertView *alertView))onTouchedActionButtons;

#pragma mark - 底部多按钮弹框

/**
 底部多按钮的弹框(内容默认居中显示)
 
 @param title 标题
 @param message 消息内容
 @param actionNames 底部按钮标题文字列表
 @param onTouchedActionButtons 底部按钮点击回调
 @return MMAlertView实例
 */
+ (instancetype)showActionsAlert:(nullable NSString *)title
                 message:(NSString *)message
             actionNames:(NSArray *)actionNames
  onTouchedActionButtons:(void (^)(MMAlertView *alertView, NSUInteger buttonIndex))onTouchedActionButtons;

/**
 底部多按钮的弹框
 
 @param title 标题
 @param message 消息内容
 @param messageAlignment 消息内容的文字对齐方式
 @param actionNames 底部按钮标题文字列表
 @param onTouchedActionButtons 底部按钮点击回调
 @return MMAlertView实例
 */
+ (instancetype)showActionsAlert:(nullable NSString *)title
                         message:(NSString *)message
                messageAlignment:(NSTextAlignment)messageAlignment
                     actionNames:(NSArray *)actionNames
          onTouchedActionButtons:(void (^)(MMAlertView *alertView, NSUInteger buttonIndex))onTouchedActionButtons;

#pragma mark - 白色底色的弹框

/**
 全白底色的弹框（message居中显示）
 
 @param title 标题
 @param message 消息内容
 @param actionNames 底部按钮名字列表
 @param onTouchedActionButtons 底部按钮点击回调
 @return MMAlertView实例
 */
+ (instancetype)showWhiteStypeAlert:(nullable NSString *)title
                    message:(NSString *)message
                actionNames:(NSArray *)actionNames
     onTouchedActionButtons:(void (^)(MMAlertView *alertView, NSUInteger buttonIndex))onTouchedActionButtons;

/**
 全白底色的弹框

 @param title 标题
 @param message 消息内容
 @param messageAlignment 消息内容的对齐方式
 @param actionNames 底部按钮名字列表
 @param onTouchedActionButtons 底部按钮点击回调
 @return MMAlertView实例
 */
+ (instancetype)showWhiteStypeAlert:(nullable NSString *)title
                            message:(NSString *)message
                   messageAlignment:(NSTextAlignment)messageAlignment
                        actionNames:(NSArray *)actionNames
             onTouchedActionButtons:(void (^)(MMAlertView *alertView, NSUInteger buttonIndex))onTouchedActionButtons;

#pragma mark - 列表选择样式的弹框

/**
 列表选择样式的弹框

 @param title 标题
 @param listNameArray 选择列表内容数组
 @param onTableRowSelected 选择列表点击后的回调，点击后alert自动消失
 @return MMAlertView实例
 */
+ (instancetype)showSelectionList:(nullable NSString *)title
            listNameArray:(NSArray *)listNameArray
       onTableRowSelected:(void (^)(MMAlertView *alertView, NSUInteger selectedIndex))onTableRowSelected;

#pragma mark - 自定义内容视图的弹框

/**
 自定义内容视图的弹框

 @param contentView 自定义的内容视图
 @param title 标题
 @param actionNames 底部按钮名字列表
 @param onTouchedActionButtons 底部按钮点击回调
 @return MMAlertView实例
 */
+ (instancetype)showContentView:(nullable UIView *)contentView
                          title:(NSString *)title
                    actionNames:(NSArray *)actionNames
         onTouchedActionButtons:(void (^)(MMAlertView *alertView, NSUInteger buttonIndex))onTouchedActionButtons;

@end

NS_ASSUME_NONNULL_END
