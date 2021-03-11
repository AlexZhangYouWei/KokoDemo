//
//  InviteListView.h
//  KokoDemo
//
//  Created by Alex on 2021/3/11.
//  Copyright © 2021 Alex Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InviteItemView.h"
#import "Friend.h"
NS_ASSUME_NONNULL_BEGIN

@interface InviteListView : UIStackView
@property (nonatomic, strong) InviteItemView *itemView;
@property (nonatomic, strong) NSArray<FriendDisplay *> *itemLists;

- (void)setData:(NSArray *)data;
@end

NS_ASSUME_NONNULL_END
