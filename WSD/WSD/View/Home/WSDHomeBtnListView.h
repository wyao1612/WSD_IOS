//
//  WSDHomeBtnListView.h
//  WSD
//
//  Created by wyao on 2017/1/5.
//  Copyright © 2017年 Tsou. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WSDHomeBtnListViewDelegate <NSObject>

@optional
-(void)WSDHomeBtnListViewClick:(UIButton*)sender;

@end

@interface WSDHomeBtnListView : UIView
/** 代理对象*/
@property(nonatomic,assign) id<WSDHomeBtnListViewDelegate> delegate;
@end
