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

/** 列表*/
@property (nonatomic, strong) UITableView *tableView;
/** 上半部数据*/
@property (nonatomic, strong) NSArray *listData_0;
/** 下半部数据*/
@property (nonatomic, strong) NSArray *listData_1;




@end

@implementation WSDMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.contentView.backgroundColor = WHITECOLOR;
    [self.contentView addSubview:self.topBackIv];//添加头部
    self.name = @"个人中心";
//    self.isAutoBack = NO;
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
    self.contentView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NaviBar_HEIGHT - 49);
    [self autoLayoutHeadIv];
    [self updateUI];//每次进入页面都会刷新数据
}

- (void)dealloc{
    [WSDNotificationCenter removeObserver:self];
}

#pragma mark ----------------自动布局

- (void)autoLayoutHeadIv{
    
    _topBackIv.sd_layout
    .topSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .leftSpaceToView(self.contentView, 0)
    .heightIs(125);
    
    _headIv.sd_layout
    .topSpaceToView(_topBackIv, 20)
    .leftSpaceToView(_topBackIv, 10)
    .heightIs(70)
    .widthEqualToHeight();
    
    _userNameLb.sd_layout
    .leftSpaceToView(_headIv, 15)
    .topSpaceToView(_topBackIv, 30)
    .heightIs(16);
    [_userNameLb setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH];
    

    _myHomeBtn.sd_layout
    .centerYEqualToView(_topBackIv)
    .rightSpaceToView(_topBackIv, 20)
    .heightIs(30)
    .widthIs(70);
    
}



#pragma mark ----------------数据初始化

/** 初始化数据*/
- (void)initData{
    NSString *listPath_0 = [[NSBundle mainBundle] pathForResource:@"MeList_0" ofType:@"plist"];
    _listData_0 = [[NSArray alloc] initWithContentsOfFile:listPath_0];
    NSString *listPath_1 = [[NSBundle mainBundle] pathForResource:@"MeList_1" ofType:@"plist"];
    _listData_1 = [[NSArray alloc] initWithContentsOfFile:listPath_1];

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
            {//进入我的订单
              
            }
                break;
            case 1:
            {//进入我的钱包
                
            }
                break;
            case 2:
            {//进入我的积分

            }
                break;
            case 3:
            {//进入我的荣誉

            }
                break;
            case 4:
            {//进入我的收藏

            }
            default:
                break;
        }
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


#pragma mark ----------------tableView代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return _listData_0.count;
    }
    return _listData_1.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.01;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"listCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//消除选中样式
    cell.textLabel.font = FONT(14);//设置标题大小
    cell.textLabel.textColor = SHENTEXTCOLOR;//设置标题颜色
    cell.accessoryView = [[UIImageView alloc] initWithImage:IMAGE(@"classify8")];//设置指示图
    cell.detailTextLabel.textColor = LIGHTTEXTCOLOR;//设置详请字体颜色
    cell.detailTextLabel.font = FONT(12);//设置详情字体大小
    
    NSDictionary *info;
    if (indexPath.section == 0) {
        info = _listData_0[indexPath.row];
       
    }else{
        info = _listData_1[indexPath.row];
    }
    cell.textLabel.text = info[@"title"];
    cell.imageView.image = IMAGE(info[@"image"]);
    return cell;
}

#pragma mark ----------------实例

- (UIImageView *)topBackIv{
    if (!_topBackIv) {
        _topBackIv = [[UIImageView alloc] init];
        _topBackIv.backgroundColor = GLOBALCOLOR;
        _topBackIv.image = IMAGE(@"classify91");
        _topBackIv.userInteractionEnabled = YES;
        [_topBackIv addSubview:self.headIv];
        [_topBackIv addSubview:self.userNameLb];
        [_topBackIv addSubview:self.myHomeBtn];
    }
    return _topBackIv;
    
}


- (UIImageView *)headIv{
    if (!_headIv) {
        _headIv = [[UIImageView alloc] init];
        _headIv.layer.borderColor = GLOBALCOLOR.CGColor;
        _headIv.layer.borderWidth = 2;
        _headIv.layer.cornerRadius = 32.5;
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
        _userNameLb.font = FONT(16);
        _userNameLb.textColor = BLACKCOLOR;
        _userNameLb.text = @"请登录";
    }
    return _userNameLb;
}


- (UIButton *)myHomeBtn{
    if (!_myHomeBtn) {
        _myHomeBtn = [[UIButton alloc] init];
        _myHomeBtn.titleLabel.font = FONT(14);
        [_myHomeBtn setTitle:@"个人资料" forState:UIControlStateNormal];
        [_myHomeBtn setTitleColor:BLACKCOLOR forState:UIControlStateNormal];
        [_myHomeBtn setImage:IMAGE(@"userInfo") forState:UIControlStateNormal];
        [_myHomeBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 60, 0, 0)];
        [_myHomeBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 15)];
        [_myHomeBtn addTarget:self action:@selector(topBackIvAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _myHomeBtn;
    
}


- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.frame = CGRectMake(0, 125, SCREEN_WIDTH, SCREEN_HEIGHT - 125 - 49);
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

