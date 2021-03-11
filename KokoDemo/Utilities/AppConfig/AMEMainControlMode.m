//
//  AMEMainControlMode.m
//  ToolforOC
//
//  Created by Alex on 2020/8/14.
//  Copyright © 2020 AlexSample.com. All rights reserved.
//

#import "AMEMainControlMode.h"
@implementation AMEMainControlMode

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


- (void)initialize
{
    
}

#pragma mark - Fake Data
- (NSArray *)getMenuItems
{
    AMEMainMenuItem *homeItem = [AMEMainMenuItem new];
    //homeItem.title = @"Home";
    homeItem.isPrimary = NO;
    homeItem.textColor = [UIColor whiteColor];
    homeItem.img = [UIImage imageNamed:@"icTabbarProductsOff"];
    
    AMEMainMenuItem *homeItem1 = [AMEMainMenuItem new];
    homeItem1.title = @"Home1";
    homeItem1.isPrimary = NO;
    homeItem1.textColor = [UIColor whiteColor];

    
    AMEMainMenuItem *homeItem2 = [AMEMainMenuItem new];
    homeItem2.title = @"Home2";
    homeItem2.isPrimary = YES;
    homeItem2.textColor = [UIColor whiteColor];
    
    AMEMainMenuItem *homeItem3 = [AMEMainMenuItem new];
    homeItem3.title = @"Home3";
    homeItem3.isPrimary = NO;
    homeItem3.textColor = [UIColor whiteColor];
    
    AMEMainMenuItem *homeItem4 = [AMEMainMenuItem new];
    homeItem4.title = @"Home4";
    homeItem4.isPrimary = NO;
    homeItem4.textColor = [UIColor whiteColor];
    
    
    
    return @[homeItem, homeItem1, homeItem2, homeItem3, homeItem4];
    
    
}

- (void)clickMainMenuItem:(id)sender {
    
}

@end
