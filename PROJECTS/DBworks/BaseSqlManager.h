//
//  BaseSqlManager.h
//  YiYaHanYu
//
//数据库事务执行类

#import <Foundation/Foundation.h>
#import "FMDB.h"
#import "FMDatabaseAdditions.h"

@interface BaseSqlManager : NSObject
{
    FMDatabaseQueue *_queue;//数据库操作唯一队列
    FMDatabase *_dbNow;//有些读库需要立即执行不能异步
}

+ (instancetype)shareInstance;
-(FMDatabaseQueue*)queue;
-(FMDatabase*)db;
@end
