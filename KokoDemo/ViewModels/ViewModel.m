//
//  ViewModel.m
//  KokoDemo
//
//  Created by Alex Zhang on 2021/3/9.
//  Copyright © 2021 Alex Zhang. All rights reserved.
//

#import "ViewModel.h"


@interface ViewModel()

@property (nonatomic, strong) id<FriendsFetcherProtocol> friendFetcher;
@property (nonatomic, strong) id<UserInfoFetcherProtocol> userInfoFetcher;

@property (nonatomic, strong) NetworkManager *networkManager;
@property (nonatomic, strong) NSArray<FriendDisplay *> *friends;


@property (nonatomic, strong) UserInfoDisplay *userInfo;

@end


@implementation ViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.networkManager = [[NetworkManager alloc] init];
        
        self.friends = @[];
        self.userInfo = [UserInfoDisplay new];
        
        self.friendFetcher = [[FriendFetcher alloc] initWithClient:self.networkManager
                                                      friendParser:[[FriendParser alloc] init]];
        
        self.userInfoFetcher = [[UserInfoFetcher alloc] initWithClient:self.networkManager
                                                        userInfoParser:[[UserInfoParser alloc]init]];
        
    }
    return self;
}


- (void)getFriendURL:(NSString *)urlString WithSuccess:(void (^)(NSArray<Friend *> * _Nonnull))successCompletion error:(void (^)(NSError * _Nonnull))errorCompletion {
    __weak ViewModel *viewModel = self;
    [self.friendFetcher fetchRemoteURL:urlString friendsWithSuccess:^(NSArray<Friend *> *friends) {
        
        NSMutableArray *tempFriends = [[NSMutableArray alloc] init];
        NSMutableArray *tempInvitItems = [[NSMutableArray alloc] init];

        for (Friend *fri in friends) {
            
            FriendDisplay *tempFriendDisplay = [[FriendDisplay alloc] initWithFriend:fri];
            
            if ([self filterIsInviting:tempFriendDisplay]) {
                [tempInvitItems addObject:tempFriendDisplay];
            } else {
                [tempFriends addObject:tempFriendDisplay];
            }
        }
        [viewModel setFriends:[self mergeFriends:tempFriends]];
        [viewModel setInviteItems:tempInvitItems];

        successCompletion(tempFriends);
    } error:errorCompletion];
}

- (void)getUserInfoURL:(NSString *)urlString WithSuccess:(void (^)(UserInfo* _Nonnull))successCompletion error:(void (^)(NSError * _Nonnull))errorCompletion {
    __weak ViewModel *viewModel = self;
    [self.userInfoFetcher fetchRemoteURL:urlString userInfoWithSuccess:^(UserInfo *userInfo) {
        UserInfoDisplay *userDisplay = [[UserInfoDisplay alloc]initWithUserInfo:userInfo];
        [viewModel setUserInfo:userDisplay];
        successCompletion(userInfo);
    } error:^(NSError *error) {
        
    }];
}

- (NSUInteger)numberOfFriends {
    return self.friends.count;
}

- (NSUInteger)numberOfinviteItems {
    return self.inviteItems.count;
}

- (FriendDisplay *)friendsAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row >= self.numberOfFriends) {
        return nil;
    }
    return self.friends[indexPath.row];
}

- (FriendDisplay *)inviteItemsAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row >= self.numberOfinviteItems) {
        return nil;
    }
    return self.inviteItems[indexPath.row];
}

#pragma mark - DataHandle

- (BOOL)filterIsInviting:(FriendDisplay *)friend {
    if (friend.status == FriendStatus_Inviting) {
        return true;
    }
    return false;
}

- (NSMutableArray *)sortFriends:(NSMutableArray *)friends {
    ///先排Status = 0
    ///在排 IsTop = true
    [friends sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"status" ascending:YES],
                                    [NSSortDescriptor sortDescriptorWithKey:@"isTop" ascending:NO]]];
    
    for (FriendDisplay *ob in friends) {
        NSLog(@"Sort = %@/%@/%ld/%@",ob.name,ob.fid,(long)ob.status,ob.isTop?@"置頂":@"不置頂");
    }
    return friends;
    
}


- (NSMutableArray *)mergeFriends:(NSMutableArray *)friends {
    
    //如果原本Friend有資料得話就合併
    if ([self numberOfFriends] > 0) {
        NSMutableArray *result = [self.friends mutableCopy];
        for (FriendDisplay *obj in friends) {
            [result addObject:obj];
        }
        //清除重複並排序
        return [self sortFriends:[self removeRepeatObj:result]];
    }
    
    [self sortFriends:friends];
    return friends;
}

///清除重複相同Fid 且 時間較舊
- (NSMutableArray *)removeRepeatObj:(NSMutableArray *)result {
    NSMutableArray *result2 = [result mutableCopy];
    for (FriendDisplay *obj1 in result) {
        for (FriendDisplay *obj2 in result) {
            if (obj1.fid == obj2.fid && obj1.updateDate != obj2.updateDate) {
                [result2 removeObject:[self isOldDataFriend1:obj1 Friend2:obj2]];
            }
        }
    }
    NSLog(@"==========清除重複");
    return result2;
}

/// 輸出舊資料
/// @param obj1 相同fid Friend1
/// @param obj2 相同fid Friend2
- (FriendDisplay *)isOldDataFriend1:(FriendDisplay *)obj1 Friend2:(FriendDisplay *)obj2 {
    NSComparisonResult result = [obj1.updateDate compare:obj2.updateDate];
    if (result == NSOrderedAscending) {
        return obj1;
    } else {
        return obj2;
    }
}


@end
