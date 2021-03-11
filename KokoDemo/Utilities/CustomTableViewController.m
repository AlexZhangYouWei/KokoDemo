//
//  CustomTableViewController.m
//  KokoDemo
//
//  Created by Alex on 2021/3/10.
//  Copyright © 2021 Alex Zhang. All rights reserved.
//

#import "CustomTableViewController.h"
#import "MainViewController.h"
@interface CustomTableViewController ()

@end

@implementation CustomTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
#pragma mark - Setup

- (void)setupSelf {
    self.tabBar.backgroundImage = [UIImage imageNamed:@"imgTabbarBg"];
    
    MainViewController *mainVC = [[MainViewController alloc]init];
    [self setupChildViewController:mainVC title:@"" image:@"icTabbarProductsOff" selectedImage:@"icTabbarProductsOff"];
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

-(void)setupChildViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString*) selectedImage{
    
    //    vc.navigationItem.title = title;
    
    //    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : RGB(255, 0,79)} forState:UIControlStateNormal];
    
    //[vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : RGB(255, 0,79)} forState:UIControlStateSelected];
    
//    vc.tabBarItem.title = title;
    
    vc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    ////    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    //
    //MyNavViewController *nav = [[MyNavViewController alloc]initWithRootViewController:vc];
    //
    //[self addChildViewController:nav];
    
}



@end
