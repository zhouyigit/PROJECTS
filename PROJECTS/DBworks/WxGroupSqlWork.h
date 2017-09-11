//
//  WxGroupSqlWork.h
//  PROJECTS
//
//  Created by yiyahanyu on 2017/9/11.
//  Copyright © 2017年 yiyahanyu. All rights reserved.
//

#import "BaseSqlWork.h"
#import "WxGroupModel.h"

@interface WxGroupSqlWork : BaseSqlWork

/** 获取我管理的微信群 */
+(NSMutableArray*)getManagedGroups;


+(void)addManagedGroup:(WxGroupModel*)model;

@end
