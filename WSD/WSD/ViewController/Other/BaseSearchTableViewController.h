//
//  BaseSearchTableViewController.h
//  WSD
//
//  Created by wyao on 2017/1/4.
//  Copyright © 2017年 Tsou. All rights reserved.
//

/** 用于展示搜索结果的视图*/
#import <UIKit/UIKit.h>

@interface BaseSearchTableViewController : UITableViewController

/** 数据源*/
@property (nonatomic, strong) NSMutableArray *dataArray;
@end
