//
//  UserInfoParser.m
//  KokoDemo
//
//  Created by Alex Zhang on 2021/3/9.
//  Copyright © 2021 Alex Zhang. All rights reserved.
//

#import "UserInfoParser.h"

@implementation UserInfoParser

- (void)parseUserInfo:(NSData *)data withSuccess:(void (^)(UserInfo *))successCompletion error:(void (^)(NSError *))errorCompletion {
    
    NSError *error;
    NSDictionary * jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    
    if (!jsonDictionary || error) {
        // TODO: handle error better way
        errorCompletion(error);
        return;
    }
    
    NSArray *jsonArray = [jsonDictionary objectForKey:@"response"];
    if (!jsonArray) {
        // TODO: handle error
        NSError * error = [NSError errorWithDomain:NSCocoaErrorDomain code:300 userInfo:nil];
        errorCompletion(error);
        return;
    }
    
    NSDictionary *dic = jsonArray[0];
    
    UserInfo *userInfo = [[UserInfo alloc]initWithName:[dic objectForKey:kname]
                                                kokoid:kkokoid];
    
    successCompletion(userInfo);
    
}

@end
