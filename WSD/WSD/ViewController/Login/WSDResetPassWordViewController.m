//
//  WSDResetPassWordViewController.m
//  WSD
//
//  Created by wyao on 2017/2/5.
//  Copyright © 2017年 Tsou. All rights reserved.
//

#import "WSDResetPassWordViewController.h"
#import "YW_TextField.h"

@interface WSDResetPassWordViewController ()
/** 设置密码框*/
@property (nonatomic, strong) YW_TextField *setPasswordTf;
/** 确认密码框*/
@property (nonatomic, strong) YW_TextField *surePasswordTf;
/** 注册按钮*/
@property (nonatomic, strong) UIButton *sureBtn;
@end

@implementation WSDResetPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.name = @"重置密码";
    self.isAutoBack = NO;
    [self.view sd_addSubviews:@[self.setPasswordTf, self.surePasswordTf,self.sureBtn]];
    
    //布局
    self.setPasswordTf.sd_layout
    .topSpaceToView(self.view,15)
    .leftSpaceToView(self.view,10)
    .rightSpaceToView(self.view,10)
    .heightIs(45);
    
    
    self.surePasswordTf.sd_layout
    .topSpaceToView(self.setPasswordTf,15)
    .leftSpaceToView(self.view,10)
    .rightSpaceToView(self.view,6)
    .heightIs(45);
    
    self.sureBtn.sd_layout
    .topSpaceToView(self.surePasswordTf,40)
    .leftSpaceToView(self.view,43)
    .rightSpaceToView(self.view,43)
    .heightIs(48);
    
}

/** 点击提交更新按钮*/
- (void)sureAction{
    
    [self.view endEditing:YES];
    if (![self isFitLoginAccess]) {
        [SVProgressHUD showErrorWithStatus:@"密码不符合要求请重新输入"];
        return ;
    }
    
    WSDWeakObj(self);
    //点击下一步操作
    [SVProgressHUD showWithStatus:@"提交更新"];
    //操作
    
}

-(BOOL)isFitLoginAccess{
    if (!(_setPasswordTf.text.length>=6 &&_setPasswordTf.text.length <= 16)) {
        return NO;
    }
    if (!(_surePasswordTf.text.length>=6 &&_surePasswordTf.text.length <= 16)) {
        return NO;
    }
    if (![_setPasswordTf.text isEqualToString:_surePasswordTf.text]) {
        return NO;
    }
    return YES;
}

/** 放弃输入*/
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 懒加载控件
- (YW_TextField *)setPasswordTf{
    if (!_setPasswordTf) {
        _setPasswordTf = [[YW_TextField alloc] init];
        _setPasswordTf.placeholder  = @"请输入6~16位登录密码";
        _setPasswordTf.textColor = SHENTEXTCOLOR;
        _setPasswordTf.font = FONT(16);
        [_setPasswordTf setTextFiledLeftImageName:@"bottom-study"];
        _setPasswordTf.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _setPasswordTf;
    
}

- (YW_TextField *)surePasswordTf{
    if (!_surePasswordTf) {
        _surePasswordTf = [[YW_TextField alloc] init];
        _surePasswordTf.placeholder  = @"请再次输入密码";
        _surePasswordTf.textColor = SHENTEXTCOLOR;
        _surePasswordTf.font = FONT(16);
        [_surePasswordTf setTextFiledLeftImageName:@"bottom-study"];
        _surePasswordTf.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _surePasswordTf;
    
}


- (UIButton *)sureBtn{
    if (!_sureBtn) {
        _sureBtn = [[UIButton alloc] init];
        [_sureBtn setTitle:@"提交更新" forState:UIControlStateNormal];
        _sureBtn.backgroundColor = GLOBALCOLOR;
        [_sureBtn addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}

@end
