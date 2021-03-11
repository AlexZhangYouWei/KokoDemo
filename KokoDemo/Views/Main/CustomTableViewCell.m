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
    

}
@end
