//
//  WSDForgetPassWordViewController.m
//  WSD
//
//  Created by wyao on 2017/1/24.
//  Copyright © 2017年 Tsou. All rights reserved.
//

#import "WSDForgetPassWordViewController.h"

@interface WSDForgetPassWordViewController ()

@end

@implementation WSDForgetPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.name = @"重置密码";
    self.isAutoBack = NO;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:GLOBALCOLOR] forBarMetrics:UIBarMetricsDefault];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
