//
//  WSDTabBarController.m
//  WSD
//
//  Created by wyao on 2017/1/3.
//  Copyright © 2017年 Tsou. All rights reserved.
//

#import "WSDTabBarController.h"


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
    NSMutableArray* vcs = [NSMutableArray array];
    
    [vcs addObject:[self loadChildViewControllerWithClassName:@"WSDHomeViewController" andImageName:@"bottom-home" andTitle:@"首页"]];
    [vcs addObject:[self loadChildViewControllerWithClassName:@"WSDNewsViewController" andImageName:@"bottom-msg" andTitle:@"消息"]];
    [vcs addObject:[self loadChildViewControllerWithClassName:@"WSDStudyViewController" andImageName:@"bottom-study" andTitle:@"学习"]];
    [vcs addObject:[self loadChildViewControllerWithClassName:@"WSDMeViewController" andImageName:@"bottom-user" andTitle:@"我的"]];
    self.viewControllers = vcs.copy;
    
    self.tabBar.tintColor = [UIColor colorWithHex:0x7c470a];
    
}
/**
 *  根据类名/图片名/标题 创建被导航控制器包好的子控制器
 */
- (UIViewController*)loadChildViewControllerWithClassName:(NSString*)className andImageName:(NSString*)imageName andTitle:(NSString*)title
{
    
    // 创建子控制器
    Class Clz = NSClassFromString(className);
    UIViewController* vc = [[Clz alloc] init];
    
    //    vc.title = title;
    vc.tabBarItem.title = title;
    
    // 获取image
    UIImage* image = [UIImage imageNamed:imageName];
    // 变成使用原始的图片
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 设置不选中图片
    vc.tabBarItem.image = image;
    
    // 获取image
    UIImage* imageSelected = [UIImage imageNamed:[imageName stringByAppendingString:@"-select"]];
    // 变成使用原始的图片
    imageSelected = [imageSelected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 设置选中图片
    vc.tabBarItem.selectedImage = imageSelected;
    
    // 创建导航控制器把他包起来
    WSDNavigationController* nav = [[WSDNavigationController alloc] initWithRootViewController:vc];
    
    return nav;
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
