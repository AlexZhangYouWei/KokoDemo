//
//  CustomSearchBarView.m
//  KokoDemo
//
//  Created by Alex on 2021/3/11.
//  Copyright © 2021 Alex Zhang. All rights reserved.
//

#import "CustomSearchBarView.h"

@interface CustomSearchBarView()
{
    UIImageView *imageView;
}
@end

@implementation CustomSearchBarView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self setup];
    [self markUI];
    
}

- (void)setup {
    imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
}

- (void)markUI {
    [self setImageView];
    [self setSearchBar];
}

- (void)setImageView {
    imageView.frame = CGRectMake(321, 5, 24, 24);
    imageView.image = [UIImage imageNamed:@"icBtnAddFriends"];
    [self addSubview:imageView];
}

- (void)setSearchBar {
    self.searchBar.frame = CGRectMake(30, 0, 276, 36);
    self.searchBar.placeholder = @"想轉一筆給誰呢？";
    self.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    [self addSubview:self.searchBar];
}


@end
