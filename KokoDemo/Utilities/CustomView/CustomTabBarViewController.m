//
//  CustomTabBarViewController.m
//  KokoDemo
//
//  Created by Alex on 2021/3/10.
//  Copyright © 2021 Alex Zhang. All rights reserved.
//

#import "CustomTabBarViewController.h"
#import "MainViewController.h"
@interface CustomTabBarViewController ()

@end

@implementation CustomTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSelectedIndex:1];
    [self setupSelf];
    // Do any additional setup after loading the view.
}

- (void)setupSelf {
    self.tabBar.backgroundImage = [UIImage imageNamed:@"imgTabbarBg"];
}




@end
