//
//  YW_SegmentSwitch.m
//  test
//
//  Created by wyao on 2017/1/12.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import "YW_SegmentSwitch.h"
#define size_width self.bounds.size.width
#define eachItemWidth self.bounds.size.width/_titles.count

@interface YW_SegmentSwitch ()


@property (nonatomic,assign) NSInteger  count;
@property(nonatomic,strong) UIView * markView;
@property(nonatomic,strong)NSMutableArray<UILabel *> * NormalsubViews;
@property(nonatomic,strong)NSMutableArray<UILabel *> * SelectsubViews;
@property(nonatomic,strong)NSMutableArray<NSValue*> * PointsSectionArray;

@property(nonatomic,assign)CGPoint initPoint;
@property(nonatomic,assign)NSInteger beginPosition;
@property(nonatomic,assign)NSInteger endPosition;

@property (nonatomic,assign) NSInteger  position;//default 0;

/** 代码滑动*/
- (void)setIndex:(NSInteger)index;
@end

@implementation YW_SegmentSwitch


-(UIView *)markView{
    if (!_markView) {
        _markView = [[UIView alloc] init];
        _markView.backgroundColor = self.selectionColor;
    }
    return _markView;
}


-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self initBaseModel];//初始化数据
    }
    return self;
}

-(void)initBaseModel
{
    self.NormalsubViews = [NSMutableArray array];
    self.SelectsubViews = [NSMutableArray array];
    self.PointsSectionArray = [NSMutableArray array];
    self.selectionColor = [UIColor orangeColor];
    self.position = 0;
    self.marginInset = 0;
    self.beginPosition=0;
    self.endPosition = 0;
    
    
}

#pragma  mark---setters

-(void)setTitles:(NSArray<NSString *> *)titles{
    _titles = titles;
    
    if (titles.count == 0) {
        return;
    }
    
    [self.NormalsubViews removeAllObjects];
    [self.SelectsubViews removeAllObjects];
    
    for (int i = 0; i< _titles.count; i++) {
        UILabel * label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:15.0];
        label.text = _titles[i];
        label.textColor = self.titleNormalColor;
        label.textAlignment = NSTextAlignmentCenter;
        label.userInteractionEnabled = YES;
        [self addSubview:label];
        [self.NormalsubViews addObject:label];
        
        label.frame = CGRectMake(i*eachItemWidth, 0, eachItemWidth, self.bounds.size.height);
        [self.PointsSectionArray addObject:[NSValue valueWithCGPoint:label.center]];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [label addGestureRecognizer:tap];
    }

    //默认的markView位置
    [self.markView setFrame:CGRectInset(self.NormalsubViews[0].frame, self.marginInset, self.marginInset)];
    [self addSubview:self.markView];
    
    for (int i = 0; i< _titles.count; i++) {
        UILabel * label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:15.0];
        label.text = _titles[i];
        label.textColor = self.titleSelectedColor;
        label.textAlignment = NSTextAlignmentCenter;
        label.userInteractionEnabled = YES;
        [self.markView addSubview:label];
        [self.SelectsubViews addObject:label];
    }
    [self layoutMakeViewWithPoint:self.NormalsubViews[self.position].center];
    [self decorateViews];
    
    //禁止了拖拽事件
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panAction:)];
    [self.markView addGestureRecognizer:pan];
    
}

//修饰控件形状
-(void)decorateViews{
    self.layer.cornerRadius = self.cornerRadius;
    if (self.cornerRadius >= self.markView.bounds.size.width) {
        self.markView.layer.cornerRadius = 0;
    }else{
        self.markView.layer.cornerRadius = self.cornerRadius<self.markView.bounds.size.height/2?self.cornerRadius:self.markView.bounds.size.height/2; 
    }
    self.markView.clipsToBounds = YES;
}


-(void)layoutMakeViewWithPoint:(CGPoint)point{
    _markView.center = point;
    [self.NormalsubViews enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel * selectLabel = self.SelectsubViews[idx];
        [selectLabel setFrame:[self convertRect:obj.frame toView:_markView]];
    }];
}


#pragma mark - 外部点击时代用该方法
- (void)setIndex:(NSInteger)index{
    [self setPosition:index];
}

#pragma mark - 点击事件
-(void)tapAction:(UITapGestureRecognizer*)tap{
    [self.PointsSectionArray enumerateObjectsUsingBlock:^(NSValue * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqualToValue:[NSValue valueWithCGPoint:tap.view.center]]) {
            [self setPosition:idx];
            if (_delegate) {
                [_delegate selectByIndex:idx];
            }
        }
    }];
}

#pragma mark - 拖拽事件
-(void)panAction:(UIPanGestureRecognizer *)pan{
    
    //第一个的中心位置
    CGPoint minOffset = [self.NormalsubViews firstObject].center;
    //最后一个的中心位置
    CGPoint maxOffset = [self.NormalsubViews lastObject].center;
    //当前手指的偏移地址位置
    CGFloat offsetX =self.initPoint.x + [pan translationInView:self].x;
    
    if (pan.state ==UIGestureRecognizerStateBegan) {
        self.initPoint = self.markView.center;
        if (self.delegate &&[self.delegate respondsToSelector:@selector(beginScrollerFromPosintion:)]) {
            [self.delegate beginScrollerFromPosintion:self.beginPosition];
        }
        return;
    }
    
    if (pan.state == UIGestureRecognizerStateChanged) {
        NSLog(@"%f",[pan translationInView:self].x);
        CGPoint point;
        if ((offsetX >= minOffset.x) && offsetX <= maxOffset.x) {
            point = CGPointMake(offsetX, self.markView.center.y);
        }else{//手指划出界面的时候判断
            point = offsetX > size_width/2 ? maxOffset:minOffset;
        }
        [self layoutMakeViewWithPoint:point];
        
    }else{
        [UIView animateWithDuration:0.2 animations:^{
            [self layoutMakeViewWithPoint:[self.PointsSectionArray[[self aninmationForNowpoint:self.markView.center]]CGPointValue]];
        } completion:^(BOOL finished) {
            if (self.delegate &&[self.delegate respondsToSelector:@selector(endScrollerFromPosintion:)]) {
                [self.delegate endScrollerFromPosintion:self.endPosition];
                self.beginPosition = self.endPosition;
            }
        }];
    }
}

#pragma mark - 停止拖拽后停留位置
-(NSInteger)aninmationForNowpoint:(CGPoint )point{
    __block NSInteger loc;
    [self.PointsSectionArray enumerateObjectsUsingBlock:^(NSValue * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj CGPointValue].x>=point.x) {
            
            if ([obj CGPointValue].x-point.x<= size_width/(2*(self.PointsSectionArray.count))) {
                loc = idx;
            }else{
                loc = idx-1;
            }
            * stop = YES;
        }
    }];
    self.endPosition = loc;
    return loc;
}


-(void)setPosition:(NSInteger)position
{
    _position = position;
    if (self.PointsSectionArray.count==0)return;
    self.endPosition = position;
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutMakeViewWithPoint:[self.PointsSectionArray[position]CGPointValue]];
    } completion:^(BOOL finished) {
        if (self.delegate &&[self.delegate respondsToSelector:@selector(endScrollerFromPosintion:)]) {
            [self.delegate endScrollerFromPosintion:self.endPosition];
            self.beginPosition = self.endPosition;
        }
    }];
    
}

@end
