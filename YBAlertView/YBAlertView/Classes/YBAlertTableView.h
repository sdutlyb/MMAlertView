//
//  YBAlertTableView.h
//  ybAlertView
//
//  Created by yibin on 2019/3/7.
//  Copyright (c) 2019 liuyibin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

const static CGFloat kYBAlertViewTableCellHeight = 40;

@interface YBAlertTableView : UITableView <UITableViewDelegate, UITableViewDataSource>

@property(strong, nonatomic) NSArray *dataSourceArray;

@property (copy) void (^onTouchedTableRow)(NSUInteger rowIndex);

@end

NS_ASSUME_NONNULL_END
