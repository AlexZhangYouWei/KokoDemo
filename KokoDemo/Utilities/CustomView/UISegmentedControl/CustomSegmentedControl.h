//
//  CustomSegmentedControl.h
//  KokoDemo
//
//  Created by Alex Zhang on 2021/3/10.
//  Copyright © 2021 Alex Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utilitie.h"
#import "CustomBadge.h"
NS_ASSUME_NONNULL_BEGIN

@interface CustomSegmentedControl : UISegmentedControl
{
@private
    NSMutableArray *_segmentBadgeNumbers;
    NSMutableArray *_segmentBadges;
    UIView *_badgeView;
}
@end

NS_ASSUME_NONNULL_END
