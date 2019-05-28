//
//  YBViewController.m
//  YBAlertView
//
//  Created by liuyibin on 05/28/2019.
//  Copyright (c) 2019 liuyibin. All rights reserved.
//

#import "YBViewController.h"

#import "YBAlertDemoVC.h"

@interface YBViewController ()

@end

@implementation YBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)demePageButtonTouched:(id)sender {
    YBAlertDemoVC *vc = [[YBAlertDemoVC alloc] initWithNibName:@"YBAlertDemoVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
