//
//  InviteListView.m
//  KokoDemo
//
//  Created by Alex on 2021/3/11.
//  Copyright © 2021 Alex Zhang. All rights reserved.
//

#import "InviteListView.h"

@implementation InviteListView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [self setup];
}


- (void)setup {
    
    self.axis = UILayoutConstraintAxisVertical;
    self.distribution = UIStackViewDistributionFill;
    self.alignment = UIStackViewAlignmentFill;
    self.spacing = 10;
    
    self.translatesAutoresizingMaskIntoConstraints = false;
    //Layout for Stack View
    [self.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = true;
    [self.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = true;
}

- (void)setData:(NSArray *)data {
    
    for (FriendDisplay *obj in data) {
        InviteItemView *view = [[InviteItemView alloc] init];
        if (obj.name.length >0) {
            view.nameLabel.text = obj.name;
        }
        [view.heightAnchor constraintEqualToConstant:80].active = true;
        [view.widthAnchor constraintEqualToConstant:315].active = true;
        [self addArrangedSubview:view];
    }
}


@end
