//
//  AMEMainMenuItem.h
//  ToolforOC
//
//  Created by Alex on 2020/8/13.
//  Copyright © 2020 AlexSample.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Utilitie.h"

@interface AMEMainMenuItem : NSObject

@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIImage *img;
@property (nonatomic, strong) UIImage *imgSelect;
@property (nonatomic, strong) UIImage *imgDisable;
@property (nonatomic) BOOL isPrimary; // 是否為中間圓型那個Item
@property (nonatomic) BOOL disabled;
@property (nonatomic, strong) UIColor* textColor;
@property (nonatomic, strong) UIColor* disableTextColor;
@property (nonatomic, strong) UIColor* selectedTextColor;

@end

