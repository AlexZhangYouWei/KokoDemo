//
//  ViewModel.h
//  KokoDemo
//
//  Created by Alex Zhang on 2021/3/9.
//  Copyright © 2021 Alex Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkManager.h"
#import "FriendParser.h"
#import "FriendFetcher.h"
#import "UserInfoParser.h"
#import "UserInfoFetcher.h"

@interface ViewModel : NSObject

@property (nonatomic, strong) NSArray<FriendDisplay *> *_Nullable inviteItems;


- (void)getFriendURL:(NSString *_Nonnull)urlString
         WithSuccess:(void (^_Nullable)(NSArray<Friend *> * _Nullable))successCompletion
               error:(void (^_Nullable)(NSError * _Nonnull))errorCompletion;

- (void)getUserInfoURL:(NSString *_Nonnull)urlString
           WithSuccess:(void (^_Nullable)(UserInfo* _Nonnull))successCompletion
                 error:(void (^_Nullable)(NSError * _Nonnull))errorCompletion;


- (NSUInteger)numberOfFriends;

- (NSUInteger)numberOfinviteItems;

- (FriendDisplay *_Nullable)friendsAtIndexPath:(NSIndexPath *_Nullable)indexPath;
- (FriendDisplay *_Nullable)inviteItemsAtIndexPath:(NSIndexPath *_Nullable)indexPath;

- (void)searchData:(NSString *_Nonnull)keyWord;
@end

