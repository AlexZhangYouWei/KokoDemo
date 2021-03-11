//
//  AMEMainMenuButton.m
//  ToolforOC
//
//  Created by Alex on 2020/8/13.
//  Copyright © 2020 AlexSample.com. All rights reserved.
//

#import "AMEMainMenuButton.h"

@implementation AMEMainMenuButton

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)initialize
{
    _imgView = [UIImageView new];
    if (!self.enabled) {
        if (_imgDisable) {
            _imgView.image = _imgDisable;
            _imgView.alpha = 1.0f;
        } else {
            _imgView.image = _img;
            _imgView.alpha = 0.5f;
        }
    } else {
        _imgView.image =_isFocus ? _imgSelect :_img;
        _imgView.alpha = 1.0f;
    }
    _imgView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_imgView];
    
    _lab = [UILabel new];
    _lab.text = _labText;
    if (!self.enabled) {
        _lab.textColor = _labDisableTextColor;
    } else {
        _lab.textColor = _isFocus? _labFocusTextColor : _labTextColor;
    }
    _lab.font = _labFont;
    _lab.adjustsFontSizeToFitWidth = YES;
    _lab.textAlignment = NSTextAlignmentCenter;
    if (_labFont) {
        _lab.minimumScaleFactor = 8 / _labFont.pointSize;
    }
    [self addSubview:_lab];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (_isPrimary) {
        _imgView.frame = self.bounds;
        _lab.frame = CGRectMake(0, self.frame.size.height * 0.55f   , self.frame.size.width, 20.0f);
    } else {
        CGFloat posY = 0;
        _imgView.frame = CGRectMake( (self.frame.size.width - 30.0f ) / 2 , 0 , 30.0f, 30.0f);
        posY += (_imgView.frame.origin.y +_imgView.frame.size.height);
        _lab.frame = CGRectMake(0, posY, self.frame.size.width, 20.0f);
        
    }
    [self setIsFocus:_isFocus];
}

- (void)setIsFocus:(BOOL)isFocus
{
    _isFocus = isFocus;
    if (!self.enabled) {
        if (_imgDisable) {
            _imgView.image = _imgDisable;
            _imgView.alpha = 1.0f;
        } else {
            _imgView.image = _img;
            _imgView.alpha = 0.5f;
        }
        _lab.textColor = _labDisableTextColor;
    } else {
        _imgView.image =_isFocus ? _imgSelect :_img;
        _imgView.alpha = 1.0f;
        _lab.textColor = _isFocus? _labFocusTextColor : _labTextColor;
    }
}




- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"Title:[%@] , ",self.labText);
    
}

@end


