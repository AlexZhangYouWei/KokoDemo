//
//  CustomTabBarViewController.m
//  KokoDemo
//
//  Created by Alex on 2021/3/10.
//  Copyright © 2021 Alex Zhang. All rights reserved.
//

#import "CustomTabBarViewController.h"
#import "MainViewController.h"
#import "CustomTabBar.h"
const CGFloat kBarHeight = 68;

@interface CustomTabBarViewController ()

@end

@implementation CustomTabBarViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:YES];

    [self setupSelf];
    // Do any additional setup after loading the view.
}

- (void)setupSelf {
    [self setSelectedIndex:1];
    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"imgTabbarBg"]];
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    [self setCustomtabbar];
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
 
}

- (void)setCustomtabbar{

    CustomTabBar *tabbar = [[CustomTabBar alloc]init];
    [self setValue:tabbar forKeyPath:@"tabBar"];
    CGRect mainFrame = self.view.frame;
    mainFrame.size.height = kBarHeight;
    mainFrame.origin.y = self.view.frame.size.height - kBarHeight;
    tabbar.frame = mainFrame;
    
    //[tabbar.centerBtn addTarget:self action:@selector(centerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)centerBtnClick:(UIButton *)btn{
    NSLog(@"Click Cemter BTN");
    
}


- (void)addChildController:(UIViewController*)childController title:(NSString*)title imageName:(NSString*)imageName selectedImageName:(NSString*)selectedImageName navVc:(Class)navVc
{
    
    childController.title = title;
    childController.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 设置一下选中tabbar文字颜色
    
    [childController.tabBarItem setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor darkGrayColor] }forState:UIControlStateSelected];
    
    UINavigationController* nav = [[navVc alloc] initWithRootViewController:childController];
    
    [self addChildViewController:nav];
}


- (UIImage *)imageWithColor:(UIColor *)color{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
