//
//  CustomTableViewCell.h
//  KokoDemo
//
//  Created by Alex on 2021/3/10.
//  Copyright © 2021 Alex Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Friend.h"
NS_ASSUME_NONNULL_BEGIN

@interface CustomTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *startImage;
@property (strong, nonatomic) IBOutlet UILabel *friendName;
@property (strong, nonatomic) IBOutlet UILabel *liftLabel;
@property (strong, nonatomic) IBOutlet UIImageView *moreImageView;
@property (strong, nonatomic) IBOutlet UILabel *rightLabel;

- (void)setDisplay:(nullable FriendDisplay *)display;

@end

NS_ASSUME_NONNULL_END
