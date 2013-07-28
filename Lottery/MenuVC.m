//
//  MenuVC.m
//  Lottery
//
//  Created by 刘 晓霞 on 13-7-24.
//  Copyright (c) 2013年 Lxx. All rights reserved.
//

#import "MenuVC.h"
#import "MachineVC.h"
#import "HelpVC.h"
#import "NumberVC.h"

@interface MenuVC ()

@end

@implementation MenuVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)machineNumberPressed:(id)sender {
    MachineVC *machineVC = [[MachineVC alloc] initWithNibName:@"MachineVC" bundle:nil];
    [self.navigationController pushViewController:machineVC animated:YES];
    
    // 导航条左边"返回"button
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] init];
    [backButton setTitle:@"返回"];
    self.navigationItem.backBarButtonItem = backButton;
}

- (IBAction)luckyNumberPressed:(id)sender {
    NumberVC *numberVC = [[NumberVC alloc] initWithNibName:@"NumberVC" bundle:nil];
    [self.navigationController pushViewController:numberVC animated:YES];
    
    // 导航条左边"返回"button
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] init];
    [backButton setTitle:@"返回"];
    self.navigationItem.backBarButtonItem = backButton;
}

- (IBAction)helpPressed:(id)sender {
    HelpVC *helpVC = [[HelpVC alloc] initWithNibName:@"HelpVC" bundle:nil];
    [self.navigationController pushViewController:helpVC animated:YES];
    
    // 导航条左边"返回"button
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] init];
    [backButton setTitle:@"返回"];
    self.navigationItem.backBarButtonItem = backButton;
}
@end
