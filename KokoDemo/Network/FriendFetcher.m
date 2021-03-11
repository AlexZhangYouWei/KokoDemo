//
//  DataFetcher.m
//  KokoDemo
//
//  Created by Alex Zhang on 2021/3/9.
//  Copyright © 2021 Alex Zhang. All rights reserved.
//

#import "FriendFetcher.h"


@interface FriendFetcher()

@property (nonatomic, strong) id<FriendsParserProtocol> friendParser;
@property (nonatomic, strong) id<NetworkManagerProtocol> networkClient;

@end

@implementation FriendFetcher

- (instancetype)initWithClient:(id<NetworkManagerProtocol>)client friendParser:(id<FriendsParserProtocol>)friendParser
{
    self = [super init];
    if (self) {
        self.friendParser = friendParser;
        self.networkClient = client;
    }
    return self;
}


- (void)fetchRemoteURL:(NSString *)urlSring friendsWithSuccess:(void (^)(NSArray<Friend *>*))successCompletion error:(void (^)(NSError *))errorCompletion {
    
    NSURL * url = [NSURL URLWithString:urlSring];
    __weak FriendFetcher *dataFetcher = self;
    
    void (^networksResponse)(NSData *) = ^(NSData *data) {
        [dataFetcher.friendParser parseFriends:data withSuccess:successCompletion error:errorCompletion];
    };
    
    // TODO: improve error handling at each steps
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [dataFetcher.networkClient getDataFromUrl:url withSuccess:networksResponse error:errorCompletion];
    });
}

@end
