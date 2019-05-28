//
//  YBAlertView+Show.m
//  ybAlertView
//
//  Created by yibin on 2019/3/28.
//  Copyright (c) 2019 liuyibin. All rights reserved.
//

#import "YBAlertView+Show.h"

#import "YBAlertTableView.h"

#define k_MinMessageLabelHeight 50

@implementation YBAlertView (Show)

#pragma mark - Method For Alert Show

+ (instancetype)showReminder:(nullable NSString *)title
                     message:(NSString *)message
      onTouchedActionButtons:(void (^)(YBAlertView *alertView))onTouchedActionButtons {
    return [self showReminder:title
                      message:message
             messageAlignment:NSTextAlignmentCenter
       onTouchedActionButtons:onTouchedActionButtons];
}

+ (instancetype)showReminder:(nullable NSString *)title
                     message:(NSString *)message
            messageAlignment:(NSTextAlignment)messageAlignment
      onTouchedActionButtons:(void (^)(YBAlertView *alertView))onTouchedActionButtons {
    
    YBAlertView *alertView = [[YBAlertView alloc] init];
    [alertView setOnButtonTouchUpInside:^(YBAlertView *alertView, NSUInteger buttonIndex) {
        if (onTouchedActionButtons) {
            onTouchedActionButtons(alertView);
        }
        [alertView close];
    }];
    alertView.title = title;
    alertView.bodyMarginVertical = 28;
    
    CGFloat labelWidth = alertView.contentViewWidth;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, labelWidth, 50)];
    label.font = [YBAlertViewConfig sharedConfig].messageTextFont;
    label.textColor = [YBAlertViewConfig sharedConfig].messageTextColor;
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
  onTouchedActionButtons:(void (^)(YBAlertView *alertView, NSUInteger buttonIndex))onTouchedActionButtons {
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
          onTouchedActionButtons:(void (^)(YBAlertView *alertView, NSUInteger buttonIndex))onTouchedActionButtons {
    
    YBAlertView *alertView = [[YBAlertView alloc] init];
    [alertView setOnButtonTouchUpInside:^(YBAlertView *alertView, NSUInteger buttonIndex) {
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
    label.font = [YBAlertViewConfig sharedConfig].messageTextFont;
    label.textColor = [YBAlertViewConfig sharedConfig].messageTextColor;
    label.numberOfLines = 0;
    label.textAlignment = messageAlignment;
    label.text = message;
    CGSize labelSize = [self sizeWithString:message font:label.font size:CGSizeMake(labelWidth, CGFLOAT_MAX)];
    if (labelSize.height < k_MinMessageLabelHeight) {
        labelSize.height = k_MinMessageLabelHeight;
    }
    label.frame = CGRectMake(0, 0, labelWidth, labelSize.height);
    alertView.contentView = label;
    [alertView show];
    return alertView;
}

+ (instancetype)showWhiteStypeAlert:(nullable NSString *)title
                    message:(NSString *)message
                actionNames:(NSArray *)actionNames
     onTouchedActionButtons:(void (^)(YBAlertView *alertView, NSUInteger buttonIndex))onTouchedActionButtons {
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
             onTouchedActionButtons:(void (^)(YBAlertView *alertView, NSUInteger buttonIndex))onTouchedActionButtons {
    
    YBAlertView *alertView = [[YBAlertView alloc] init];
    [alertView setOnButtonTouchUpInside:^(YBAlertView *alertView, NSUInteger buttonIndex) {
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
    label.font = [YBAlertViewConfig sharedConfig].messageTextFont;
    label.textColor = [YBAlertViewConfig sharedConfig].messageTextColor;
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
       onTableRowSelected:(void (^)(YBAlertView *alertView, NSUInteger selectedIndex))onTableRowSelected {
    
    YBAlertView *alertView = [[YBAlertView alloc] init];
    [alertView setOnButtonTouchUpInside:^(YBAlertView *alertView, NSUInteger buttonIndex) {
        [alertView close];
    }];
    alertView.closeOnTouchUpOutside = YES;
    alertView.buttonTitles = nil;
    alertView.title = title;
    
    CGFloat tableViewHeight = kYBAlertViewTableCellHeight * listNameArray.count;
    if (tableViewHeight > [UIScreen mainScreen].bounds.size.height * 0.65) {
        tableViewHeight = [UIScreen mainScreen].bounds.size.height * 0.65;
    }
    YBAlertTableView *tableView = [[YBAlertTableView alloc] initWithFrame:CGRectMake(0, 0, alertView.contentViewWidth, tableViewHeight) style:UITableViewStylePlain];
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
         onTouchedActionButtons:(void (^)(YBAlertView *alertView, NSUInteger buttonIndex))onTouchedActionButtons {
    YBAlertView *alertView = [[YBAlertView alloc] init];
    [alertView setOnButtonTouchUpInside:^(YBAlertView *alertView, NSUInteger buttonIndex) {
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
