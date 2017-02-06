//
//  WSDHomeViewController.m
//  WSD
//  Created by wyao on 2017/1/3.
//  Copyright © 2017年 Tsou. All rights reserved.
//

#import "WSDHomeViewController.h"
#import "WSDHomeBtnListView.h"
#import "WSDSeacherViewController.h"
#import "WSDHomeTableViewCell.h"
#import "PopListTableViewController.h"
#import "UserModel.h"

#define TopScrollViewH 170
#define BtnOrderViewH  162
#define SectionViewH    48

#define inputW 230 // 输入框宽度
#define inputH 60  // 输入框高度

@interface WSDHomeViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
SDCycleScrollViewDelegate,
PopListTableViewAccountDelegate,
WSDHomeBtnListViewDelegate
>
/** 头部头像*/
@property (nonatomic, strong) UIImageView *iconImageView;
/** 下拉按钮*/
@property (nonatomic, strong) UIButton *listBtn;
/** 搜索框*/
@property (nonatomic, strong) UIImageView *searchImageView;
/** 蓝色竖条*/
@property (nonatomic, strong) UIImageView *blueSilderView;
/** 推荐课程label*/
@property (nonatomic, strong) UILabel *classLabel;
/** 查看更多按钮*/
@property (nonatomic, strong) UIButton *moreBtn;

/** 头部视图*/
@property (nonatomic, strong) UIView *HeaderView;
/** 顶部轮播图*/
@property (nonatomic, strong) SDCycleScrollView *topScrollView;
/** 推荐课程视图*/
@property (nonatomic, strong) UITableView *tableView;
/** 按钮菜单视图*/
@property (nonatomic, strong) WSDHomeBtnListView *btnOrderView;
/** 头部推荐课程视图*/
@property (nonatomic, strong) UIView *sectionView;

/** 账号数据*/
@property (nonatomic) NSMutableArray *dataSource;
/** 账号下拉列表*/
@property (nonatomic, strong) PopListTableViewController *accountList;
/** 下拉列表的frame*/
@property (nonatomic) CGRect listFrame;
/** 下拉菜单蒙版*/
@property (nonatomic, strong) UIView *coverView;


@end

static  NSString *const kWSDHomeTableViewCell = @"kWSDHomeTableViewCell";

@implementation WSDHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self setPopMenu];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:GLOBALCOLOR] forBarMetrics:UIBarMetricsDefault];
    [self setNav];
}

-(void)setNav{

    //两个按钮的父类view
    UIView *rightButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    self.iconImageView.frame = CGRectMake(0, 0, 40, 40);
    [rightButtonView addSubview:self.iconImageView];
    self.listBtn.frame = CGRectMake(50, 20, 10, 10);
    [rightButtonView addSubview:self.listBtn];
    UIBarButtonItem *rightCunstomButtonView = [[UIBarButtonItem alloc] initWithCustomView:rightButtonView];
    self.navigationItem.leftBarButtonItem = rightCunstomButtonView;
}


- (void)setupUI{
    self.view.backgroundColor = BACKGROUNDCOLOR;
    [self.view addSubview:self.tableView];
}

#pragma mark - titleView搜索框点击
-(void)titleViewTap:(UITapGestureRecognizer *)sender{
    [SVProgressHUD showSuccessWithStatus:@"点击搜索"];
}
#pragma mark - 头像按钮点击
- (void)iconImageViewTap:(UITapGestureRecognizer *)sender{
  [self openAccountList];
}


#pragma mark - 设置下拉菜单
- (void)setPopMenu {
    // 从工程plist文件读取账号模型数据
    _dataSource = [UserModel mj_objectArrayWithFilename:@"account.plist"];
    // 设置账号弹出菜单(最后添加显示在顶层)
    self.accountList.accountSource = _dataSource;
    // 初始化frame
    [self PopListTableViewUpdateListHeight];
    // 隐藏下拉菜单
    self.accountList.view.frame = CGRectZero;
    [self addChildViewController:self.accountList];
    
    _accountList.isOpen = NO;
}

#pragma mark - 弹出关闭账号选择列表
- (void)openAccountList {
    _accountList.isOpen = !_accountList.isOpen;
    if (_accountList.isOpen) {
        NSLog(@"打开");
        // 添加对应蒙版
        self.coverView.hidden = NO;
        self.accountList.view.hidden = NO;
        [self.view addSubview:self.accountList.view];
        // 设置内容的高度
        CGFloat height = inputH * (_dataSource.count +1);
        self.accountList.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0);
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = self.accountList.view.frame;
            frame.size.height = height;
            self.accountList.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
        } ];
    }
    else {
        [self coverViewdismiss];
    }
}

#pragma mark - 下拉菜单的代理方法
#pragma mark - 监听代理选定cell获取选中账号
- (void)PopListTableViewSelectedCell:(NSInteger)index {
    // 关闭菜单
     [self coverViewdismiss];
}
#pragma mark - 监听代理更新下拉菜单
- (void)PopListTableViewUpdateListHeight {
    CGFloat listH;
    // 数据大于3个现实3个半的高度，否则显示完整高度
//    if (_dataSource.count > 3) {
//        listH = inputH * 3.5;
//    }else{
        listH = inputH * (_dataSource.count +1);
//    }
    _listFrame = CGRectMake(0, 64, SCREEN_WIDTH, listH);
}

- (UIView *)coverView
{
    if (_coverView == nil) {
        // 设置蒙版的frame
        _coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _coverView.backgroundColor = [UIColor colorWithHex:0x474747];
        _coverView.userInteractionEnabled = YES;
        [self.view addSubview:_coverView];
        UITapGestureRecognizer *overViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverViewdismiss)];
        [_coverView addGestureRecognizer:overViewTap];
    }
    return _coverView;
}

#pragma mark - 按钮菜单的点击方法
-(void)WSDHomeBtnListViewClick:(UIButton *)sender{
    NSLog(@"点击%ld跳转",sender.tag);
    switch (sender.tag) {
        case 0:
            //学习进度
            break;
        case 1:
            //在线报名
            break;
        case 2:
            //成绩查询
        {
            WSDScoreViewController *scoreVc = [[WSDScoreViewController alloc] init];
            [self.navigationController pushViewController:scoreVc animated:YES];
        }
            break;
        case 3:
            //在线测试
            break;
        case 4:
            //双优课堂
            break;
        case 5:
            //站内活动
        {
            [self presentViewController:LoginNavi animated:YES completion:nil];
        }
            break;
            
        default:
            break;
    }
    
}

#pragma mark - 下拉菜单弹回
- (void)coverViewdismiss
{
    
    NSLog(@"关闭");
    self.accountList.isOpen = NO;
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.accountList.view.frame;
        frame.size.height = 0;
        self.accountList.view.frame = frame;
        // 移除蒙版
        self.coverView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    } completion:^(BOOL finished) {
        self.coverView.hidden = YES;
        self.coverView.backgroundColor = [UIColor colorWithHex:0x474747];
         self.accountList.view.hidden = YES;
    }];
}


-(void)searchImageViewTap:(UITapGestureRecognizer *)sender{
    WSDSeacherViewController *vc = [[WSDSeacherViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)moreBtnClick:(UIButton*)sender{
    [SVProgressHUD showSuccessWithStatus:@"查看更多"];
}



#pragma mark --下拉刷新数据
- (void)LoadNewData {
    
}

#pragma mark --上拉加载更多数据
- (void)LoadMoreData {
   
}

#pragma mark -  布局推荐课程视图
-(void)layoutSectionsubView{
    [self.sectionView addSubview:self.blueSilderView];
    [self.sectionView addSubview:self.classLabel];
    [self.sectionView addSubview:self.moreBtn];
    
    self.blueSilderView.sd_layout
    .topSpaceToView(self.sectionView,16)
    .leftSpaceToView(self.sectionView,10)
    .widthIs(3)
    .heightIs(13);

    self.classLabel.sd_layout
    .centerYEqualToView(self.blueSilderView)
    .leftSpaceToView(self.blueSilderView,8)
    .autoHeightRatio(0);
     [self.classLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    self.moreBtn.sd_layout
    .topSpaceToView(self.sectionView,18)
    .rightSpaceToView(self.sectionView,10)
    .heightIs(15)
    .widthIs(80);
    
    [self.moreBtn setTitleRespectToImageWithStyle:WYCustomerButtonStyleLeft Margin:6 addTarget:nil];
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [SVProgressHUD showSuccessWithStatus:@"点击跳转"];
}
#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WSDHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kWSDHomeTableViewCell];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    CGFloat height = [_tableView cellHeightForIndexPath:indexPath cellContentViewWidth:SCREEN_WIDTH tableView:_tableView];
    return height;
}

#pragma mark - 懒加载控件
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH ,SCREEN_HEIGHT - 49) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorColor = GRAYCOLOR;;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        [_tableView registerClass:[WSDHomeTableViewCell class] forCellReuseIdentifier:kWSDHomeTableViewCell];
        _tableView.tableHeaderView = self.HeaderView;
        
        weak(self);
        //设置下拉刷新
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf LoadNewData];
            [_tableView.mj_header endRefreshing];
            
        }];
        _tableView.mj_header.automaticallyChangeAlpha = YES;
        
        //设置上拉加载更多
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [weakSelf LoadMoreData];
            [_tableView.mj_footer endRefreshing];
        }];
    
    }
    return _tableView;
}

- (SDCycleScrollView *)topScrollView{
    if (_topScrollView == nil) {
        _topScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0 , 0, SCREEN_WIDTH , TopScrollViewH) delegate:self placeholderImage:Placeholder_big];
        _topScrollView.backgroundColor = BACKGROUNDCOLOR;
        _topScrollView.placeholderImage = Placeholder_big;
        _topScrollView.autoScroll = YES;
        _topScrollView.showPageControl = YES;
        _topScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        _topScrollView.currentPageDotColor = GLOBALCOLOR;
        _topScrollView.pageControlDotSize = CGSizeMake(8, 8);
        _topScrollView.localizationImageNamesGroup = @[@"sd2", @"sd2",@"sd2"];
    }
    return _topScrollView;
}
-(UIView *)btnOrderView{
    if (_btnOrderView == nil) {
        _btnOrderView = [[WSDHomeBtnListView alloc] initWithFrame:CGRectMake(0, TopScrollViewH, SCREEN_WIDTH, BtnOrderViewH)];
        _btnOrderView.backgroundColor = [UIColor orangeColor];
        _btnOrderView.delegate = self;
    }
    return _btnOrderView;
}


-(UIView *)sectionView{
    if (!_sectionView) {
        _sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.btnOrderView.frame) + 1, SCREEN_WIDTH, SectionViewH)];
        _sectionView.backgroundColor = WHITECOLOR;
        [self layoutSectionsubView];
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

-(UIImageView *)iconImageView{
    if(!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.image = [Placeholder_small circleImage];
        _iconImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *iconImageViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconImageViewTap:)];
        [_iconImageView addGestureRecognizer:iconImageViewTap];
    }
    return _iconImageView;
}

-(UIButton *)listBtn{
    if (!_listBtn) {
        _listBtn = [[UIButton alloc] init];
        [_listBtn setBackgroundImage:[UIImage imageNamed:@"classify1"] forState:UIControlStateNormal];
        [_listBtn setBackgroundImage:[UIImage imageNamed:@"classify1"] forState:UIControlStateSelected];
//        _listBtn.userInteractionEnabled = YES;
//        [_listBtn addTarget:self action:@selector(listBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _listBtn;
}

-(UIImageView *)searchImageView{
    if(!_searchImageView) {
        _searchImageView = [[UIImageView alloc] init];
        _searchImageView.image = [UIImage imageNamed:@"test"];
        _searchImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *searchImageViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchImageViewTap:)];
        [_searchImageView addGestureRecognizer:searchImageViewTap];
    }
    return _searchImageView;
}

-(UIImageView *)blueSilderView{
    if (!_blueSilderView) {
        _blueSilderView = [[UIImageView alloc] init];
        _blueSilderView.image = [UIImage imageNamed:@"classify8"];
    }
    return _blueSilderView;
}
-(UILabel *)classLabel{
    if (!_classLabel) {
     _classLabel = [UILabel labelWithText:@"推荐课程" andTextColor:SHENTEXTCOLOR andFontSize:14];
    }
    return _classLabel;
}
- (UIButton *)moreBtn{
    if (!_moreBtn) {
        _moreBtn = [[UIButton alloc] init];
        [_moreBtn setTitle:@"查看全部" forState:UIControlStateNormal];
        [_moreBtn setImage:IMAGE(@"more") forState:UIControlStateNormal];
        _moreBtn.backgroundColor = WHITECOLOR;
        _moreBtn.tag = 100;
        _moreBtn.titleLabel.font = FONT(12);
        [_moreBtn setTitleColor:SHENTEXTCOLOR forState:UIControlStateNormal];
        [_moreBtn addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreBtn;
}



-(PopListTableViewController *)accountList{
    if (!_accountList) {
        _accountList = [[PopListTableViewController alloc] init];
        _accountList.delegate = self;
    }
    return _accountList;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
