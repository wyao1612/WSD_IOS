//
//  WSDHomeBtnListView.m
//  WSD
//
//  Created by wyao on 2017/1/5.
//  Copyright © 2017年 Tsou. All rights reserved.
//

#import "WSDHomeBtnListView.h"
#import "WSDHomeButton.h"

/** 按钮宽度*/
#define btnW SCREEN_WIDTH / 3
/** 按钮高度*/
#define btnH  81.0f
/** 总列数*/
#define COLUMN 3
/** 按钮个数*/
#define Count  6
/** 按钮间距*/
#define Margin 0



@implementation WSDHomeBtnListView



-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    
    return self;
}



/** 布局按钮视图*/
-(void)setupUI{
    
    //标题数组
    NSArray *titlesArr = [NSArray arrayWithObjects:@"学习进度",@"在线报名",@"成绩查询",@"在线测试",@"双优课堂",@"站内活动",nil];
    NSArray *imagesArr = [NSArray arrayWithObjects:@"classify10",@"classify3",@"classify4",@"classify5",@"classify6",@"classify7",nil];
    
    for (NSInteger i = 0; i < Count ; i++) {
        
        NSInteger row = i / COLUMN;
        NSInteger column = i % COLUMN;
 
        CGFloat btnX = Margin + (Margin + btnW) * column;
        CGFloat btnY = Margin + (Margin + btnH) * row;
        
        
        WSDHomeButton *btn = [[WSDHomeButton alloc] init];
        //位置
        btn.frame = CGRectMake(btnX,btnY, btnW, btnH);

        btn.backgroundColor = [UIColor whiteColor];
        
        [btn setTitle:titlesArr[i] forState:UIControlStateNormal];
        
        btn.titleLabel.font = FONT(14);
        [btn setImage:IMAGE(imagesArr[i]) forState:UIControlStateNormal];
        
        btn.tag = i;
        [btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self  addSubview:btn];
    
    }

}


#pragma mark - 按钮点击事件
- (void)BtnClick:(UIButton *)sender {
    NSLog(@"点击%ld跳转",sender.tag);
}


@end
