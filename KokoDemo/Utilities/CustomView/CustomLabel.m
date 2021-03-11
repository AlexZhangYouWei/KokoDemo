//
//  CustomLabel.m
//  KokoDemo
//
//  Created by Alex Zhang on 2021/3/10.
//  Copyright © 2021 Alex Zhang. All rights reserved.
//

#import "CustomLabel.h"

@implementation CustomLabel


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self setup];
}

- (void)setup {
    
    self.textColor = [UIColor colorWithRed:71/255.0f green:71/255.0f blue:71/255.0f alpha:1.0];
    self.font = [UIFont fontWithName:@"PingFangTC-Regular" size:16];
}

/*
 UILabel *l  = [self targetLabelWithTitle:@"啊哈哈哈(想不到吧)"];
 [self.view addSubview:l];
 */
+ (UILabel *)targetLabelWithTitle:(NSString *)title{

       UILabel *label  = [[UILabel alloc]init];
       //label.frame     = CGRectMake(0,self.frame.size.height /2, self.frame.size.width, 100);

       label.textColor = [UIColor orangeColor];
       label.textAlignment = NSTextAlignmentCenter;
       label.font          = [UIFont boldSystemFontOfSize:30.0f];

       NSRange startRange = [title rangeOfString:@"("];
       NSRange endRange   = [title rangeOfString:@")"];
       NSRange range      = NSMakeRange(startRange.location + startRange.length,endRange.location - (startRange.location + startRange.length));
       NSString *beforeString   = [title substringToIndex:startRange.location];
       NSString *resultString   = [title substringWithRange:range];

       //重置去掉"()"后的title
       NSString *handleString   = [NSString stringWithFormat:@"%@%@",beforeString,resultString];

       NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:handleString];
       NSRange resultRange = NSMakeRange([[attributedString string] rangeOfString:resultString].location, [[attributedString string] rangeOfString:resultString].length);
       //需要的特殊颜色
       [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:resultRange];
       //设置属性字符串
       label.attributedText = attributedString;

       return label;
}
@end
