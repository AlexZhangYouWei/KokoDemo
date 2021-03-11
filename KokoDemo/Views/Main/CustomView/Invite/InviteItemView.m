//
//  InviteItemView.m
//  KokoDemo
//
//  Created by Alex Zhang on 2021/3/10.
//  Copyright © 2021 Alex Zhang. All rights reserved.
//

#import "InviteItemView.h"

@implementation InviteItemView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
 
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
        [self markUI];
    }
    return self;
}

- (void)setup {
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    self.messageLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    self.nameLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    self.friendsAgreeButton = [[UIButton alloc]initWithFrame:CGRectZero];
    self.friendsDeletButton = [[UIButton alloc]initWithFrame:CGRectZero];
}

- (void)markUI {
    self.layer.cornerRadius = 6;
    
    [self setImage];
    [self setNameLabel];
    [self setMessageLabel];
    [self setFriendsAgreeButton];
    [self setFriendsDeletButton];
}

- (void)setImage {
    self.imageView.frame = CGRectMake(15, 15, 40, 40);
    self.imageView.image = [FriendDisplay getFriendDefaultImage];
    
    [self addSubview:self.imageView];
    
}

- (void)setNameLabel {
    self.nameLabel.frame = CGRectMake(70, 14, 48, 22);
    self.nameLabel.text = @"張先生";
    self.nameLabel.textColor = [UIColor colorWithRed:71/255.0f green:71/255.0f blue:71/255.0f alpha:1.0];
    [self.nameLabel setFont:[UIFont fontWithName:@"PingFangTC-Regular" size:16]];
    [self addSubview:self.nameLabel];
}

- (void)setMessageLabel {
    self.messageLabel.frame = CGRectMake(70, 38, 117, 18);
    self.messageLabel.text = @"邀請你成為好友：）";
    [self.messageLabel setFont:[UIFont fontWithName:@"PingFangTC-Regular" size:13]];
    self.messageLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    
    [self addSubview:self.messageLabel];
}

- (void)setFriendsAgreeButton {
    self.friendsAgreeButton.frame = CGRectMake(225, 20, 30, 30);
    [self.friendsAgreeButton setImage:[UIImage imageNamed:@"btnFriendsAgree"]
                             forState:UIControlStateNormal];
    
    [self addSubview:self.friendsAgreeButton];
}

- (void)setFriendsDeletButton {
    self.friendsDeletButton.frame = CGRectMake(270, 20, 30, 30);
    [self.friendsDeletButton setImage:[UIImage imageNamed:@"btnFriendsDelet"]
                             forState:UIControlStateNormal];
    
    [self addSubview:self.friendsDeletButton];
}


@end
