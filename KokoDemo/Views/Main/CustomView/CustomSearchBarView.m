//
//  CustomSearchBarView.m
//  KokoDemo
//
//  Created by Alex on 2021/3/11.
//  Copyright © 2021 Alex Zhang. All rights reserved.
//

#import "CustomSearchBarView.h"

@interface CustomSearchBarView()<UISearchBarDelegate>
{
    UIImageView *imageView;
}

@end

@implementation CustomSearchBarView


- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self setup];
    [self markUI];
    
}

- (void)setup {
    imageView = [[UIImageView alloc] initWithFrame:CGRectZero];

}

- (void)markUI {
    [self setImageView];
}

- (void)setImageView {
    imageView.frame = CGRectMake(321, 5, 24, 24);
    imageView.image = [UIImage imageNamed:@"icBtnAddFriends"];
    [self addSubview:imageView];
}




@end
