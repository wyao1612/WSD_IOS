//
//  YW_TextField.m
//  WSD
//
//  Created by wyao on 2017/2/5.
//  Copyright © 2017年 Tsou. All rights reserved.
//

#import "YW_TextField.h"

@implementation YW_TextField

-(void)setTextFiledLeftImageName:(NSString*)image{
    self.leftViewMode = UITextFieldViewModeAlways;
    self.leftView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:image]];
    //设置边框的颜色
//    self.borderStyle =  UITextBorderStyleRoundedRect;
    self.layer.borderWidth = 1.0f;
    self.layer.cornerRadius = 2;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = [[UIColor colorWithHex:0xe8e8e8] CGColor];;
}

//重写左边图标的X值
- (CGRect)leftViewRectForBounds:(CGRect)bounds{
    CGRect iconRect = [super leftViewRectForBounds:bounds];
    iconRect.origin.x += 10;
    return iconRect;
}

//  重写占位符的x值
- (CGRect)placeholderRectForBounds:(CGRect)bounds{
    CGRect placeholderRect = [super placeholderRectForBounds:bounds];
    placeholderRect.origin.x += 1;
    return placeholderRect;
}

//  重写文字输入时的X值
- (CGRect)editingRectForBounds:(CGRect)bounds{
    CGRect editingRect = [super editingRectForBounds:bounds];
    editingRect.origin.x += 10;
    return editingRect;
}

//  重写文字显示时的X值
- (CGRect)textRectForBounds:(CGRect)bounds{
    CGRect textRect = [super editingRectForBounds:bounds];
    textRect.origin.x += 10;
    return textRect;
}

@end
