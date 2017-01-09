//
//  WSDSectionView.m
//  WSD
//
//  Created by wyao on 2017/1/5.
//  Copyright © 2017年 Tsou. All rights reserved.
//

#import "WSDSectionView.h"

@interface WSDSectionView ()

@property(nonatomic,strong) UIView *verView;
@end

@implementation WSDSectionView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    
    
}

#pragma mark - 懒加载控件
-(UIView *)verView{
    if (_verView == nil) {
        _verView = [[UIView alloc] init];
        _verView.backgroundColor = [UIColor orangeColor];
        
    }
    return _verView;
}

@end
