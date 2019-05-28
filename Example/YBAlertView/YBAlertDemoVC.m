//
//  YBAlertDemoVC.m
//  ybAlertView
//
//  Created by yibin on 2019/3/7.
//  Copyright (c) 2019 liuyibin. All rights reserved.
//

#import "YBAlertDemoVC.h"

#import <YBAlertView/YBAlertView.h>
#import <YBAlertView/YBAlertView+Show.h>

@interface YBAlertDemoVC ()

@end

@implementation YBAlertDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (IBAction)ensureAlert:(id)sender {
    [YBAlertView showReminder:nil message:@"lalala" onTouchedActionButtons:^(YBAlertView * _Nonnull alertView) {
        
    }];
}

- (IBAction)buttonsAlert:(id)sender {
    [YBAlertView showActionsAlert:@"这是一个动作选择alert"
                          message:@"laallalalaaldsf讽德诵功讽德诵功讽德诵功讽德诵功讽德诵功讽德诵功讽德诵功讽德诵功讽德诵功讽德诵功讽德诵功讽德诵功讽德诵功讽德诵功讽德诵功讽德诵功"
                      actionNames:@[@"等一下", @"马上吃饭", @"断食"]
           onTouchedActionButtons:^(YBAlertView *alertView, NSUInteger buttonIndex) {
        
    }];
}

- (IBAction)listAlert:(id)sender {
    [YBAlertView showSelectionList:@"选择"
                     listNameArray:@[@"张三", @"王五", @"李磊",@"张三", @"王五", @"李磊",@"张三", @"王五", @"李磊",@"张三", @"王五", @"李磊",@"张三", @"王五", @"李磊",@"张三", @"王五", @"李磊",@"张三", @"王五", @"李磊",@"张三", @"王五", @"李磊",@"张三", @"王五", @"李磊",@"张三", @"王五", @"李磊",@"张三", @"王五", @"李磊",]
                onTableRowSelected:^(YBAlertView *alertView, NSUInteger selectedIndex) {
                    NSLog(@"alert selectedIndex::%lud", (unsigned long)selectedIndex);
                }];
}

- (IBAction)whiteAlert:(id)sender {
    
    [YBAlertView showWhiteStypeAlert:nil
                             message:@"您已经被别人搞下线了"
                         actionNames:@[@"重新登录"]
              onTouchedActionButtons:^(YBAlertView *alertView, NSUInteger buttonIndex) {
        
    }];
}


@end
