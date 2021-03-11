//
//  CustomLabel.m
//  KokoDemo
//
//  Created by Alex Zhang on 2021/3/10.
//  Copyright © 2021 Alex Zhang. All rights reserved.
//

#import "CustomLabel.h"

@implementation CustomLabel


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self setup];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}


- (void)setup {
    
    self.textColor = [UIColor colorWithRed:71/255.0f green:71/255.0f blue:71/255.0f alpha:1.0];
    self.font = [UIFont fontWithName:@"PingFangTC-Regular" size:16];
}

@end
