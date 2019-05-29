//
//  MMViewController.m
//  MMAlertView
//
//  Created by 386026448@qq.com on 05/29/2019.
//  Copyright (c) 2019 386026448@qq.com. All rights reserved.
//

#import "MMViewController.h"

#import "MMAlertDemoVC.h"

@interface MMViewController ()

@end

@implementation MMViewController

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

- (IBAction)demoButtonTouched:(id)sender {
    MMAlertDemoVC *vc = [[MMAlertDemoVC alloc] initWithNibName:@"MMAlertDemoVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
