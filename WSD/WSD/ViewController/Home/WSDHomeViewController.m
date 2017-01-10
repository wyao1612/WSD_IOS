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

#define TopScrollViewH 170
#define BtnOrderViewH  162
#define SectionViewH    48

@interface WSDHomeViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
SDCycleScrollViewDelegate,
UISearchBarDelegate
>
/** 头部视图*/
@property (nonatomic, strong) UIView *topNavView;
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


@end

static  NSString *const kWSDHomeTableViewCell = @"kWSDHomeTableViewCell";

@implementation WSDHomeViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
#pragma mark - 头像点击
-(void)iconImageViewTap:(UITapGestureRecognizer *)sender{
     [SVProgressHUD showSuccessWithStatus:@"更换头像"];
}
-(void)searchImageViewTap:(UITapGestureRecognizer *)sender{
    WSDSeacherViewController *vc = [[WSDSeacherViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)moreBtnClick:(UIButton*)sender{
    [SVProgressHUD showSuccessWithStatus:@"查看更多"];
}


#pragma mark - 请求数据
- (void)requestData{
  
}

#pragma mark -  布局头部视图
-(void)layoutTopNavSubviews{
    
    self.iconImageView.sd_layout
    .topSpaceToView(self.topNavView,24)
    .leftSpaceToView(self.topNavView,12)
    .widthIs(35)
    .heightIs(35);
    
    self.listBtn.sd_layout
    .centerYEqualToView(self.iconImageView)
    .leftSpaceToView(self.iconImageView,4)
    .widthIs(6)
    .heightIs(4);
    
    
    self.searchImageView.sd_layout
    .centerYEqualToView(self.iconImageView)
    .leftSpaceToView(self.listBtn,8)
    .rightSpaceToView(self.topNavView,10)
    .heightIs(35);
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NaviBar_HEIGHT,SCREEN_WIDTH ,SCREEN_HEIGHT - 64 - 49) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorColor = GRAYCOLOR;;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        [_tableView registerClass:[WSDHomeTableViewCell class] forCellReuseIdentifier:kWSDHomeTableViewCell];
        _tableView.tableHeaderView = self.HeaderView;
        
        
        
        weak(self);
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [weakSelf requestData];
            
        }];
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf requestData];
            [weakSelf.tableView.mj_header endRefreshing];
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

-(UIView *)topNavView{
    if (!_topNavView) {
        _topNavView= [[UIView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,64)];
        _topNavView.backgroundColor = GLOBALCOLOR;
        
        [_topNavView addSubview:self.iconImageView];
        [_topNavView addSubview:self.listBtn];
        [_topNavView addSubview:self.searchImageView];
        
        [self layoutTopNavSubviews];
    }
    
    return _topNavView;
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
        _listBtn.userInteractionEnabled = NO;
        //[_listBtn addTarget:self action:@selector(listBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _listBtn;
}

-(UIImageView *)searchImageView{
    if(!_searchImageView) {
        _searchImageView = [[UIImageView alloc] init];
        _searchImageView.image = [UIImage imageNamed:@"test"];
        _searchImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *iconImageViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchImageViewTap:)];
        [_searchImageView addGestureRecognizer:iconImageViewTap];
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
