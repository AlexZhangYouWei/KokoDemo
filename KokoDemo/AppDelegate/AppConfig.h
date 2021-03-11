//
//  AppConfig.h
//  KokoDemo
//
//  Created by Alex on 2021/3/11.
//  Copyright © 2021 Alex Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, StartModel) {
    StartModel_NoFriend         = 1,    //沒有好友情境
    StartModel_OnlyFriend       = 2,    //只有好友情境
    StartModel_FriendAndinvite  = 3     //好友跟邀請都有
    
};

@interface AppConfig : NSObject
@property (nonatomic) StartModel startModel;

+ (instancetype) sharedInstance;
@end

NS_ASSUME_NONNULL_END
