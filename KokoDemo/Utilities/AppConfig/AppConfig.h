//
//  AppConfig.h
//  ToolforOC
//
//  Created by Alex on 2020/8/12.
//  Copyright © 2020 AlexSample.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AMEMainControlMode.h"

@interface AppConfig : NSObject
@property (nonatomic, strong) AMEMainControlMode *mainControlMode;

+ (AppConfig *)sharedAppConfig;

@end

