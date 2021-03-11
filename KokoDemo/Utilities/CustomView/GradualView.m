//
//  GradualView.m
//  KokoDemo
//
//  Created by Alex Zhang on 2021/3/10.
//  Copyright © 2021 Alex Zhang. All rights reserved.
//

#import "GradualView.h"

@interface GradualView()
{
    
}

@end

@implementation GradualView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self setup];
    
}

- (void)setup {
    
    UIColor *startColor = [UIColor colorWithRed:86/255.0f green:179/255.0f blue:11/255.0f alpha:1.0f];
    UIColor *endColor = [UIColor colorWithRed:166/255.0f green:204/255.0f blue:66/255.0f alpha:1.0f];
    
    CAGradientLayer * gradLayer = [CAGradientLayer layer];
    
    
    gradLayer.frame = self.layer.bounds;
    
    gradLayer.colors = [NSArray arrayWithObjects:
                        (id)startColor.CGColor,
                        (id)endColor.CGColor,
                        nil];
    
    gradLayer.startPoint = CGPointMake(0, 0);
    gradLayer.endPoint = CGPointMake(1, 0);
    [self.layer addSublayer:gradLayer];
    
    
}
@end
