//
//  WSDHomeTableViewCell.m
//  WSD
//
//  Created by wyao on 2017/1/10.
//  Copyright © 2017年 Tsou. All rights reserved.
//

#import "WSDHomeTableViewCell.h"

@interface WSDHomeTableViewCell ()
/** 课程图标*/
@property (nonatomic, strong) UIImageView *icon;
/** 课程名称*/
@property (nonatomic, strong) UILabel *nameLabel;
/** 开始日期和截止日期*/
@property (nonatomic, strong) UILabel *DateLable;
/** 课程图标*/
@property (nonatomic, strong) UIImageView *classIcon;
/** 课程数量*/
@property (nonatomic, strong) UILabel *clasaNumLabel;


@end


@implementation WSDHomeTableViewCell

#pragma mark - 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.DateLable];
    [self.contentView addSubview:self.classIcon];
    [self.contentView addSubview:self.clasaNumLabel];
    
    
    self.icon.sd_layout
    .topSpaceToView(self.contentView,10)
    .leftSpaceToView(self.contentView,10)
    .widthIs(90)
    .heightIs(68);
    
    self.nameLabel.sd_layout
    .topSpaceToView(self.contentView,15)
    .leftSpaceToView(self.icon,8)
    .autoHeightRatio(0);
    [self.nameLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    self.DateLable.sd_layout
    .topSpaceToView(self.nameLabel,12)
    .leftSpaceToView(self.icon,8)
    .autoHeightRatio(0);
    [self.DateLable setMaxNumberOfLinesToShow:1];
    [self.DateLable setSingleLineAutoResizeWithMaxWidth:250];
    
    
    self.classIcon.sd_layout
    .topSpaceToView(self.DateLable,12)
    .leftSpaceToView(self.icon,8)
    .widthIs(9)
    .heightIs(9);
    
    self.clasaNumLabel.sd_layout
    .centerYEqualToView(self.classIcon)
    .leftSpaceToView(self.classIcon,8)
    .autoHeightRatio(0);
    [self.clasaNumLabel setMaxNumberOfLinesToShow:1];
    [self.clasaNumLabel setSingleLineAutoResizeWithMaxWidth:50];
    
    [self setupAutoHeightWithBottomView:self.icon bottomMargin:12];
}


#pragma mark - 懒加载控件
- (UIImageView *)icon{
    if (_icon == nil) {
        _icon = [[UIImageView alloc] init];
        _icon.image = [UIImage  imageNamed:@"Homecell"];
    }
    return _icon;
}

- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = FONT(14);
        _nameLabel.textColor = BLACKTEXTCOLOR;
        _nameLabel.text = @"雅思全程托管计划";
    }
    return _nameLabel;
}

- (UILabel *)DateLable{
    if (_DateLable == nil) {
        _DateLable = [[UILabel alloc] init];
        _DateLable.font = FONT(14);
        _DateLable.textColor = BLACKTEXTCOLOR;
        _DateLable.text = @"12月19日——12月30日";
    }
    return _DateLable;
}

- (UIImageView *)classIcon{
    if (_classIcon == nil) {
        _classIcon = [[UIImageView alloc] init];
        _classIcon.image = IMAGE(@"classify9");
    }
    return _classIcon;
}

- (UILabel *)clasaNumLabel{
    if (_clasaNumLabel == nil) {
        _clasaNumLabel = [[UILabel alloc] init];
        _clasaNumLabel.font = FONT(14);
        _clasaNumLabel.textColor = LIGHTTEXTCOLOR;
        _clasaNumLabel.text = @"10次课";
    }
    return _clasaNumLabel;
}

@end
