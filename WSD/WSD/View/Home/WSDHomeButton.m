//
//  WSDHomeButton.m
//  WSDIOS
//
//  Created by wyao on 16/11/1.
//  Copyright © 2016年 TSOU. All rights reserved.
//

#import "WSDHomeButton.h"

@implementation WSDHomeButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    
        [self setTitleColor:BLACKTEXTCOLOR forState:UIControlStateNormal];
        [self setTitleColor:BLACKTEXTCOLOR forState:UIControlStateSelected];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        self.imageView.sd_layout
        .topSpaceToView(self, 15)
        .centerXEqualToView(self)
        .widthIs(40)
        .heightIs(40);
        
        self.titleLabel.sd_layout
        .topSpaceToView(self.imageView, 5.5)
        .centerXEqualToView(self)
        .autoHeightRatio(0);
        [self.titleLabel setSingleLineAutoResizeWithMaxWidth:100];
        
        self.titleLabel.font = FONT(14);
    }
    return self;
}

@end
