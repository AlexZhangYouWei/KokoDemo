//
//  MiddleView.h
//  KokoDemo
//
//  Created by Alex on 2021/3/10.
//  Copyright © 2021 Alex Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GradualView.h"
#import "CustomLabel.h"
NS_ASSUME_NONNULL_BEGIN
@interface MiddleView : UIView
@property (nonatomic, strong) UIImageView *DefaultImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) GradualView *customAddFriendView;
@property (nonatomic, strong) UILabel *commentaryLabel;

@end

NS_ASSUME_NONNULL_END
