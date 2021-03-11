//
//  Friend.m
//  KokoDemo
//
//  Created by Alex Zhang on 2021/3/9.
//  Copyright © 2021 Alex Zhang. All rights reserved.
//

#import "Friend.h"

@implementation Friend

- (instancetype)initWithName:(NSString *)name fid:(NSString *)fid updateDate:(NSString *)updateDate isTop:(NSString *)isTop status:(NSString *)status
{
    self = [super init];
    if (self) {
        self.name = name;
        self.fid = fid;
        self.status = status;
        self.isTop = isTop;
        self.updateDate = updateDate;
    }
    return self;
}

@end

///================================================================================================

@interface FriendDisplay()

@end

@implementation FriendDisplay

- (instancetype)initWithFriend:(Friend *)fri {
    self = [super init];
    if (self) {
        self.name = fri.name;
        self.fid = fri.fid;
        self.updateDate = [self handleDateString:fri.updateDate];
        self.status = NI_S(fri.status);
        self.isTop = NI_S(fri.isTop);
        
        //NSLog(@"%@/%@/%@/%ld/%@",self.name,self.fid,self.updateDate,(long)self.status,self.isTop ? @"顯示":@"不顯示");
        
    }
    return self;
}


- (NSDate *)handleDateString:(NSString *)dateString {
    
    if ([Utilitie isDateFormatString:dateString]) {
        return [Utilitie StringToDate:dateString];
    } else {
        return [Utilitie StringToDate:[Utilitie ModifyStringFormat:dateString]];
    }    
}

+ (UIImage *)getFriendDefaultImage {
    return [UIImage imageNamed:kImage_frienddefault];
}

@end
