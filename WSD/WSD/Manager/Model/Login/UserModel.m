//
//  UserModel.m
//  GolfIOS
//
//  Created by 李明星 on 2016/12/2.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

static dispatch_once_t onceToken;
static UserModel *model;


+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    return [UserModel sharedUserModel];
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _nickName = @"请登录";
        _sort = 1;
    }
    return self;
}

+ (instancetype)sharedUserModel{
    
    dispatch_once(&onceToken, ^{
        model = [[super allocWithZone:NULL] init];
    });
    return model;
}

- (void)setIsLogin:(BOOL)isLogin{
    _isLogin = isLogin;
    if (_isLogin) {
        [self updateLevelImg];//登录时根据sort排序刷新最新等级图标
    }
}

- (void)updateLevelImg{
    //从1- 5
    NSInteger levelLd = [UserModel sharedUserModel].sort + 147;
    NSString *img = [NSString stringWithFormat:@"classify%ld", levelLd];
    [[UserModel sharedUserModel] setLevelImg:IMAGE(img)];
}

+(void)attempDealloc{
    onceToken = 0; // 只有置成0,GCD才会认为它从未执行过.它默认为0.这样才能保证下次再次调用shareInstance的时候,再次创建对象.
    model = nil;
}



@end