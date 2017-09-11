//
//  RefreshTableViewController.m
//  PROJECTS
//
//  Created by yiyahanyu on 2017/9/11.
//  Copyright © 2017年 yiyahanyu. All rights reserved.
//

#import "RefreshTableViewController.h"

@interface RefreshTableViewController ()

@end

@implementation RefreshTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerPullAction)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerPullAction)];
}

- (void)headerPullAction {
    [self.tableView.mj_header endRefreshing];
}

- (void)footerPullAction {
    [self.tableView.mj_footer endRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
