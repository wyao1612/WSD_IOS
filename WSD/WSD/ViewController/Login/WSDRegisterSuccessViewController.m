//
//  WSDRegisterSuccessViewController.m
//  WSD
//
//  Created by wyao on 2017/2/5.
//  Copyright © 2017年 Tsou. All rights reserved.
//

#import "WSDRegisterSuccessViewController.h"

@interface WSDRegisterSuccessViewController ()
/** 图片*/
@property (nonatomic, strong) UIImageView *logoIv;
/** 标题1*/
@property (nonatomic, strong) UILabel *FirstTitleLb;
/** 标题2*/
@property (nonatomic, strong) UILabel *secondTitleLb;
/** 立即绑定按钮*/
@property (nonatomic, strong) UIButton *boundBtn;
/** 不绑定label*/
@property (nonatomic, strong) UILabel *NOBoundLb;
@end

@implementation WSDRegisterSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = WHITECOLOR;
    self.name = @"注册成功";
    self.isAutoBack = NO;
    [self.view sd_addSubviews:@[self.logoIv, self.FirstTitleLb, self.secondTitleLb, self.boundBtn, self.NOBoundLb]];
    
    //布局
    _logoIv.sd_layout
    .topSpaceToView(self.view,38)
    .centerXEqualToView(self.view)
    .widthIs(105)
    .heightIs(105);
    
    _FirstTitleLb.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(self.logoIv,25)
    .autoHeightRatio(0);
    [_FirstTitleLb setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH];
    
    _secondTitleLb.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(_FirstTitleLb,8)
    .autoHeightRatio(0);
    [_secondTitleLb setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH];
    
    _boundBtn.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(_secondTitleLb,20)
    .widthIs(292)
    .heightIs(45);
    
    _NOBoundLb.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(_boundBtn,25)
    .autoHeightRatio(0);
    [_NOBoundLb setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH];
    
}

#pragma mark - 点击事件
/** 返回上级界面*/
- (void)leftBackAction{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 懒加载
- (UIImageView *)logoIv{
    if (!_logoIv) {
        _logoIv = [[UIImageView alloc] init];
        //_logoIv.image = IMAGE(@"Homecell");
        _logoIv.backgroundColor = GLOBALCOLOR;
    }
    return _logoIv;
}
- (UILabel *)FirstTitleLb{
    if (!_FirstTitleLb) {
        _FirstTitleLb = [[UILabel alloc] init];
        _FirstTitleLb.font = FONT(16);
        _FirstTitleLb.textColor = SHENTEXTCOLOR;
        _FirstTitleLb.text = @"欢迎加入维思得英语";
    }
    return _FirstTitleLb;
}

- (UILabel *)secondTitleLb{
    if (!_secondTitleLb) {
        _secondTitleLb = [[UILabel alloc] init];
        _secondTitleLb.font = FONT(16);
        _secondTitleLb.textColor = LIGHTTEXTCOLOR;
        _secondTitleLb.text = @"是否绑定学员？";
    }
    return _secondTitleLb;
}

- (UIButton *)boundBtn{
    if (!_boundBtn) {
        _boundBtn = [[UIButton alloc] init];
        [_boundBtn setTitle:@"立即绑定" forState:UIControlStateNormal];
        _boundBtn.backgroundColor = GLOBALCOLOR;
        [_boundBtn addTarget:self action:@selector(boundAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _boundBtn;
}


- (UILabel *)NOBoundLb{
    if (!_NOBoundLb) {
        _NOBoundLb = [[UILabel alloc] init];
        _NOBoundLb.font = FONT(16);
        _NOBoundLb.textColor = LIGHTTEXTCOLOR;
        _NOBoundLb.text = @"暂不绑定";
    }
    return _NOBoundLb;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
