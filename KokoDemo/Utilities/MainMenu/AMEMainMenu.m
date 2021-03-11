//
//  AMEMainMenu.m
//  ToolforOC
//
//  Created by Alex on 2020/8/13.
//  Copyright © 2020 AlexSample.com. All rights reserved.
//

#import "AMEMainMenu.h"

@implementation AMEMainMenu

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self adjustUI];
}

- (void)initialize
{
    
}

- (void)setItems:(NSArray *)items
{
    _items = items;
    [self UIBuild];
}


- (void)UIBuild
{
    if (_items.count ==0)
        return;
    
    _barItemViews = [NSMutableArray new];

    for (int a = 0; a < [_items count]; a++) {
        AMEMainMenuItem *item = [_items objectAtIndex:a];
        AMEMainMenuButton *btn = [AMEMainMenuButton buttonWithType:UIButtonTypeCustom];
        btn.labText = item.title;
        NSLog(@"%@",item.title);
        btn.labTextColor = item.textColor;
        btn.labFocusTextColor = item.selectedTextColor;
        btn.labDisableTextColor = item.disableTextColor;
        btn.isPrimary = item.isPrimary;
        btn.enabled = !item.disabled;
        if (item.img) {
            btn.img = item.img;
        }
        if (item.imgSelect) {
            btn.imgSelect = item.imgSelect;
        }
        if (item.imgDisable) {
            btn.imgDisable = item.imgDisable;
        }
        if (btn.isPrimary)
        {
            btn.layer.backgroundColor = [UIColor redColor].CGColor;
        }
        btn.tag = a;
        [btn initialize];
        [btn addTarget:self action:@selector(clickMenuItem:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btn];
        [_barItemViews addObject:btn];
    }
    
}

- (void)adjustUI
{
    if (_barItemViews.count == 0)
        return;
    
    NSUInteger leftSideItemCount = ceil(((CGFloat)_barItemViews.count - 1 ) / 2);
    CGFloat primaryWidth = self.frame.size.height *(65.0f / 49.0f);
    CGFloat otherWidth  = 50.0f;
    CGFloat itemPadding = ((self.frame.size.width - primaryWidth ) / 2 - otherWidth * leftSideItemCount ) / (leftSideItemCount + 1);
    NSInteger index = 0;
    CGFloat posX = itemPadding;
    for (AMEMainMenuButton *btn in _barItemViews)
    {
        //btn.layer.borderWidth = 1.5;
        //btn.layer.borderColor = [UIColor redColor].CGColor;
        if (btn.isPrimary)
        {
            btn.frame = CGRectMake((self.frame.size.width - primaryWidth) / 2, self.frame.size.height - primaryWidth ,
                                   primaryWidth,
                                   primaryWidth);
            btn.layer.cornerRadius = btn.frame.size.width/2;
            continue;
        }
        
        btn.frame = CGRectMake( posX ,0 , otherWidth  , self.frame.size.height);
        posX += (itemPadding + otherWidth);
        index ++;
        
        if (index + 1 > leftSideItemCount)
        {
            posX += primaryWidth;
            posX += itemPadding;
            index = 0;
        }
    }
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"Main Menu");
}


- (void)clickMenuItem:(id)sender
{
    [_delegate clickMainMenuItem:sender];

    if (_delegate && [_delegate respondsToSelector:@selector(clickMainMenuItem:)])
    {
    }
}
@end
