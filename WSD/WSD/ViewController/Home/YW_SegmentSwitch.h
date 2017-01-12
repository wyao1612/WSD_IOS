//
//  YW_SegmentSwitch.h
//  test
//
//  Created by wyao on 2017/1/12.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YW_SegmentSwitchDelegate <NSObject>

@optional
- (void)selectByIndex:(NSInteger)index;
-(void)beginScrollerFromPosintion:(NSInteger)position;
-(void)endScrollerFromPosintion:(NSInteger)position;

@end

@interface YW_SegmentSwitch : UIView

/** 标题正常显示的颜色*/
@property(nonatomic,strong)  UIColor *titleNormalColor;
/** 标题选中的显示的颜色*/
@property (nonatomic,strong) UIColor *titleSelectedColor;
/** 选中框选中的显示的颜色*/
@property (nonatomic,strong) UIColor *selectionColor;
/** 标题数组*/
@property(nonatomic,strong)  NSArray<NSString*> *titles;
/** 选中视图距离父视图的间距，默认为0*/
@property (nonatomic,assign) CGFloat  marginInset;
/** 底部视图的圆角，默认为5*/
@property (nonatomic,assign) CGFloat  cornerRadius;
/** 代理对象*/
@property(nonatomic,assign) id<YW_SegmentSwitchDelegate> delegate;

@end
