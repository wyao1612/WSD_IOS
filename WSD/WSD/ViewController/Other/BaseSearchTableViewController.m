//
//  BaseSearchTableViewController.m
//  WSD
//
//  Created by wyao on 2017/1/4.
//  Copyright © 2017年 Tsou. All rights reserved.
//

#import "BaseSearchTableViewController.h"

@interface BaseSearchTableViewController ()

@end

@implementation BaseSearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}


- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;

}

@end

