//
//  AppConfig.m
//  KokoDemo
//
//  Created by Alex on 2021/3/11.
//  Copyright © 2021 Alex Zhang. All rights reserved.
//

#import "AppConfig.h"

@implementation AppConfig

+ (instancetype) sharedInstance
{
    static AppConfig *instance = nil;
    if (!instance) {
        instance = [[AppConfig alloc] init];
    }
    return instance;
}



@end
