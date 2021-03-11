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
    self.layer.cornerRadius = 20;
    self.clipsToBounds = YES;
    gradLayer.frame = self.layer.bounds;
    
    gradLayer.colors = [NSArray arrayWithObjects:
                        (id)startColor.CGColor,
                        (id)endColor.CGColor,
                        nil];
    
    gradLayer.startPoint = CGPointMake(0, 0);
    gradLayer.endPoint = CGPointMake(1, 0);
    [self.layer addSublayer:gradLayer];
    
    [self setLabel];
    [self setImage];
}

- (void)setLabel {
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(48, 9, 96, 22)];
    title.text = @"加好友";
    title.textColor = [UIColor whiteColor];
    title.textAlignment = NSTextAlignmentCenter;
    [self addSubview:title];
}

- (void)setImage {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(159, 9, 24, 24)];
    imageView.image = [UIImage imageNamed:@"icAddFriendWhite"];
    [self addSubview:imageView];

}

@end
