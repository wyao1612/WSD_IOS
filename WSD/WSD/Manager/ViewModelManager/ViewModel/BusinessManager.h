//
//  BusinessManager.h
//  GolfIOS
//
//  Created by 张永亮 on 2016/10/24.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LoginManager;            //登录
@class UserManager;             //个人
@class HomeManager;             //首页

@interface BusinessManager : NSObject
/** 登录*/
@property (nonatomic, strong) LoginManager *loginManager;
/** 个人*/
@property (nonatomic, strong) UserManager *userManager;
/**首页*/
@property (nonatomic, strong) HomeManager *homeManager;



/*********************************************************************
 函数名称 : shareBusinessManager:
 函数描述 : 共享默认实例` BusinessManager `。
 输入参数 :
 输出参数 :
 返回值 :
 作者   : 张永亮
 *********************************************************************/
+ (instancetype)shareBusinessManager;

@end
