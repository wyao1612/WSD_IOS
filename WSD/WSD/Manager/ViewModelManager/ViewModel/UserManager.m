//
//  UserManager.m
//  WSD
//
//  Created by wyao on 2017/1/11.
//  Copyright © 2017年 Tsou. All rights reserved.
//

#import "UserManager.h"


@interface UserManager ()

@property (nonatomic,strong)  UserProcessor *processor;
@property (nonatomic,strong)  UserModel * model;
@end


@implementation UserManager

- (instancetype)init{
    self = [super init];
    if (self) {
        _processor = [[UserProcessor alloc] init];
    }
    return self;
}



@end
