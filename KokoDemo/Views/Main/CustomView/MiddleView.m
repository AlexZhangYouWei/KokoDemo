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
    self.customAddFriendView = [[GradualView alloc] initWithFrame:CGRectZero];
    self.commentaryLabel = [self targetLabelWithTitle:@"幫助好友更快找到你？(設定KOKOID)" frame:CGRectZero];
}

- (void)markUI {
    [self setDefaultImageView];
    [self setTitleLabel];
    [self setMessageLabel];
    [self setCustomAddFriendView];
    [self setCommentaryLabel];
    
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
    self.messageLabel.frame = CGRectMake(68, 202+78 , 240, 40);
    [self.messageLabel setFont:[UIFont systemFontOfSize:14]];
    self.messageLabel.text = @"與好友們一起用 KOKO 聊起來！\n還能互相收付款、發紅包喔：）";
    self.messageLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    self.messageLabel.textAlignment = NSTextAlignmentCenter;
    self.messageLabel.numberOfLines = 2;
    [self addSubview:self.messageLabel];
}

- (void)setCustomAddFriendView {
    self.customAddFriendView.frame = CGRectMake(92, 202+78+25+40 ,192, 40);
    
    [self addSubview:self.customAddFriendView];
}

- (void)setCommentaryLabel {
    self.commentaryLabel.frame = CGRectMake(43, 202+78+25+40+48+3 ,289, 18);
    self.commentaryLabel.textAlignment = NSTextAlignmentCenter;
    [self.commentaryLabel setFont:[UIFont fontWithName:@"PingFangTC-Regular" size:13]];
    [self addSubview:self.commentaryLabel];
}

- (UILabel *)targetLabelWithTitle:(NSString *)title frame:(CGRect)frame {
    UILabel *label  = [[UILabel alloc]init];
    label.frame     = frame;
    label.textColor =  [UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:1.0];
    
    NSRange startRange = [title rangeOfString:@"("];
    NSRange endRange   = [title rangeOfString:@")"];
    NSRange range      = NSMakeRange(startRange.location + startRange.length,endRange.location - (startRange.location + startRange.length));
    NSString *beforeString   = [title substringToIndex:startRange.location];
    NSString *resultString   = [title substringWithRange:range];
    
    NSString *handleString   = [NSString stringWithFormat:@"%@%@",beforeString,resultString];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:handleString];
    NSRange resultRange = NSMakeRange([[attributedString string] rangeOfString:resultString].location, [[attributedString string] rangeOfString:resultString].length);
    [attributedString addAttribute:NSForegroundColorAttributeName value:[Utilitie getKoKoMainColor] range:resultRange];
    label.attributedText = attributedString;
    [attributedString addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleNone) range:resultRange];
    [attributedString addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:resultRange];
    label.attributedText = attributedString;
    return label;
}


@end
