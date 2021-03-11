//
//  UserInfoFetcher.h
//  KokoDemo
//
//  Created by Alex Zhang on 2021/3/9.
//  Copyright © 2021 Alex Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataFetcherProtocol.h"
#import "NetworkManagerProtocol.h"
#import "Header.h"

@interface UserInfoFetcher : NSObject<UserInfoFetcherProtocol>

- (instancetype)initWithClient:(id<NetworkManagerProtocol>)client
                userInfoParser:(id<UserInfoParserProtocol>)userInfoParser;

@end

