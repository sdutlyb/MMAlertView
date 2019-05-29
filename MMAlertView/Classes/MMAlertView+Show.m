//
//  MMAlertView+Show.m
//  MMAlertView
//
//  Created by yibin on 2019/3/28.
//  Copyright (c) 2019 liuyibin. All rights reserved.
//

#import "MMAlertView+Show.h"

#import "MMAlertTableView.h"

#define k_MinMessageLabelHeight 50

@implementation MMAlertView (Show)

#pragma mark - Method For Alert Show

+ (instancetype)showReminder:(nullable NSString *)title
                     message:(NSString *)message
      onTouchedActionButtons:(void (^)(MMAlertView *alertView))onTouchedActionButtons {
    return [self showReminder:title
                      message:message
             messageAlignment:NSTextAlignmentCenter
       onTouchedActionButtons:onTouchedActionButtons];
}

+ (instancetype)showReminder:(nullable NSString *)title
                     message:(NSString *)message
            messageAlignment:(NSTextAlignment)messageAlignment
      onTouchedActionButtons:(void (^)(MMAlertView *alertView))onTouchedActionButtons {
    
    MMAlertView *alertView = [[MMAlertView alloc] init];
    [alertView setOnButtonTouchUpInside:^(MMAlertView *alertView, NSUInteger buttonIndex) {
        if (onTouchedActionButtons) {
            onTouchedActionButtons(alertView);
        }
        [alertView close];
    }];
    alertView.title = title;
    alertView.bodyMarginVertical = 28;
    
    CGFloat labelWidth = alertView.contentViewWidth;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, labelWidth, 50)];
    label.font = [MMAlertViewConfig sharedConfig].messageTextFont;
    label.textColor = [MMAlertViewConfig sharedConfig].messageTextColor;
    label.numberOfLines = 0;
    label.textAlignment = messageAlignment;
    label.text = message;
    CGSize labelSize = [self sizeWithString:message font:label.font size:CGSizeMake(labelWidth, CGFLOAT_MAX)];
    label.frame = CGRectMake(0, 0, labelWidth, labelSize.height);
    alertView.contentView = label;
    [alertView show];
    return alertView;
}

+ (instancetype)showActionsAlert:(nullable NSString *)title
                 message:(NSString *)message
             actionNames:(NSArray *)actionNames
  onTouchedActionButtons:(void (^)(MMAlertView *alertView, NSUInteger buttonIndex))onTouchedActionButtons {
    return [self showActionsAlert:title
                          message:message
                 messageAlignment:NSTextAlignmentCenter
                      actionNames:actionNames
           onTouchedActionButtons:onTouchedActionButtons];
}

+ (instancetype)showActionsAlert:(nullable NSString *)title
                         message:(NSString *)message
                messageAlignment:(NSTextAlignment)messageAlignment
                     actionNames:(NSArray *)actionNames
          onTouchedActionButtons:(void (^)(MMAlertView *alertView, NSUInteger buttonIndex))onTouchedActionButtons {
    
    MMAlertView *alertView = [[MMAlertView alloc] init];
    [alertView setOnButtonTouchUpInside:^(MMAlertView *alertView, NSUInteger buttonIndex) {
        if (onTouchedActionButtons) {
            onTouchedActionButtons(alertView, buttonIndex);
        }
        [alertView close];
    }];
    alertView.title = title;
    alertView.buttonTitles = actionNames;
    alertView.bodyMarginVertical = 28;
    
    CGFloat labelWidth = alertView.contentViewWidth;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, labelWidth, 50)];
    label.font = [MMAlertViewConfig sharedConfig].messageTextFont;
    label.textColor = [MMAlertViewConfig sharedConfig].messageTextColor;
    label.numberOfLines = 0;
    label.textAlignment = messageAlignment;
    label.text = message;
    CGSize labelSize = [self sizeWithString:message font:label.font size:CGSizeMake(labelWidth, CGFLOAT_MAX)];
    label.frame = CGRectMake(0, 0, labelWidth, labelSize.height);
    alertView.contentView = label;
    [alertView show];
    return alertView;
}

+ (instancetype)showWhiteStypeAlert:(nullable NSString *)title
                    message:(NSString *)message
                actionNames:(NSArray *)actionNames
     onTouchedActionButtons:(void (^)(MMAlertView *alertView, NSUInteger buttonIndex))onTouchedActionButtons {
    return [self showWhiteStypeAlert:title
                             message:message
                    messageAlignment:NSTextAlignmentCenter
                         actionNames:actionNames
              onTouchedActionButtons:onTouchedActionButtons];
}

+ (instancetype)showWhiteStypeAlert:(nullable NSString *)title
                            message:(NSString *)message
                   messageAlignment:(NSTextAlignment)messageAlignment
                        actionNames:(NSArray *)actionNames
             onTouchedActionButtons:(void (^)(MMAlertView *alertView, NSUInteger buttonIndex))onTouchedActionButtons {
    
    MMAlertView *alertView = [[MMAlertView alloc] init];
    [alertView setOnButtonTouchUpInside:^(MMAlertView *alertView, NSUInteger buttonIndex) {
        if (onTouchedActionButtons) {
            onTouchedActionButtons(alertView, buttonIndex);
        }
        [alertView close];
    }];
    alertView.title = title;
    alertView.buttonTitles = actionNames;
    alertView.titleBarStyle = YBAlertTitleBarStyleGray;
    alertView.titleTextFont = [UIFont systemFontOfSize:18.f];
    alertView.bodyMarginVertical = 28;
    
    CGFloat labelWidth = alertView.contentViewWidth;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, labelWidth, 50)];
    label.font = [MMAlertViewConfig sharedConfig].messageTextFont;
    label.textColor = [MMAlertViewConfig sharedConfig].messageTextColor;
    label.numberOfLines = 0;
    label.textAlignment = messageAlignment;
    label.text = message;
    CGSize labelSize = [self sizeWithString:message font:label.font size:CGSizeMake(labelWidth, CGFLOAT_MAX)];
    label.frame = CGRectMake(0, 0, labelWidth, labelSize.height);
    alertView.contentView = label;
    [alertView show];
    return alertView;
}

+ (instancetype)showSelectionList:(nullable NSString *)title
            listNameArray:(NSArray *)listNameArray
       onTableRowSelected:(void (^)(MMAlertView *alertView, NSUInteger selectedIndex))onTableRowSelected {
    
    MMAlertView *alertView = [[MMAlertView alloc] init];
    [alertView setOnButtonTouchUpInside:^(MMAlertView *alertView, NSUInteger buttonIndex) {
        [alertView close];
    }];
    alertView.closeOnTouchUpOutside = YES;
    alertView.buttonTitles = nil;
    alertView.title = title;
    
    CGFloat tableViewHeight = kMMAlertViewTableCellHeight * listNameArray.count;
    if (tableViewHeight > [UIScreen mainScreen].bounds.size.height * 0.65) {
        tableViewHeight = [UIScreen mainScreen].bounds.size.height * 0.65;
    }
    MMAlertTableView *tableView = [[MMAlertTableView alloc] initWithFrame:CGRectMake(0, 0, alertView.contentViewWidth, tableViewHeight) style:UITableViewStylePlain];
    tableView.dataSourceArray = listNameArray;
    tableView.onTouchedTableRow = ^(NSUInteger rowIndex) {
        if (onTableRowSelected) {
            onTableRowSelected(alertView, rowIndex);
        }
        [alertView close];
    };
    alertView.contentView = tableView;
    [alertView show];
    return alertView;
}

+ (instancetype)showContentView:(nullable UIView *)contentView
                          title:(NSString *)title
                    actionNames:(NSArray *)actionNames
         onTouchedActionButtons:(void (^)(MMAlertView *alertView, NSUInteger buttonIndex))onTouchedActionButtons {
    MMAlertView *alertView = [[MMAlertView alloc] init];
    [alertView setOnButtonTouchUpInside:^(MMAlertView *alertView, NSUInteger buttonIndex) {
        [alertView close];
    }];
    alertView.title = title;
    alertView.buttonTitles = actionNames;
    CGFloat contentViewScale = CGRectGetHeight(contentView.frame) / CGRectGetWidth(contentView.frame);
    CGFloat contentShowHeight = alertView.contentViewWidth * contentViewScale;
    CGRect contentRect = contentView.frame;
    contentRect.size.height = contentShowHeight;
    alertView.contentView = contentView;
    [alertView show];
    return alertView;
}

#pragma mark - Utils

+ (CGSize)sizeWithString:(nullable NSString *)string font:(UIFont *)font size:(CGSize)size {
    CGRect rect = [string boundingRectWithSize:size
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin
                                    attributes:@{NSFontAttributeName: font}
                                       context:nil];
    
    return rect.size;
}

@end
