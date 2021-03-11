//
//  CustomTableViewCell.m
//  KokoDemo
//
//  Created by Alex on 2021/3/10.
//  Copyright © 2021 Alex Zhang. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDisplay:(nullable FriendDisplay *)display {

    [self.friendName setText:display.name];
    
    if (!display.isTop) {
        self.startImage.hidden = YES;
    }
    if (display.status == FriendStatus_InvitationToSend ) {
        self.moreImageView.hidden = YES;
    } else {
        self.rightLabel.hidden = YES;
    }
    
    [self setup];
}

- (void)setup {
    self.liftLabel.layer.borderWidth = 2;
    self.liftLabel.layer.borderColor = [Utilitie getKoKoMainColor].CGColor;
    
    
    self.rightLabel.layer.borderWidth = 2;
    self.rightLabel.layer.borderColor = [Utilitie getKokoBrownGreyColor].CGColor;

    self.rightLabel.text = @"邀請中";
    self.rightLabel.textColor = [Utilitie getKokoBrownGreyColor];
    self.layer.cornerRadius = 2;
    [self.rightLabel setFont:[UIFont fontWithName:@"PingFangTC-Medium" size:14]];
    
}
@end
