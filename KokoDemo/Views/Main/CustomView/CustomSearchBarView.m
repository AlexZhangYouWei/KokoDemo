//
//  CustomSearchBarView.m
//  KokoDemo
//
//  Created by Alex on 2021/3/11.
//  Copyright © 2021 Alex Zhang. All rights reserved.
//

#import "CustomSearchBarView.h"

@interface CustomSearchBarView ()

@property (nonatomic, strong) UIImageView *actionImageView;

@end

@implementation CustomSearchBarView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.actionImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.actionImageView.image = [UIImage imageNamed:@"icBtnAddFriends"];
    [self addSubview:self.actionImageView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.actionImageView.frame = CGRectMake(321, 5, 24, 24);
}

@end
