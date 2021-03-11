//
//  CustomSegmentedControl.m
//  KokoDemo
//
//  Created by Alex Zhang on 2021/3/10.
//  Copyright © 2021 Alex Zhang. All rights reserved.
//

#import "CustomSegmentedControl.h"

@implementation CustomSegmentedControl


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [self setup];
    
}


- (void)setup {
    [self setSelectedSegmentIndex:0];
    [self setSegmentedControl];
    

}
- (void)setSegmentedControl
{
    [self setDividerImage:[self underlineImageNormal] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self setDividerImage:[self underlineImageNormal] forLeftSegmentState:UIControlStateSelected rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self setDividerImage:[self underlineImageNormal] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    [self setBackgroundImage:[self underlineImageNormal] forState:UIControlStateNormal
                  barMetrics:UIBarMetricsDefault];
    [self setBackgroundImage:[self underlineImageSelected] forState:UIControlStateSelected
                  barMetrics:UIBarMetricsDefault];
    
}

- (UIImage *)underlineImageNormal
{
    return [self underlineImageForState:UIControlStateNormal];
}

- (UIImage *)underlineImageSelected
{
    return [self underlineImageForState:UIControlStateSelected];
}

- (UIImage *)underlineImageForState:(UIControlState)state
{
    UIColor *color = [UIColor clearColor];

    if (state == UIControlStateSelected) {
        color = [Utilitie getKoKoMainColor];
    }
    
    UIGraphicsBeginImageContext(CGSizeMake(10, 44));
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    
    CGFloat underlineWidth = 2;
    CGFloat yPosi = 44 - underlineWidth;
    CGContextMoveToPoint(context, 0, yPosi);
    CGContextAddLineToPoint(context, 10, yPosi);
    
    CGContextSetLineWidth(context, underlineWidth);
    CGContextClosePath(context);
    
    CGContextDrawPath(context, kCGPathStroke);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(3, image.size.width*.5f-1, 3, image.size.width*.5f-1) resizingMode:UIImageResizingModeStretch];
    NSLog(@"image size = %@",NSStringFromCGSize(image.size));
    return image;
}

@end
