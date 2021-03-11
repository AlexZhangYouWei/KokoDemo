//
//  NetworkManager.m
//  KokoDemo
//
//  Created by Alex Zhang on 2021/3/9.
//  Copyright © 2021 Alex Zhang. All rights reserved.
//

#import "NetworkManager.h"

@interface NetworkManager()

@property (nonatomic, strong) NSMutableDictionary * tasks;

@end

@implementation NetworkManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tasks = [[NSMutableDictionary alloc] init];
    }
    return self;
}


- (void)getDataFromUrl:(NSURL *)url withSuccess:(void (^)(NSData *))successCompletion error:(void (^)(NSError *))errorCompletion {
    
    NSURLSessionTask *previousTask = [self.tasks objectForKey:url.absoluteString];
    
    if (previousTask){
        [previousTask cancel];
    }
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionTask * task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error) {
            errorCompletion(error);
            return;
        }
        
        if (!data) {
            errorCompletion(nil);
            return;
        }
        successCompletion(data);
    }];
    
    [task resume];
    [self.tasks setObject:task forKey:url.absoluteString];
}
@end
