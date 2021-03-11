//
//  DataParser.m
//  KokoDemo
//
//  Created by Alex Zhang on 2021/3/9.
//  Copyright © 2021 Alex Zhang. All rights reserved.
//

#import "FriendParser.h"



@implementation FriendParser

- (void)parseFriends:(NSData *)data withSuccess:(void (^)(NSArray<Friend *>*))successCompletion error:(void (^)(NSError *))errorCompletion {
    
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
    
    NSMutableArray<Friend *>*result = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in jsonArray) {
        
        Friend *friend = [[Friend alloc] initWithName:[dic objectForKey:kname]
                                                  fid:[dic objectForKey:kfid]
                                           updateDate:[dic objectForKey:kupdateDate]
                                                isTop:[dic objectForKey:kisTop]
                                               status:[dic objectForKey:kstatus]];
        
        [result addObject:friend];
    }
    
    successCompletion(result);
}




@end
