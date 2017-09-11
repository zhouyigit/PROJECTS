//
//  RefreshTableViewController.h
//  PROJECTS
//
//  Created by yiyahanyu on 2017/9/11.
//  Copyright © 2017年 yiyahanyu. All rights reserved.
//

#import "BaseTableViewController.h"
#import "MJRefresh.h"

@interface RefreshTableViewController : BaseTableViewController

/**
 *刷新动作触发的方法，子类必须重写该方法
 */
-(void)headerPullAction;
/**
 *刷新动作触发的方法，子类必须重写该方法
 */
-(void)footerPullAction;

@end
