//
//  Friend.h
//  KokoDemo
//
//  Created by Alex Zhang on 2021/3/9.
//  Copyright © 2021 Alex Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Header.h"

static NSString * _Nullable const kname   = @"name";
static NSString * _Nullable const kstatus = @"status";
static NSString * _Nullable const kisTop = @"isTop";
static NSString * _Nullable const kfid = @"fid";
static NSString * _Nullable const kupdateDate = @"updateDate";


static NSString * _Nullable const kAPIURL_friend1 = @"https://dimanyen.github.io/friend1.json";
static NSString * _Nullable const kAPIURL_friend2 = @"https://dimanyen.github.io/friend2.json";
static NSString * _Nullable const kAPIURL_friend3 = @"https://dimanyen.github.io/friend3.json";
static NSString * _Nullable const kAPIURL_friend4 = @"https://dimanyen.github.io/friend4.json";

static NSString * _Nullable const kImage_frienddefault = @"imgFriendsList";

typedef NS_ENUM(NSInteger, FriendStatus) {
    FriendStatus_InvitationToSend   = 0,    //發送邀請
    FriendStatus_Complete           = 1,    //已邀請
    FriendStatus_Inviting           = 2     //邀請中
};


@interface Friend : NSObject

@property (nonatomic, strong) NSString * _Nonnull name;
@property (nonatomic, strong) NSString * _Nonnull status;
@property (nonatomic, strong) NSString * _Nonnull isTop;
@property (nonatomic, strong) NSString * _Nonnull fid;
@property (nonatomic, strong) NSString * _Nonnull updateDate;

- (instancetype _Nullable )initWithName:(NSString *_Nullable)name
                                    fid:(NSString *_Nullable)fid
                             updateDate:(NSString *_Nullable)updateDate
                                  isTop:(NSString *_Nullable)isTop
                                 status:(NSString *_Nullable)status;

@end




@interface FriendDisplay : NSObject

@property (nonatomic,readwrite,nonnull) NSString *name;
@property (nonatomic,readwrite,nonnull) NSString *fid;
@property (nonatomic,readwrite,nonnull) NSDate *updateDate;
@property (nonatomic,readwrite) FriendStatus status;
@property (nonatomic,readwrite) BOOL isTop;

- (instancetype _Nullable)initWithFriend:(Friend *_Nullable)fri;

+ (UIImage *_Nullable)getFriendDefaultImage;


@end
