//
//  WSDHomeViewController.m
//  WSD
//  Created by wyao on 2017/1/3.
//  Copyright © 2017年 Tsou. All rights reserved.
//

#import "WSDHomeViewController.h"
#import "WSDHomeBtnListView.h"
#import "WSDSectionView.h"

#define TopScrollViewH 170
#define BtnOrderViewH  162
#define SectionViewH    48

@interface WSDHomeViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
SDCycleScrollViewDelegate
>
/** 搜索框*/
@property (nonatomic, strong) UIView *topNavView;
/** 推荐课程视图*/
@property (nonatomic, strong) UITableView *tableView;
/** 顶部轮播图*/
@property (nonatomic, strong) SDCycleScrollView *topScrollView;
/** 按钮菜单视图*/
@property (nonatomic, strong) WSDHomeBtnListView *btnOrderView;
/** 头部推荐课程视图*/
@property (nonatomic, strong) WSDSectionView *sectionView;
/** 头部视图*/
@property (nonatomic, strong) UIView *HeaderView;

@end

static  NSString *const kWSDHomeTableViewCell = @"kWSDHomeTableViewCell";

@implementation WSDHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    [self setupUI];
}
- (void)setupUI{
    
    self.view.backgroundColor = BACKGROUNDCOLOR;
    
    [self.view addSubview:self.topNavView];
    [self.view addSubview:self.tableView];
    [self requestData];
}

#pragma mark - titleView搜索框点击
-(void)titleViewTap:(UITapGestureRecognizer *)sender{
    [SVProgressHUD showSuccessWithStatus:@"点击搜索"];
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NaviBar_HEIGHT,SCREEN_WIDTH ,SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kWSDHomeTableViewCell];
        _tableView.tableHeaderView = self.HeaderView;
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
        _topScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0 , 0, SCREEN_WIDTH , TopScrollViewH)delegate:self placeholderImage:Placeholder_big];
        _topScrollView.backgroundColor = BACKGROUNDCOLOR;
        _topScrollView.placeholderImage = Placeholder_big;
        _topScrollView.autoScroll = YES;
    }
    return _topScrollView;
}
-(UIView *)btnOrderView{
    if (_btnOrderView == nil) {
        _btnOrderView = [[WSDHomeBtnListView alloc] initWithFrame:CGRectMake(0, TopScrollViewH, SCREEN_WIDTH, BtnOrderViewH)];
        _btnOrderView.backgroundColor = [UIColor orangeColor];
    }
    return _btnOrderView;
}


-(WSDSectionView *)sectionView{
    if (!_sectionView) {
        _sectionView = [[WSDSectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.btnOrderView.frame), SCREEN_WIDTH, SectionViewH)];
        _sectionView.backgroundColor = [UIColor orangeColor];
    }
    return _sectionView;
}

-(UIView *)HeaderView{
    if (_HeaderView == nil) {
        _HeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, TopScrollViewH + BtnOrderViewH + SectionViewH)];
        [_HeaderView addSubview:self.topScrollView];
        [_HeaderView addSubview:self.btnOrderView];
        [_HeaderView addSubview:self.sectionView];
    }
    return _HeaderView;
}

-(UIView *)topNavView{
    if (!_topNavView) {
        _topNavView= [[UIView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,64)];
        _topNavView.backgroundColor = [UIColor colorWithHex:0x2384ff];
        
        
        UIButton *iconBtn = [[UIButton alloc] init];
        iconBtn.frame = CGRectMake(15, 26, 35, 35);
        [_topNavView addSubview:iconBtn];
        iconBtn.sd_cornerRadius = @(35);
        
        
        UISearchBar *searchBar = [[UISearchBar alloc]init];
        searchBar.frame = CGRectMake(CGRectGetMaxX(iconBtn.frame),26,SCREEN_WIDTH-70,35);
        searchBar.layer.cornerRadius = 18;
        searchBar.layer.masksToBounds =YES;
        //边框线粗细
        [searchBar.layer setBorderWidth:8];
        //设置边框为白色是为了盖住UISearchBar上的灰色
        [searchBar.layer setBorderColor:[UIColor whiteColor].CGColor];
        searchBar.placeholder=@"搜索";
        searchBar.userInteractionEnabled = NO;
        [_topNavView addSubview:searchBar];
        UITapGestureRecognizer *titleViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleViewTap:)];
        [_topNavView addGestureRecognizer:titleViewTap];
        
        
    }
    
    return _topNavView;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
