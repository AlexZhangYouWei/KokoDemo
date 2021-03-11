//
//  UserInfo.h
//  KokoDemo
//
//  Created by Alex Zhang on 2021/3/9.
//  Copyright © 2021 Alex Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
static NSString * _Nullable const kkokoid = @"kokoid";

static NSString * _Nullable const  kAPIURL_UserInfo = @"https://dimanyen.github.io/man.json";



@interface UserInfo : NSObject
@property (nonatomic, strong) NSString * _Nonnull name;
@property (nonatomic, strong) NSString * _Nonnull kokoid;

- (instancetype _Nonnull)initWithName:(NSString *_Nonnull)name kokoid:(NSString *_Nonnull)kokoid;

@end



@interface UserInfoDisplay : NSObject

@property (nonatomic, readwrite, nonnull) NSString *name;
@property (nonatomic, readwrite, nonnull) NSString *kokoid;


- (instancetype _Nonnull)initWithUserInfo:(UserInfo *_Nonnull)fri;

@end
