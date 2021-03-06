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
    [self insertSegmentWithTitle:@"好友" atIndex:0 animated:YES];
    [self insertSegmentWithTitle:@"聊天" atIndex:1 animated:YES];
    [self setSelectedSegmentIndex:0];
    [self setBadgeNumber:2 forSegmentAtIndex:0];
    [self setBadgeNumber:99 forSegmentAtIndex:1];

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
    return image;
}

- (void)setBadgeNumber:(NSUInteger)badgeNumber forSegmentAtIndex:(NSUInteger)segmentIndex usingBlock:(void(^)(CustomBadge *))configureBadge
{
    // If this is the first time a badge number has been set, then initialise the badges
    if (_segmentBadgeNumbers.count == 0)
    {
        //initialise the badge arrays
        _segmentBadgeNumbers = [NSMutableArray arrayWithCapacity:self.numberOfSegments];
        _segmentBadges = [NSMutableArray arrayWithCapacity:self.numberOfSegments];
        for (int index = 0; index < self.numberOfSegments; index++)
        {
            [_segmentBadgeNumbers addObject:[NSNumber numberWithInt:0]];
            [_segmentBadges addObject:[NSNull null]];
        }
        
        // Create a transparent view to go on top of the segmented control and to hold the badges. (This transparent view is added to the superview to work around strange UISegmentedControl behaviour which causes its own subviews to be obscured when certain segments are selected. It's important then that the MESegmentedControl is placed on top of a suitable view and not directly onto a UINavigationItem.)
        _badgeView = [[UIView alloc] initWithFrame:self.frame];
        [_badgeView setBackgroundColor:[UIColor clearColor]];
        _badgeView.userInteractionEnabled = NO;
        [self.superview addSubview:_badgeView];
    }
    
    // Recall the old badge number and store the new badge number
    int oldBadgeNumber = ((NSNumber *)[_segmentBadgeNumbers objectAtIndex:segmentIndex]).intValue;
    [_segmentBadgeNumbers replaceObjectAtIndex:segmentIndex withObject:[NSNumber numberWithUnsignedInteger:badgeNumber]];
    
    // Modify the badge view
    if ((oldBadgeNumber == 0) && (badgeNumber > 0))
    {
        // Add a badge, positioned on the upper right side of the requested segment
        // (Assumes that all segments are the same size - if segments are of different sizes, modify the below to use the widthForSegmentAtIndex method on UISegmentedControl)
        CustomBadge *customBadge = [CustomBadge customBadgeWithString:[NSString stringWithFormat:@"%lu", (unsigned long)badgeNumber]];
        [customBadge setFrame:CGRectMake(((self.frame.size.width/self.numberOfSegments) * (segmentIndex + 1))-customBadge.frame.size.width +5, -5, customBadge.frame.size.width, customBadge.frame.size.height)];
        [_segmentBadges replaceObjectAtIndex:segmentIndex withObject:customBadge];
        [_badgeView addSubview:customBadge];
    }
    else if ((oldBadgeNumber > 0) && (badgeNumber == 0))
    {
        // Remove the badge
        [[_segmentBadges objectAtIndex:segmentIndex] removeFromSuperview];
        [_segmentBadges replaceObjectAtIndex:segmentIndex withObject:[NSNull null]];
    }
    else if ((oldBadgeNumber != badgeNumber) && (badgeNumber > 0))
    {
        // Update the number on the existing badge
        [[_segmentBadges objectAtIndex:segmentIndex] autoBadgeSizeWithString:[NSString stringWithFormat:@"%lu", (unsigned long)badgeNumber]];
    }
    
    // Yield to the block for any custom setup to be done on the badge
    if (badgeNumber > 0)
    {
        configureBadge([_segmentBadges objectAtIndex:segmentIndex]);
    }
}

- (void)setBadgeNumber:(NSUInteger)badgeNumber forSegmentAtIndex:(NSUInteger)segmentIndex
{
    [self setBadgeNumber:badgeNumber forSegmentAtIndex:segmentIndex usingBlock:^(CustomBadge *badge){}];
}

- (NSUInteger)getBadgeNumberForSegmentAtIndex:(NSUInteger)segmentIndex
{
    if(_segmentBadgeNumbers==nil)
    {
        return 0;
    }
    NSNumber* number=[_segmentBadgeNumbers objectAtIndex:segmentIndex];
    if(number==nil)
    {
        return 0;
    }
    else
    {
        return [number unsignedIntegerValue];
    }
}

- (void)clearBadges
{
    // Remove the badge view
    [_badgeView removeFromSuperview];
    
    // Clear the badge arrays
    [_segmentBadges removeAllObjects];
    [_segmentBadgeNumbers removeAllObjects];
}

-(void)removeFromSuperview
{
    if (_badgeView) [_badgeView removeFromSuperview];
    [super removeFromSuperview];
}

-(void)dealloc
{
    if (_badgeView) [_badgeView removeFromSuperview];
}
@end
