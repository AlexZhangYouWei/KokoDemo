//
//  AMEMainMenu.h
//  ToolforOC
//
//  Created by Alex on 2020/8/13.
//  Copyright © 2020 AlexSample.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMEMainMenuButton.h"
#import "AMEMainMenuItem.h"


#define kMainMenu_Height  68


@protocol AMEMainMenuDelegate <NSObject>
- (void)clickMainMenuItem:(id)sender;
@end


@interface AMEMainMenu : UIView
{
    NSMutableArray *_barItemViews;
}

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) UIColor *bgColor;
@property (nonatomic) NSInteger activeItemIndex;
@property (nonatomic, weak) id<AMEMainMenuDelegate> delegate;



- (void)initialize;

- (void)setItems:(NSArray *)items;


@end

