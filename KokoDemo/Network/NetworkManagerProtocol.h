//
//  NetworkManagerProtocol.h
//  KokoDemo
//
//  Created by Alex Zhang on 2021/3/9.
//  Copyright © 2021 Alex Zhang. All rights reserved.
//

#ifndef NetworkManagerProtocol_h
#define NetworkManagerProtocol_h
@protocol NetworkManagerProtocol <NSObject>

- (void)getDataFromUrl:(NSURL *)url withSuccess:(void (^)(NSData *))successCompletion error:(void (^)(NSError *))errorCompletion;

@end
#endif /* NetworkManagerProtocol_h */
