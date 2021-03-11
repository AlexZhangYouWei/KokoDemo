//
//  AMEMainMenuButton.h
//  ToolforOC
//
//  Created by Alex on 2020/8/13.
//  Copyright © 2020 AlexSample.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AMEMainMenuButton : UIButton
{
    UIImageView *_imgView;
    UILabel *_lab;
}

@property (nonatomic)BOOL isFocus;
@property (nonatomic, strong)UIImage *img;
@property (nonatomic, strong)UIImage *imgSelect;
@property (nonatomic, strong)UIImage *imgDisable;
@property (nonatomic, strong)NSString *labText;
@property (nonatomic, strong)UIColor *labTextColor;
@property (nonatomic, strong)UIColor *labFocusTextColor;
@property (nonatomic, strong)UIColor *labDisableTextColor;
@property (nonatomic, strong)UIFont *labFont;
@property (nonatomic) BOOL isPrimary; // 是否為中間圓型那個Item



- (void)initialize;

@end

