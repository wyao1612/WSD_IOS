//
//  PopListTableViewController.m
//  WSD
//
//  Created by wyao on 2017/1/10.
//  Copyright © 2017年 Tsou. All rights reserved.
//

#import "PopListTableViewController.h"
#import "AccountTableViewCell.h"


static NSString * const ID = @"cell";

@interface PopListTableViewController ()
@property (nonatomic, assign) NSInteger selectedCol;
@property (nonatomic, strong) UIView* footView;
@property (nonatomic, strong) NSIndexPath* SelectedIndexPath;
@end

@implementation PopListTableViewController

-(UIView *)footView{
    if (!_footView) {
        _footView = [[UIView alloc] init];
        _footView.backgroundColor = [UIColor orangeColor];
        _footView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 60);
    }
    return _footView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _selectedCol = 0;
    _isOpen = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
    self.tableView.layer.borderWidth = 0.5;
    self.tableView.separatorColor = GRAYCOLOR;;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.tableFooterView = self.footView;
    [self.tableView registerClass:[AccountTableViewCell class] forCellReuseIdentifier:ID];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:_selectedCol inSection:0];
    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
}


#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 展开与隐藏账号列表
    if(_isOpen)
        return _accountSource.count;
    else
        return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AccountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    // 添加数据源
    UserModel  *acc = _accountSource[indexPath.row];
    cell.accountModel = acc;
    if (indexPath.row == 0) {
        [cell setSelected:YES animated:NO];
    }
    
    return cell;
}

// cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

// cell选中事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"-------->选中第%ld行",indexPath.row);

    // 判断记录的位置是否和上一次相同,(是否是左侧同一个cell点了两下)
    if (self.SelectedIndexPath == indexPath) {
        return;
    }
    // 记录一下当前选中的左侧的位置
    self.SelectedIndexPath = indexPath;

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
