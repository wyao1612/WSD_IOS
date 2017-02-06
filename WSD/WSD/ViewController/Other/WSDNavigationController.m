//
//  WSDNavigationController.m
//  WSD
//
//  Created by wyao on 16/10/25.
//  Copyright © 2016年 Tsou. All rights reserved.
//

#import "WSDNavigationController.h"

@interface WSDNavigationController ()

@end

@implementation WSDNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
#define iOS10 ([[UIDevice currentDevice].systemVersion intValue]>=10?YES:NO)
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar.subviews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        if (iOS10) {
            //iOS10,改变了导航栏的私有接口为_UIBarBackground
            if ([view isKindOfClass:NSClassFromString(@"_UIBarBackground")]) {
                
                [view.subviews firstObject].hidden = YES;
            }
        }else{
            //iOS10之前使用的是_UINavigationBarBackground
            if ([view isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")]) {
                
                [view.subviews firstObject].hidden = YES;
            }
        }
    }];
}

- (void)pushViewController:(UIViewController*)viewController animated:(BOOL)animated
{
    
    // 如果这个控制器不是第一个控制器,那么应该设置隐藏tabbar的属性
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
