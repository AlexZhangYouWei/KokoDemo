//
//  AMEMainControlMode.h
//  ToolforOC
//
//  Created by Alex on 2020/8/14.
//  Copyright © 2020 AlexSample.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AMEMainMenu.h"


@interface AMEMainControlMode : NSObject<AMEMainMenuDelegate>


- (void)initialize;

- (NSArray *)getMenuItems;

@end

