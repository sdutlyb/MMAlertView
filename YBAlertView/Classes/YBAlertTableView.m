//
//  YBAlertTableView.m
//  ybAlertView
//
//  Created by yibin on 2019/3/7.
//  Copyright (c) 2019 liuyibin. All rights reserved.
//

#import "YBAlertTableView.h"

@implementation YBAlertTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        _dataSourceArray = [NSArray array];
        self.delegate = self;
        self.dataSource = self;
        
        self.rowHeight = kYBAlertViewTableCellHeight;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.estimatedRowHeight = 40;
    }
    return self;
}

#pragma mark - TableView Delegate & DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"YBAlertTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.bounds.size.width, 20)];
        titleLabel.textColor = [UIColor darkGrayColor];
        titleLabel.font = [UIFont systemFontOfSize:16];
        titleLabel.tag = 550;
        [cell.contentView addSubview:titleLabel];
    }
    
    UILabel *titleLabel = [cell.contentView viewWithTag:550];
    titleLabel.text = [_dataSourceArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (_onTouchedTableRow) {
        _onTouchedTableRow(indexPath.row);
    }
}

@end
