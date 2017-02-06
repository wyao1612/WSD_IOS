//
//  WSDRegisterViewController.m
//  WSD
//
//  Created by wyao on 2017/2/4.
//  Copyright © 2017年 Tsou. All rights reserved.
//

#import "WSDRegisterViewController.h"
#import "WSDRegisterSuccessViewController.h"
#import "YW_TextField.h"

@interface WSDRegisterViewController ()
/** 电话输入框*/
@property (nonatomic, strong) YW_TextField *phoneTf;
/** 验证码输入框*/
@property (nonatomic, strong) YW_TextField *verifyCodeTf;
/** 发送验证码按钮*/
@property (nonatomic, strong) JKCountDownButton *sendTestBtn;
/** 密码输入框*/
@property (nonatomic, strong) YW_TextField *passwordTf;
/** 注册按钮*/
@property (nonatomic, strong) UIButton *RegisterBtn;
@end

@implementation WSDRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.name = @"注册";
    self.isAutoBack = NO;
    [self.view sd_addSubviews:@[self.phoneTf, self.verifyCodeTf, self.sendTestBtn, self.passwordTf, self.RegisterBtn]];
    
    //布局
    self.phoneTf.sd_layout
    .topSpaceToView(self.view,15)
    .leftSpaceToView(self.view,10)
    .rightSpaceToView(self.view,10)
    .heightIs(45);
    

    self.sendTestBtn.sd_layout
    .topSpaceToView(self.phoneTf,15)
    .rightSpaceToView(self.view,10)
    .widthIs(120)
    .heightIs(45);
    
    self.verifyCodeTf.sd_layout
    .topSpaceToView(self.phoneTf,15)
    .leftSpaceToView(self.view,10)
    .rightSpaceToView(self.sendTestBtn,6)
    .heightIs(45);
    
    self.passwordTf.sd_layout
    .topSpaceToView(self.verifyCodeTf,15)
    .leftSpaceToView(self.view,10)
    .rightSpaceToView(self.view,10)
    .heightIs(45);
    
    self.RegisterBtn.sd_layout
    .topSpaceToView(self.passwordTf,40)
    .leftSpaceToView(self.view,43)
    .rightSpaceToView(self.view,43)
    .heightIs(48);

}

/** 发送验证码*/
- (void)sendTestWordAction{
    if (!_phoneTf.text.length || ![_phoneTf.text validateMobile]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确手机号码"];
        return;
    }
    WSDWeakObj(self);
    [SVProgressHUD showWithStatus:@"发送验证码中"];
    [ShareBusinessManager.loginManager postRegCodeWithParameters:@{@"phoneNumber":_phoneTf.text,
                                                                   @"verifyFlag":@20}
                                                         success:^(id responObject) {
                                                             weakself.sendTestBtn.enabled = NO;
                                                             [weakself.sendTestBtn startWithSecond:60];
                                                             [SVProgressHUD showSuccessWithStatus:@"验证码已发送，请注意查收"];
                                                         }
                                                         failure:^(NSInteger errCode, NSString *errorMsg) {
                                                             [SVProgressHUD showErrorWithStatus:errorMsg];
                                                         }];
}
/** 点击注册按钮*/
- (void)loginAction{
    
    [self.view endEditing:YES];
    WSDRegisterSuccessViewController *successVc = [[WSDRegisterSuccessViewController alloc] init];
//    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:successVc];
    [self.navigationController pushViewController:successVc animated:YES];
  /*  if (![self isFitLoginAccess]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确手机号码或输入密码"];
        return ;
    }
    
    WSDWeakObj(self);
    //注册操作
    if (!_passwordTf.text.length) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        return;
    }
        [SVProgressHUD showWithStatus:@"正在注册中"];
        [ShareBusinessManager.loginManager postRegisterWithParameters:@{@"password":_passwordTf.text,
                                                                        @"regCode":_verifyCodeTf.text,
                                                                        @"userName":_phoneTf.text}
                                                              success:^(id responObject) {
                                                                  //注册成功;
                                                                  [SVProgressHUD showSuccessWithStatus:@"注册成功,正在登录中"];
                                                                  [weakself.navigationController popViewControllerAnimated:YES];
                                                              }
                                                              failure:^(NSInteger errCode, NSString *errorMsg) {
                                                                  [SVProgressHUD showErrorWithStatus:errorMsg];
                                                              }];
    */
    
}

/** 放弃输入*/
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}
/** 判断手机号是否满足注册输入要求*/
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 懒加载控件
- (YW_TextField *)phoneTf{
    if (!_phoneTf) {
        _phoneTf = [[YW_TextField alloc] init];
        _phoneTf.placeholder = @"请输入手机号";
        _phoneTf.textColor = SHENTEXTCOLOR;
        _phoneTf.font = FONT(16);
        [_phoneTf setTextFiledLeftImageName:@"bottom-study"];
        _phoneTf.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _phoneTf;
}

- (YW_TextField *)passwordTf{
    if (!_passwordTf) {
        _passwordTf = [[YW_TextField alloc] init];
        _passwordTf.placeholder = @"请输入密码";
        _passwordTf.textColor = SHENTEXTCOLOR;
        _passwordTf.font = FONT(16);
        [_passwordTf setTextFiledLeftImageName:@"bottom-study"];
        _passwordTf.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _passwordTf;
}

- (YW_TextField *)verifyCodeTf{
    if (!_verifyCodeTf) {
        _verifyCodeTf = [[YW_TextField alloc] init];
        _verifyCodeTf.placeholder  = @"请输入验证码";
        _verifyCodeTf.textColor = SHENTEXTCOLOR;
        _verifyCodeTf.font = FONT(16);
        [_verifyCodeTf setTextFiledLeftImageName:@"bottom-study"];
        _verifyCodeTf.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _verifyCodeTf;
}

- (JKCountDownButton *)sendTestBtn{
    if (!_sendTestBtn) {
        _sendTestBtn = [[JKCountDownButton alloc] init];
        _sendTestBtn.layer.borderColor = [UIColor colorWithHex:0xe8e8e8].CGColor;
        _sendTestBtn.layer.borderWidth = 1.0f;
        [_sendTestBtn.layer setCornerRadius:2.0f];
        [_sendTestBtn.layer setMasksToBounds:YES];
        [_sendTestBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
        [_sendTestBtn setTitleColor:SHENTEXTCOLOR forState:UIControlStateNormal];
        _sendTestBtn.titleLabel.font = FONT(13);
        [_sendTestBtn addTarget:self action:@selector(sendTestWordAction) forControlEvents:UIControlEventTouchUpInside];
        [_sendTestBtn didChange:^NSString *(JKCountDownButton *countDownButton, int second) {
            NSString *text = [NSString stringWithFormat:@"%d秒",second];
            return text;
        }];
        
        [_sendTestBtn didFinished:^NSString *(JKCountDownButton *countDownButton, int second) {
            countDownButton.enabled = YES;
            return @"重新发送";
        }];
    }
    return _sendTestBtn;
}

- (UIButton *)RegisterBtn{
    if (!_RegisterBtn) {
        _RegisterBtn = [[UIButton alloc] init];
        [_RegisterBtn setTitle:@"立即注册" forState:UIControlStateNormal];
        _RegisterBtn.backgroundColor = GLOBALCOLOR;
        [_RegisterBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _RegisterBtn;
}

@end
