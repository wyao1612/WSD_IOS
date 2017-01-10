//
//  PopListTableViewController.m
//  WSD
//
//  Created by wyao on 2017/1/10.
//  Copyright © 2017年 Tsou. All rights reserved.
//

#import "PopListTableViewController.h"
#import "AccountTableViewCell.h"
#import "UserModel.h"

#define inputH 35  // 输入框高


@interface PopListTableViewController ()

@end

@implementation PopListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
    self.tableView.layer.borderWidth = 0.5;
    self.tableView.separatorColor = GRAYCOLOR;;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _isOpen = NO;
}


#pragma mark - 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 展开与隐藏账号列表
    if(_isOpen)
        return _accountSource.count;
    else
        return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *specialId = @"id";
    AccountTableViewCell *cell = [[AccountTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:specialId];
    // 添加数据源
    UserModel  *acc = _accountSource[indexPath.row];
    cell.accountModel = acc;
    return cell;
}

// cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

// cell选中事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 通知代理
    if (self.delegate !=nil) {
        if ([self.delegate respondsToSelector:@selector(PopListTableViewSelectedCell:)]) {
            [self.delegate PopListTableViewSelectedCell:indexPath.row];
        }
    }
}

// 打开cell滑动编辑
- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// 删除按钮的显示文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

// cell删除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_accountSource removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
        
        // 通知代理
        if (self.delegate !=nil) {
            if ([self.delegate respondsToSelector:@selector(PopListTableViewUpdateListHeight)]) {
                [self.delegate PopListTableViewUpdateListHeight];
            }
        }
    }
}

@end
