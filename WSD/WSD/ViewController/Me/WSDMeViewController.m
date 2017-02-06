//
//  WSDMeViewController.m
//  WSD
//
//  Created by wyao on 2017/1/3.
//  Copyright © 2017年 Tsou. All rights reserved.
//

#import "WSDMeViewController.h"
@interface WSDMeViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>

/** 头部背景图*/
@property (nonatomic, strong) UIImageView *topBackIv;
/** 头像*/
@property (nonatomic, strong) UIImageView *headIv;
/** 用户昵称*/
@property (nonatomic, strong) UILabel *userNameLb;
/** 我的社区按钮*/
@property (nonatomic, strong) UIButton *myHomeBtn;
/** ID*/
@property (nonatomic, strong) UILabel *IDLabel;

/** 列表*/
@property (nonatomic, strong) UITableView *tableView;
/** 第一部数据*/
@property (nonatomic, strong) NSArray *listData_0;
/** 第二部数据*/
@property (nonatomic, strong) NSArray *listData_1;
/** 第三部数据*/
@property (nonatomic, strong) NSArray *listData_2;



@end

@implementation WSDMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.contentView.backgroundColor = BACKGROUNDCOLOR;
    [self.contentView addSubview:self.topBackIv];//添加头部
    self.name = @"个人中心";
    self.showBack = NO;
    self.rightIm_0 = IMAGE(@"setting");
    [self.contentView addSubview:self.tableView];//添加列表
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    self.contentView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.contentView.scrollEnabled = YES;
    [self autoLayoutHeadIv];
    [self updateUI];//每次进入页面都会刷新数据
}

- (void)dealloc{
    [WSDNotificationCenter removeObserver:self];
}

#pragma mark - 自动布局

- (void)autoLayoutHeadIv{
    
    _topBackIv.sd_layout
    .topSpaceToView(self.contentView, 20)
    .rightSpaceToView(self.contentView, 0)
    .leftSpaceToView(self.contentView, 0)
    .heightIs(120);
    
    _headIv.sd_layout
    .topSpaceToView(_topBackIv, 20)
    .leftSpaceToView(_topBackIv, 10)
    .heightIs(70)
    .widthIs(70);
    
    _userNameLb.sd_layout
    .leftSpaceToView(_headIv, 15)
    .topSpaceToView(_topBackIv, 30)
    .heightIs(16);
    [_userNameLb setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH];
    
    _IDLabel.sd_layout
    .topSpaceToView(_userNameLb,18)
    .leftSpaceToView(_headIv,15)
    .autoHeightRatio(0);
    [_IDLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    _myHomeBtn.sd_layout
    .centerYEqualToView(_topBackIv)
    .rightSpaceToView(_topBackIv, 15)
    .heightIs(30)
    .widthIs(7);
    
}



#pragma mark ----------------数据初始化

/** 初始化数据*/
- (void)initData{
    NSString *listPath_0 = [[NSBundle mainBundle] pathForResource:@"MeList_0" ofType:@"plist"];
    _listData_0 = [[NSArray alloc] initWithContentsOfFile:listPath_0];
    NSString *listPath_1 = [[NSBundle mainBundle] pathForResource:@"MeList_1" ofType:@"plist"];
    _listData_1 = [[NSArray alloc] initWithContentsOfFile:listPath_1];
    NSString *listPath_2 = [[NSBundle mainBundle] pathForResource:@"MeList_2" ofType:@"plist"];
    _listData_2 = [[NSArray alloc] initWithContentsOfFile:listPath_2];

}
/** 刷新界面*/
- (void)updateUI{
    UserModel *model = [UserModel sharedUserModel];
    //更新头像
    [_headIv sd_setImageWithURL:FULLIMGURL(model.headUrl) placeholderImage:Placeholder_small];
    //昵称更新,有昵称显示昵称,没有显示手机号
    _userNameLb.text = model.nickName;
    if ([model.nickName length]) {
        _userNameLb.text = model.nickName;
    }else{
        _userNameLb.text = model.userName;
    }
    [_tableView reloadData];
    
    
}

#pragma mark - 界面逻辑
/** 导航栏右侧进入设置界面*/
- (void)right_0_action{
    SettingViewController *settingVc = [[SettingViewController alloc] init];
    [self.navigationController pushViewController:settingVc animated:YES];
}
/** 进入各次级页面*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //判断登录
    //    if (!IsLogin) {
    //        [self presentViewController:LoginNavi animated:YES completion:nil];
    //        return;
    //    }
    //
    
    if (indexPath.section == 0) {
        
        switch (indexPath.row) {
            case 0:
            {//进入我的课程表
              
            }
                break;
            case 1:
            {//进入我的订单
                
            }
                break;
            case 2:
            {//进入我的活动

            }
                break;
            case 3:
            {//进入班级关注

            }
                break;
            default:
                break;
        }
    }    
    else if (indexPath.section == 1 && indexPath.row == 0) {
        //进入帮助中心
    }
    else if (indexPath.section == 2 && indexPath.row == 0 ){
        //进入关于我们
    }
}

/** 点击头像视图*/
- (void)topBackIvAction{
    if (!IsLogin) {
//        [self presentViewController:LoginNavi animated:YES completion:nil];
    }else{
        //进入个人资料界面
        UserInfoViewController *infoVc = [[UserInfoViewController alloc] init];
        [self.navigationController pushViewController:infoVc animated:YES];
    }
}


#pragma mark - tableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return _listData_0.count;
    }else if(section == 1){
        return _listData_1.count;
    }
    return _listData_2.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"listCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//消除选中样式
    cell.textLabel.font = FONT(14);//设置标题大小
    cell.textLabel.textColor = SHENTEXTCOLOR;//设置标题颜色
    cell.accessoryView = [[UIImageView alloc] initWithImage:IMAGE(@"more")];//设置指示图
    cell.detailTextLabel.textColor = LIGHTTEXTCOLOR;//设置详请字体颜色
    cell.detailTextLabel.font = FONT(12);//设置详情字体大小
    
    NSDictionary *info;
    if (indexPath.section == 0) {
        info = _listData_0[indexPath.row];
    }else if(indexPath.section == 1){
        info = _listData_1[indexPath.row];
    }else{
       info = _listData_2[indexPath.row];
    }
    cell.textLabel.text = info[@"title"];
    cell.imageView.image = IMAGE(info[@"image"]);
    return cell;
}

#pragma mark - 实例

- (UIImageView *)topBackIv{
    if (!_topBackIv) {
        _topBackIv = [[UIImageView alloc] init];
        _topBackIv.backgroundColor = WHITECOLOR;
        _topBackIv.image = IMAGE(@"classify91");
        _topBackIv.userInteractionEnabled = YES;
        [_topBackIv addSubview:self.headIv];
        [_topBackIv addSubview:self.userNameLb];
        [_topBackIv addSubview:self.myHomeBtn];
        [_topBackIv addSubview:self.IDLabel];
    }
    return _topBackIv;
    
}


- (UIImageView *)headIv{
    if (!_headIv) {
        _headIv = [[UIImageView alloc] init];
        _headIv.layer.borderColor = WHITECOLOR.CGColor;
//        _headIv.layer.borderWidth = 1.0f;
        _headIv.layer.cornerRadius = 35.0f;
        _headIv.image = Placeholder_small;
        _headIv.userInteractionEnabled = YES;
        _headIv.clipsToBounds = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topBackIvAction)];
        [_headIv addGestureRecognizer:tap];
    }
    return _headIv;
}

- (UILabel *)userNameLb{
    if (!_userNameLb) {
        _userNameLb= [[UILabel alloc] init];
        _userNameLb.font = FONT(15);
        _userNameLb.textColor = SHENTEXTCOLOR;
        _userNameLb.text = @"请登录";
    }
    return _userNameLb;
}
- (UILabel *)IDLabel{
    if (!_IDLabel) {
        _IDLabel= [[UILabel alloc] init];
        _IDLabel.font = FONT(12);
        _IDLabel.textColor = LIGHTTEXTCOLOR;
        _IDLabel.text = @"ID: 989898";
    }
    return _IDLabel;
}


- (UIButton *)myHomeBtn{
    if (!_myHomeBtn) {
        _myHomeBtn = [[UIButton alloc] init];
        [_myHomeBtn setImage:IMAGE(@"more") forState:UIControlStateNormal];
        [_myHomeBtn addTarget:self action:@selector(topBackIvAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _myHomeBtn;
    
}


- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.frame = CGRectMake(0, 160, SCREEN_WIDTH, SCREEN_HEIGHT - 125 - 49);
        _tableView.backgroundColor = BACKGROUNDCOLOR;
        _tableView.separatorColor = GRAYCOLOR;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"listCell"];
    }
    return _tableView;
}

@end

