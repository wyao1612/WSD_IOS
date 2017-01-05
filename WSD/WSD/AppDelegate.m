//
//  AppDelegate.m
//  WSD
//
//  Created by wyao on 2017/1/3.
//  Copyright © 2017年 Tsou. All rights reserved.
//

#import "AppDelegate.h"
#import "WSDTabBarController.h"
//#import <MJExtension.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


/** 进入主界面*/
- (void)entoMainUI{
    WSDTabBarController *tabBar = [[WSDTabBarController alloc] init];
    self.window.rootViewController = tabBar;
}
/** 设置SVProgessHUD*/
- (void)settingSVProgressHUD{
//    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:0.000 green:0.020 blue:0.059 alpha:0.85]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setMinimumDismissTimeInterval:1.0];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
}
/** 设置程序API*/
- (void)settingAPI{
    //初始化服务器，默认为正式服务器
    if (![GOLFUserDefault objectForKey:@"currentAPI"]) {
        [GOLFUserDefault setObject:HostAPI forKey:@"currentAPI"];
    }
}
/** 读取用户资料*/
- (void)readUserInfo{
//    NSDictionary *data = [GOLFUserDefault objectForKey:@"userInfo"];
//    if (data) {
//        [[UserModel sharedUserModel] mj_setKeyValues:data];
//        [[UserModel sharedUserModel] setIsLogin:NO];//初始化登录状态
//        //利用缓存数据。做一次登录请求刷新用户数据
//        NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:@{@"deviceType":@1,@"userName":[UserModel sharedUserModel].userName, @"password":[UserModel sharedUserModel].password}];
//        [ShareBusinessManager.loginManager postLoginWithParameters:dict success:^(id responObject) {
//            [[UserModel sharedUserModel] setIsLogin:YES];//修改登录状态
//        } failure:^(NSInteger errCode, NSString *errorMsg) {
//            [SVProgressHUD showErrorWithStatus:errorMsg];
//        }];
//    }
}




- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = BACKGROUNDCOLOR;
    [self settingSVProgressHUD];//设置HUD
    [self settingAPI];          //设置API
    //注册用户资料刷新
//    [GOLFNotificationCenter addObserver:self selector:@selector(readUserInfo) name:UserInfoUpdate object:nil];
    [self readUserInfo];        //读取用户资料
//    [self startLoacation];        //开启定位读取用户位置
//    [self settingUMAPI];            //设置友盟
    
    [self entoMainUI];//进入主界面
    [self.window makeKeyAndVisible];
    return YES;

}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
