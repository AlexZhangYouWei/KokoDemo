//
//  UserInfoFetcher.m
//  KokoDemo
//
//  Created by Alex Zhang on 2021/3/9.
//  Copyright © 2021 Alex Zhang. All rights reserved.
//

#import "UserInfoFetcher.h"

@interface UserInfoFetcher()

@property (nonatomic, strong) id<UserInfoParserProtocol> userInfoParser;
@property (nonatomic, strong) id<NetworkManagerProtocol> networkClient;

@end


@implementation UserInfoFetcher

- (instancetype)initWithClient:(id<NetworkManagerProtocol>)client userInfoParser:(id<UserInfoParserProtocol>)parser
{
    self = [super init];
    if (self) {
        self.userInfoParser = parser;
        self.networkClient = client;
    }
    return self;
}

- (void)fetchRemoteURL:(NSString *)urlSring userInfoWithSuccess:(void (^)(UserInfo *))successCompletion error:(void (^)(NSError *))errorCompletion {
    NSURL * url = [NSURL URLWithString:urlSring];
    __weak UserInfoFetcher *dataFetcher = self;
    
    void (^networksResponse)(NSData *) = ^(NSData *data) {
        [dataFetcher.userInfoParser parseUserInfo:data withSuccess:successCompletion error:errorCompletion];
    };
    
    // TODO: improve error handling at each steps
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [dataFetcher.networkClient getDataFromUrl:url withSuccess:networksResponse error:errorCompletion];
    });
}

@end
