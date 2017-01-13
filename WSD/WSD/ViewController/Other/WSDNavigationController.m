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
