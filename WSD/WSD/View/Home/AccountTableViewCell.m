//
//  AccountTableViewCell.m
//  WSD
//
//  Created by wyao on 2017/1/10.
//  Copyright © 2017年 Tsou. All rights reserved.
//

#import "AccountTableViewCell.h"

#define inputW 230 // 输入框宽度
#define inputH 35  // 输入框高度


@interface AccountTableViewCell ()
/** 头像 */
@property (nonatomic, strong) UIImageView *avatar;
/** 账号*/
@property (nonatomic, strong) UILabel *nameLabel;
/** ID*/
@property (nonatomic, strong) UILabel *IdLabel;
/** 选中视图*/
@property (nonatomic, strong) UIImageView *selectView;
@end



@implementation AccountTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self  setupUI];
 }
    return self;
}

-(void)setupUI{
    
    [self setBackgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:self.avatar];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.IdLabel];
    [self.contentView addSubview:self.selectView];
    
    self.avatar.sd_layout
    .topSpaceToView(self.contentView,10)
    .leftSpaceToView(self.contentView,10)
    .widthIs(35)
    .heightIs(35);
    self.avatar.sd_cornerRadius = @17;
    
    self.nameLabel.sd_layout
    .centerYEqualToView(self.avatar)
    .leftSpaceToView(self.avatar,14)
    .autoHeightRatio(0);
    [self.nameLabel setMaxNumberOfLinesToShow:1];
    [self.nameLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    self.IdLabel.sd_layout
    .centerYEqualToView(self.nameLabel)
    .leftSpaceToView(self.nameLabel,3)
    .autoHeightRatio(0);
    [self.IdLabel setMaxNumberOfLinesToShow:1];
    [self.IdLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    self.selectView.sd_layout
    .centerYEqualToView(self.contentView)
    .rightSpaceToView(self.contentView,10)
    .widthIs(16)
    .heightIs(12);
    
}



-(void)setAccountModel:(UserModel *)accountModel{
    _accountModel = accountModel;
    self.avatar.image = [UIImage imageNamed:accountModel.headUrl];// 头像
    self.nameLabel.text = accountModel.name;// 名字
    self.IdLabel.text = accountModel.ID;
}

-(UIImageView *)avatar{
    if (!_avatar) {
        _avatar = [[UIImageView alloc] init];
        _avatar.backgroundColor = GLOBALCOLOR;
    }
    return _avatar;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        // 账号
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = FONT(12);
        _nameLabel.textColor = BLACKTEXTCOLOR;
    }
    return _nameLabel;
}

-(UILabel *)IdLabel{
    if (!_IdLabel) {
        _IdLabel = [[UILabel alloc] init];
        _IdLabel.font = FONT(12);
        _IdLabel.textColor = BLACKTEXTCOLOR;

    }
    return _IdLabel;
}
-(UIImageView *)selectView{
    if (!_selectView) {
        _selectView = [[UIImageView alloc] init];
        _selectView.image = [UIImage imageNamed:@"make"];
    }
    return _selectView;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectView.hidden = !selected;
    // Configure the view for the selected state
}


- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{

    [super setHighlighted:highlighted animated:animated];
    
//    self.selectView.hidden = !highlighted;
}

@end
