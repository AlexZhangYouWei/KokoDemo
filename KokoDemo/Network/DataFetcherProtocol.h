//
//  DataFetcherProtocol.h
//  KokoDemo
//
//  Created by Alex Zhang on 2021/3/9.
//  Copyright © 2021 Alex Zhang. All rights reserved.
//

#ifndef DataFetcherProtocol_h
#define DataFetcherProtocol_h
#import <Foundation/Foundation.h>
#import "Friend.h"
#import "UserInfo.h"


@protocol FriendsFetcherProtocol <NSObject>
- (void)fetchRemoteURL:(NSString *)urlSring friendsWithSuccess:(void (^)(NSArray<Friend *>*))successCompletion error:(void (^)(NSError *))errorCompletion;
@end
@protocol UserInfoFetcherProtocol <NSObject>
- (void)fetchRemoteURL:(NSString *)urlSring userInfoWithSuccess:(void (^)(UserInfo *))successCompletion error:(void (^)(NSError *))errorCompletion;
@end

@protocol FriendsParserProtocol <NSObject>
- (void)parseFriends:(NSData *)data withSuccess:(void (^)(NSArray<Friend *>*friends))successCompletion error:(void (^)(NSError *error))errorCompletion;
@end

@protocol UserInfoParserProtocol <NSObject>
- (void)parseUserInfo:(NSData *)data withSuccess:(void (^)(UserInfo *))successCompletion error:(void (^)(NSError *))errorCompletion;
@end

#endif /* DataFetcherProtocol_h */
