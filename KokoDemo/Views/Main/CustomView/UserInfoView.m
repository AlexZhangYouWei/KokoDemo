//
//  UserInfoView.m
//  KokoDemo
//
//  Created by Alex on 2021/3/10.
//  Copyright © 2021 Alex Zhang. All rights reserved.
//

#import "UserInfoView.h"

@implementation UserInfoView

#define kDefault_Username   @"紫晽"
#define kDefault_KokoID     @"設定KOKO ID"

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self setup];
    [self markUI];
}

- (void)setup {
    self.userNameLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    self.userKokoIDLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    self.userPinkView = [[UIView alloc]initWithFrame:CGRectZero];
    self.userImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    self.userArrowImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    
}

- (void)markUI {
    
    self.backgroundColor = [UIColor colorWithRed:252/255.0f green:252/255.0f blue:252/255.0f alpha:1.0f];

    [self setUserNameLabel];
    [self setUserkokoIDlabel];
    [self setUserPinkView];
    [self setUserImageView];
    [self setUserArrowImageView];
}

- (void)setUserNameLabel {
    self.userNameLabel.frame = CGRectMake(30, 46, 52, 18);
    [self.userNameLabel setFont:[UIFont boldSystemFontOfSize:17]];
    self.userNameLabel.text = kDefault_Username;
    self.userNameLabel.textColor = [UIColor colorWithRed:71/255.0 green:71/255.0 blue:71/255.0 alpha:1.0];

    [self addSubview:self.userNameLabel];
}


- (void)setUserkokoIDlabel {
    self.userKokoIDLabel.frame = CGRectMake(30, 72, 85, 18);
    [self.userKokoIDLabel setFont:[UIFont systemFontOfSize:13]];
    self.userKokoIDLabel.text = kDefault_KokoID;
    self.userKokoIDLabel.textColor = [UIColor colorWithRed:71/255.0 green:71/255.0 blue:71/255.0 alpha:1.0];
    
    [self addSubview:self.userKokoIDLabel];
}

- (void)setUserPinkView {
    self.userPinkView.frame = CGRectMake(148, 76, 10, 10);
    self.userPinkView.backgroundColor = [UIColor colorWithRed:236/255.0 green:0/255.0 blue:140/255.0 alpha:1.0];
    self.userPinkView.layer.cornerRadius = 6.0;

    [self addSubview:self.userPinkView];
    
}

- (void)setUserImageView {
    self.userImageView.frame = CGRectMake([Utilitie getScreenWidth] - 30 - 52,
                                          38,
                                          52,
                                          52);
    
    [self.userImageView setImage:[UIImage imageNamed:@"imgFriendsFemaleDefault"]];
    
    [self addSubview:self.userImageView];
}

- (void)setUserArrowImageView {
    self.userArrowImageView.frame = CGRectMake(115, 72, 18, 18);
    [self.userArrowImageView setImage:[UIImage imageNamed:@"icInfoBackDeepGray"]];
    
    [self addSubview:self.userArrowImageView];
}

@end
