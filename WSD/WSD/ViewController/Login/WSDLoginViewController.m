//
//  WSDLoginViewController.m
//  WSD
//
//  Created by wyao on 2017/1/23.
//  Copyright © 2017年 Tsou. All rights reserved.
//

#import "WSDLoginViewController.h"

@interface WSDLoginViewController ()
/** 左上返回*/
@property (nonatomic, strong) UIButton *leftBackBtn;
/** logo*/
@property (nonatomic, strong) UIImageView *logoIv;
/** 登录模块*/
@property (nonatomic, strong) UIView *loginView;
/** 电话输入框图标*/
@property (nonatomic, strong) UIImageView *phoneTfView;
/** 电话输入框*/
@property (nonatomic, strong) UITextField *phoneTf;
/** 密码输入框图标*/
@property (nonatomic, strong) UIImageView *passwordTfView;
/** 密码输入框*/
@property (nonatomic, strong) UITextField *passwordTf;
/** 忘记密码按钮*/
@property (nonatomic, strong) UIButton *registerBtn;
/** 忘记密码按钮*/
@property (nonatomic, strong) UILabel *registerLabel;
/** 注册账户按钮*/
@property (nonatomic, strong) UIButton *forgetBtn;
/** 分割线2*/
@property (nonatomic, strong) UIView *secondLineView;
/** 登录按钮*/
@property (nonatomic, strong) UIButton *loginBtn;
/** 线条1*/
@property (nonatomic, strong) UIView *simpleLine_0;
/** 线条2*/
@property (nonatomic, strong) UIView *simpleLine_1;

/** 当前输入模式 0 ==登录 1==注册*/
@property (nonatomic, assign) NSInteger currentIndex;


@end

@implementation WSDLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = WHITECOLOR;
    self.isAutoBack = NO;
    [self.view addSubview:self.leftBackBtn];
    [self.view addSubview:self.logoIv];
    [self.view addSubview:self.loginView];
    [self.view addSubview:self.loginBtn];
    [self.view addSubview:self.registerLabel];
    [self.view addSubview:self.registerBtn];
    [self.view addSubview:self.forgetBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    _leftBackBtn.sd_layout
    .centerYIs(44)
    .leftSpaceToView(self.view, 0)
    .heightIs(50)
    .widthIs(50);
    
    _logoIv.sd_layout
    .topSpaceToView(self.view,114)
    .centerXEqualToView(self.view)
    .heightIs(90)
    .widthIs(90);
    _logoIv.sd_cornerRadius = @(12);
    
    _loginView.sd_layout
    .topSpaceToView(self.logoIv, 80)
    .leftSpaceToView(self.view, 45)
    .rightSpaceToView(self.view, 45)
    .heightIs(120);
    [self autoLayoutLoginSubViews];
    
    _loginBtn.sd_layout
    .topSpaceToView(_loginView, 22)
    .centerXEqualToView(self.view)
    .leftSpaceToView(self.view,43)
    .rightSpaceToView(self.view,43)
    .heightIs(47);
    
    _registerLabel.sd_layout
    .topSpaceToView(_loginBtn,23)
    .leftEqualToView(_loginBtn)
    .autoHeightRatio(0);
    [_registerLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    _registerBtn.sd_layout
    .centerYEqualToView(_registerLabel)
    .leftSpaceToView(_registerLabel,2)
    .widthIs(35)
    .heightIs(15);
    
    _forgetBtn.sd_layout
    .topEqualToView(_registerLabel)
    .rightSpaceToView(self.view,36)
    .widthIs(65)
    .heightIs(15);
    
}

/** 自动布局登录模块*/
- (void)autoLayoutLoginSubViews{
    

    _phoneTfView.sd_layout
    .topSpaceToView(_loginView,5)
    .leftSpaceToView(_loginView,8)
    .widthIs(18)
    .heightIs(25);
    
    _phoneTf.sd_layout
    .centerYEqualToView(_phoneTfView)
    .leftSpaceToView(_phoneTfView,25)
    .rightSpaceToView(_loginView, 0)
    .heightIs(20);
    
    _simpleLine_0.sd_layout
    .centerXEqualToView(_phoneTf)
    .topSpaceToView(_phoneTf,20)
    .widthRatioToView(_phoneTf,1)
    .heightIs(1);
    
    _passwordTfView.sd_layout
    .topSpaceToView(_simpleLine_0,20)
    .leftSpaceToView(_loginView,8)
    .widthIs(18)
    .heightIs(25);
    
    _passwordTf.sd_layout
    .centerYEqualToView(_passwordTfView)
    .leftSpaceToView(_passwordTfView, 25)
    .rightSpaceToView(_loginView, 0)
    .heightIs(20);
    
    _simpleLine_1.sd_layout
    .centerXEqualToView(_passwordTf)
    .topSpaceToView(_passwordTf,20)
    .widthRatioToView(_passwordTf,1)
    .heightIs(1);
    
}


#pragma mark - 点击事件
/** 返回上级界面*/
- (void)leftBackAction{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
/** 进入忘记按钮*/
- (void)forgetAction{
//    ReplacePassWordViewController *replace = [[ReplacePassWordViewController alloc] init];
//    [self.navigationController pushViewController:replace animated:YES];
}

/** 点击登录按钮*/
- (void)loginAction{
    
    [self.view endEditing:YES];
    if (![self isFitLoginAccess]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确手机号码"];
        return ;
    }
    
    GOLFWeakObj(self);
    [SVProgressHUD showWithStatus:@"正在登录中"];
    /*
     [ShareBusinessManager.loginManager postLoginWithParameters:@{@"deviceType":@1, @"password":password, @"userName":username} success:^(id responObject) {
     //登录成功
     [SVProgressHUD showSuccessWithStatus:@"登录成功"];
     [weakself.navigationController dismissViewControllerAnimated:YES completion:nil];
     } failure:^(NSInteger errCode, NSString *errorMsg) {
     [SVProgressHUD showErrorWithStatus:errorMsg];
     }];
     */

    
}

/** 判断是否满足登录要求*/
- (BOOL)isFitLoginAccess{
    if (!_phoneTf.text.length) {
        return NO;
    }
    if (![_phoneTf.text validateMobile]) {
        return NO;
    }
    if (!_passwordTf.text.length) {
        return NO;
    }
    
    return YES;
}
/** 放弃输入*/
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}


#pragma mark - 懒加载
- (UIButton *)leftBackBtn{
    if (!_leftBackBtn) {
        _leftBackBtn = [[UIButton alloc] init];
        [_leftBackBtn setImage:IMAGE(@"back") forState:UIControlStateNormal];
        _leftBackBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_leftBackBtn addTarget:self action:@selector(leftBackAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBackBtn;
}

- (UIImageView *)logoIv{
    if (!_logoIv) {
        _logoIv = [[UIImageView alloc] init];
        //        _logoIv.image = IMAGE(@"classify159");
        _logoIv.backgroundColor = GLOBALCOLOR;
    }
    return _logoIv;
}

- (UIView *)loginView{
    if (!_loginView) {
        _loginView = [[UIView alloc] init];
        _loginView.backgroundColor = [UIColor whiteColor];
        [_loginView addSubview:self.phoneTf];
        [_loginView addSubview:self.phoneTfView];
        [_loginView addSubview:self.simpleLine_0];
        [_loginView addSubview:self.passwordTfView];
        [_loginView addSubview:self.passwordTf];
        [_loginView addSubview:self.simpleLine_1];
        [_loginView addSubview:self.forgetBtn];
    }
    return _loginView;
    
}

- (UIImageView *)phoneTfView{
    if (!_phoneTfView) {
        _phoneTfView = [[UIImageView alloc] init];
        //_logoIv.image = IMAGE(@"classify159");
        _phoneTfView.backgroundColor = GLOBALCOLOR;
    }
    return _phoneTfView;
}
- (UITextField *)phoneTf{
    if (!_phoneTf) {
        _phoneTf = [[UITextField alloc] init];
        _phoneTf.placeholder = @"请输入手机号码";
        _phoneTf.textColor = LIGHTTEXTCOLOR;
        _phoneTf.font = FONT(16);
        _phoneTf.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _phoneTf;
}

- (UITextField *)passwordTf{
    if (!_passwordTf) {
        _passwordTf = [[UITextField alloc] init];
        _passwordTf.placeholder = @"请输入密码";
        _passwordTf.textColor = LIGHTTEXTCOLOR;
        _passwordTf.font = FONT(16);
        _passwordTf.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _passwordTf;
}
- (UIImageView *)passwordTfView{
    if (!_passwordTfView) {
        _passwordTfView = [[UIImageView alloc] init];
        //_logoIv.image = IMAGE(@"classify159");
        _passwordTfView.backgroundColor = GLOBALCOLOR;
    }
    return _passwordTfView;
}


- (UIView *)secondLineView{
    if (!_secondLineView) {
        _secondLineView = [[UIView alloc] init];
        _secondLineView.backgroundColor = GRAYCOLOR;
    }
    return _secondLineView;
}

- (UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn = [[UIButton alloc] init];
        _loginBtn.backgroundColor = GLOBALCOLOR;
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}

- (UIView *)simpleLine_0{
    if (!_simpleLine_0) {
        _simpleLine_0   = [[UIView alloc] init];
        _simpleLine_0.backgroundColor = GRAYCOLOR;
    }
    return _simpleLine_0;
}

- (UIView *)simpleLine_1{
    if (!_simpleLine_1) {
        _simpleLine_1 = [[UIView alloc] init];
        _simpleLine_1.backgroundColor = GRAYCOLOR;
    }
    return _simpleLine_1;
}
-(UILabel *)registerLabel{
    if (!_registerLabel) {
        _registerLabel = [UILabel labelWithText:@"新用户？" andTextColor:LIGHTTEXTCOLOR andFontSize:15.0f];
    }
    return _registerLabel;
}

- (UIButton *)forgetBtn{
    if (!_forgetBtn) {
        _forgetBtn = [[UIButton alloc] init];
        [_forgetBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
        [_forgetBtn setTitleColor:GLOBALCOLOR forState:UIControlStateNormal];
        _forgetBtn.titleLabel.font = FONT(12);
        [_forgetBtn addTarget:self action:@selector(forgetAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetBtn;
}

- (UIButton *)registerBtn{
    if (!_registerBtn) {
        _registerBtn = [[UIButton alloc] init];
        [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
        [_registerBtn setTitleColor:GLOBALCOLOR forState:UIControlStateNormal];
        _registerBtn.titleLabel.font = FONT(14);
        [_registerBtn addTarget:self action:@selector(forgetAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerBtn;
}


@end
