//
//  YBAlertDemoVC.m
//  MMAlertView
//
//  Created by yibin on 2019/3/7.
//  Copyright (c) 2019 liuyibin. All rights reserved.
//

#import "MMAlertDemoVC.h"

#import <MMAlertView/MMAlertView.h>
#import <MMAlertView/MMAlertView+Show.h>

@interface MMAlertDemoVC ()

@end

@implementation MMAlertDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (IBAction)ensureAlert:(id)sender {
    [MMAlertView showReminder:nil
                      message:@"lalala"
       onTouchedActionButtons:^(MMAlertView * _Nonnull alertView) {
        
    }];
}

- (IBAction)buttonsAlert:(id)sender {
    [MMAlertView showActionsAlert:@"这是一个动作选择alert"
                          message:@"laallalalaaldsf讽德诵功讽德诵功讽德诵功讽德诵功讽德诵功讽德诵功讽德诵功讽德诵功讽德诵功讽德诵功讽德诵功讽德诵功讽德诵功讽德诵功讽德诵功讽德诵功"
                      actionNames:@[@"等一下", @"马上吃饭", @"断食"]
           onTouchedActionButtons:^(MMAlertView *alertView, NSUInteger buttonIndex) {
        
    }];
}

- (IBAction)listAlert:(id)sender {
    [MMAlertView showSelectionList:@"选择"
                     listNameArray:@[@"张三", @"王五", @"李磊",@"张三", @"王五", @"李磊",@"张三", @"王五", @"李磊",@"张三", @"王五", @"李磊",@"张三", @"王五", @"李磊",@"张三", @"王五", @"李磊",@"张三", @"王五", @"李磊",@"张三", @"王五", @"李磊",@"张三", @"王五", @"李磊",@"张三", @"王五", @"李磊",@"张三", @"王五", @"李磊",]
                onTableRowSelected:^(MMAlertView *alertView, NSUInteger selectedIndex) {
                    NSLog(@"alert selectedIndex::%lud", (unsigned long)selectedIndex);
                }];
}

- (IBAction)whiteAlert:(id)sender {
    
    [MMAlertView showWhiteStypeAlert:nil
                             message:@"您已经下线了"
                         actionNames:@[@"重新登录"]
              onTouchedActionButtons:^(MMAlertView *alertView, NSUInteger buttonIndex) {
        
    }];
}


@end
