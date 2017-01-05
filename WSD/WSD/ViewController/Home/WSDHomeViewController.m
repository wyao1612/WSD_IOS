//
//  WSDHomeViewController.m
//  WSD
//  Created by wyao on 2017/1/3.
//  Copyright © 2017年 Tsou. All rights reserved.
//

#import "WSDHomeViewController.h"

@interface WSDHomeViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
SDCycleScrollViewDelegate
>
/** 推荐课程视图*/
@property (nonatomic, strong) UITableView *tableView;
/** 顶部轮播图*/
@property (nonatomic, strong) SDCycleScrollView *topScrollView;

@end

static  NSString *const kWSDHomeTableViewCell = @"kWSDHomeTableViewCell";

@implementation WSDHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}
- (void)setupUI{
    
    self.view.backgroundColor = BACKGROUNDCOLOR;
    UILabel *titleLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 100, 17)];
    titleLb.font = FONT(17);
    titleLb.textAlignment = NSTextAlignmentCenter;
    titleLb.textColor = BLACKTEXTCOLOR;
    titleLb.text = @"维思得英语";
    [self.navigationItem setTitleView:titleLb];
    [self.view addSubview:self.tableView];
    [self requestData];
}

#pragma mark - 请求数据
- (void)requestData{
  
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 20;
}
/** 组头部视图*/
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor orangeColor];
    return view;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kWSDHomeTableViewCell];
    cell.textLabel.text = @(indexPath.row).description;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    CGFloat height = [_tableView cellHeightForIndexPath:indexPath cellContentViewWidth:SCREEN_WIDTH tableView:_tableView];
//    return height;
    return 44;

}



#pragma mark - 懒加载控件
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH ,SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kWSDHomeTableViewCell];
        _tableView.tableHeaderView = self.topScrollView;
        weak(self);
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            [weakSelf requestData];
            [weakSelf.tableView.mj_header endRefreshing];
        }];
    }
    return _tableView;
}

- (SDCycleScrollView *)topScrollView{
    if (_topScrollView == nil) {
        _topScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0 , 0, SCREEN_WIDTH , 145)delegate:self placeholderImage:Placeholder_big];
        _topScrollView.backgroundColor = BACKGROUNDCOLOR;
        _topScrollView.placeholderImage = Placeholder_big;
        _topScrollView.autoScroll = YES;
    }
    return _topScrollView;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
