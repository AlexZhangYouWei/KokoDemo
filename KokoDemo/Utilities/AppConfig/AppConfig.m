//
//  AppConfig.m
//  ToolforOC
//
//  Created by Alex on 2020/8/12.
//  Copyright © 2020 AlexSample.com. All rights reserved.
//

#import "AppConfig.h"


@implementation AppConfig


+ (AppConfig *)sharedAppConfig
{
    static dispatch_once_t one;
    static AppConfig * sharedAppConfig;
    
    dispatch_once(&one, ^{
        sharedAppConfig = [[AppConfig alloc] init];
        [sharedAppConfig initialize];

    });
    return sharedAppConfig;
}



- (void)initialize
{
    [self getMainControlMode];
}

- (AMEMainControlMode *)getMainControlMode
{
    _mainControlMode = [[AMEMainControlMode alloc]init];
    [_mainControlMode initialize];
    
    return _mainControlMode;
}



@end
