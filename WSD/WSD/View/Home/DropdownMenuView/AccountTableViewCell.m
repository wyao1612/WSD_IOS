//
//  DropDownTableViewCell.m
//  WSD
//
//  Created by wyao on 2017/1/10.
//  Copyright © 2017年 Tsou. All rights reserved.
//

#import "DropDownTableViewCell.h"

#define inputW 230 // 输入框宽度
#define inputH 35  // 输入框高度


@interface DropDownTableViewCell ()

/** 头像 */
@property (nonatomic, strong) UIImageView *avatar;
/** 账号*/
@property (nonatomic, strong) UILabel *account;

@end


@implementation DropDownTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 头像
        _avatar = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, inputH-10, inputH-10)];
        _avatar.layer.cornerRadius = (inputH-10)/2;
        [self.contentView addSubview:_avatar];
        
        // 账号
        _account = [[UILabel alloc]initWithFrame:CGRectMake(inputH, 0, inputW - inputH, inputH)];
        _account.font = [UIFont systemFontOfSize:12.0];
        [self.contentView addSubview:_account];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
