//
//  StartViewController.m
//  KokoDemo
//
//  Created by Alex on 2021/3/11.
//  Copyright © 2021 Alex Zhang. All rights reserved.
//

#import "StartViewController.h"
#import "AppConfig.h"
@interface StartViewController ()
{
    AppConfig *appConfig;
}

@end

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    appConfig = [AppConfig sharedInstance];
    // Do any additional setup after loading the view.
}
- (IBAction)ActionDemo:(id)sender {
    NSInteger i = [sender tag];
    appConfig.startModel = i;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"mySegueIdentifier"];
    
    [self.navigationController pushViewController:controller animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
