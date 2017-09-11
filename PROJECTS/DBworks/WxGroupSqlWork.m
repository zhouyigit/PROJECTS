//
//  WxGroupSqlWork.m
//  PROJECTS
//
//  Created by yiyahanyu on 2017/9/11.
//  Copyright © 2017年 yiyahanyu. All rights reserved.
//

#import "WxGroupSqlWork.h"

@implementation WxGroupSqlWork

+(NSMutableArray*)getManagedGroups
{
    NSMutableArray *models = [NSMutableArray arrayWithCapacity:0];
    NSString *sql = [NSString stringWithFormat:@"select * from %@",Table_managed];
    
    FMResultSet *set = [self executeQuery:sql];
    
    while ([set next]) {
        WxGroupModel *model = [[WxGroupModel alloc] initWithDbSet:set];
        [models addObject:model];
    }
    [set close];
    return models;
}

+(void)addManagedGroup:(WxGroupModel*)model
{
    NSString *sql = [NSString stringWithFormat:@"insert into %@ values\
                     (%ld, '%@', '%@', %ld, %ld, %d, '%@')", Table_managed,
                     model.gid, model.name, model.image, model.currentCount, model.maxCount, model.isManager, model.desc];
    [[self class] executeUpdate:sql];
}

@end
