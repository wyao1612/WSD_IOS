//
//  ViewModelFactory.m
//  WSD
//
//  Created by wyao on 2017/1/4.
//  Copyright © 2017年 Tsou. All rights reserved.
//

#import "BusinessFactory.h"

@implementation BusinessFactory

- (UserManager *)createUserManager{
    return [[UserManager alloc] init];
}

- (LoginManager *)createLoginManager{
    return [[LoginManager alloc] init];
}

- (HomeManager *)createHomeManager{
    return [[HomeManager alloc] init];
}

@end
