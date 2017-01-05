//
//  WSDTabBarController.m
//  WSD
//
//  Created by wyao on 2017/1/3.
//  Copyright © 2017年 Tsou. All rights reserved.
//

#import "WSDTabBarController.h"
#import "WSDHomeViewController.h"
#import "WSDNewsViewController.h"
#import "WSDStudyViewController.h"
#import "WSDMeViewController.h"

@interface WSDTabBarController ()

@end

@implementation WSDTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupChildVcs];
    [self setupItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 * 添加所有的子控制器
 */
- (void)setupChildVcs
{
    [self setupChildVc:[[WSDHomeViewController alloc] init] title:@"首页" image:@"classify24" selectedImage:@"classify20"];
    [self setupChildVc:[[WSDNewsViewController alloc] init] title:@"消息" image:@"classify25" selectedImage:@"classify21"];
    [self setupChildVc:[[WSDStudyViewController alloc] init] title:@"学习" image:@"classify26" selectedImage:@"classify22"];
    [self setupChildVc:[[WSDMeViewController alloc] init] title:@"我的" image:@"classify27" selectedImage:@"classify23"];
    
}

/**
 * 添加一个子控制器
 * @param title 文字
 * @param image 图片
 * @param selectedImage 选中时的图片
 */
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    [self addChildViewController:nav];
    
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [UIImage imageNamed:image];
    nav.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
}

/**
 * 设置item属性
 */
- (void)setupItem
{
    
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = SHENTEXTCOLOR;
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    
    selectedAttrs[NSForegroundColorAttributeName] = GLOBALCOLOR;
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

@end
