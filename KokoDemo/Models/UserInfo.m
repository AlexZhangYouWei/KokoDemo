//
//  UserInfo.m
//  KokoDemo
//
//  Created by Alex Zhang on 2021/3/9.
//  Copyright © 2021 Alex Zhang. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

- (instancetype)initWithName:(NSString *)name kokoid:(NSString *)kokoid {
    self = [super init];
    if (self) {
        self.name = name;
        self.kokoid = kokoid;
    }
    return self;
}

@end

//================================================================================================

@interface UserInfoDisplay()

@end

@implementation UserInfoDisplay

- (instancetype)initWithUserInfo:(UserInfo *)user {
    self = [super init];
    if (self) {
        self.name = user.name;
        self.kokoid = user.kokoid;
        NSLog(@"Display = %@/%@",self.name,self.kokoid);

    }
    return self;
}



@end
