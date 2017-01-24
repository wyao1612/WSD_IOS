//
//  ViewModelFactory.h
//  WSD
//
//  Created by wyao on 2017/1/4.
//  Copyright © 2017年 Tsou. All rights reserved.
//

/** 处理所有页面的viewModel的管理的工厂方法*/
#import <Foundation/Foundation.h>


@class LoginManager;            //登录
@class UserManager;             //个人
@class HomeManager;             //首页


@interface BusinessFactory : NSObject
/** 创建登录*/
- (LoginManager *)createLoginManager;
/** 创建个人*/
- (UserManager *)createUserManager;
/** 创建首页*/
- (HomeManager *)createHomeManager;

@end
