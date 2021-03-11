//
//  UserInfoView.h
//  KokoDemo
//
//  Created by Alex on 2021/3/10.
//  Copyright © 2021 Alex Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utilitie.h"
NS_ASSUME_NONNULL_BEGIN

@interface UserInfoView : UIView
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UILabel *userKokoIDLabel;
@property (nonatomic, strong) UIImageView *userImageView;
@property (nonatomic, strong) UIImageView *userArrowImageView;
@property (nonatomic, strong) UIView *userPinkView;
@end

NS_ASSUME_NONNULL_END
