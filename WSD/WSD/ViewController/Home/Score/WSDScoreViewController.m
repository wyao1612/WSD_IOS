//
//  WSDScoreViewController.m
//  WSD
//
//  Created by wyao on 2017/1/12.
//  Copyright © 2017年 Tsou. All rights reserved.
//

#import "WSDScoreViewController.h"
#import "YW_SegmentSwitch.h"
#import "UINavigationBar+Awesome.h"

#define NAVBAR_CHANGE_POINT 50


@interface WSDScoreViewController ()
<UITableViewDelegate,
UITableViewDataSource
>
@property(strong,nonatomic)UITableView *tableview;

@end

@implementation WSDScoreViewController

-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.backgroundColor = [UIColor whiteColor];
    }
    return _tableview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    YW_SegmentSwitch *segmetView = [[YW_SegmentSwitch alloc] init];
    segmetView.frame = CGRectMake(0, 0, 200, 35);
    segmetView.backgroundColor = [UIColor whiteColor];
    segmetView.cornerRadius = 17.5;
    segmetView.titleNormalColor = SHENTEXTCOLOR;
    segmetView.titleSelectedColor = WHITECOLOR;
    segmetView.selectionColor = [UIColor colorWithHex:0xfecb2f];
    segmetView.titles = @[@"成绩",@"评价"];
    segmetView.layer.borderWidth = 0.5;
    segmetView.layer.borderColor = [[UIColor blackColor] CGColor];
    
    [self.navigationItem setTitleView:segmetView];
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] init];
    rightBarItem.title = @"历史成绩";
    rightBarItem.tintColor = SHENTEXTCOLOR;
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
    
    [self.view addSubview:self.tableview];
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor colorWithHex:0xf2f2f2]];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_reset];
}


#pragma mark UITableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = @"一年级第一次月考";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
