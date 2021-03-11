//
//  MiddleView.m
//  KokoDemo
//
//  Created by Alex on 2021/3/10.
//  Copyright © 2021 Alex Zhang. All rights reserved.
//

#import "MiddleView.h"

@implementation MiddleView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self setup];
    [self markUI];
}

- (void)setup {
    self.DefaultImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.messageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.customAddFriendView = [[UIView alloc] initWithFrame:CGRectZero];
    self.commentaryLabel = [[UILabel alloc] initWithFrame:CGRectZero];
}

- (void)markUI {
    [self setDefaultImageView];
    [self setTitleLabel];
    [self setMessageLabel];
    
}

- (void)setDefaultImageView {
    self.DefaultImageView.frame = CGRectMake(65, 30, 245, 172);
    [self.DefaultImageView setImage:[UIImage imageNamed:@"imgFriendsEmpty"]];

    [self addSubview:self.DefaultImageView];
}

- (void)setTitleLabel {
    self.titleLabel.frame = CGRectMake(44, 202+41 , 287, 29);
    [self.titleLabel setFont:[UIFont boldSystemFontOfSize:21]];
    self.titleLabel.text = @"就從加好友開始吧：）";
    self.titleLabel.textColor = [UIColor colorWithRed:71/255.0 green:71/255.0 blue:71/255.0 alpha:1.0];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.titleLabel];
}

- (void)setMessageLabel {
    self.messageLabel.frame = CGRectMake(68, 202+41+8+29 , 240, 40);
    [self.messageLabel setFont:[UIFont systemFontOfSize:14]];
    self.messageLabel.text = @"與好友們一起用 KOKO 聊起來！\n還能互相收付款、發紅包喔：）";
    self.messageLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    self.messageLabel.textAlignment = NSTextAlignmentCenter;
    self.messageLabel.numberOfLines = 2;
    [self addSubview:self.messageLabel];
}
@end
