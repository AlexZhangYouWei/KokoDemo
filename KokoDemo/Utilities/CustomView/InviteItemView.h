//
//  InviteItemView.h
//  KokoDemo
//
//  Created by Alex Zhang on 2021/3/10.
//  Copyright © 2021 Alex Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Friend.h"
#import "CustomLabel.h"
NS_ASSUME_NONNULL_BEGIN

@interface InviteItemView : UIView
@property (nonatomic, strong) UIImageView* imageView;
@property (nonatomic, strong) CustomLabel* nameLabel;
@property (nonatomic, strong) UILabel* messageLabel;
@property (nonatomic, strong) UIButton *friendsAgreeButton;
@property (nonatomic, strong) UIButton *friendsDeletButton;



@end

NS_ASSUME_NONNULL_END
