//
//  BaseSqlManager.m
//  YiYaHanYu
//
//

#import "BaseSqlManager.h"

@implementation BaseSqlManager

+ (instancetype)shareInstance
{//单例类，不释放
    static BaseSqlManager* shareManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager = [[BaseSqlManager alloc] init];
    });
    return shareManager;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        _queue = [FMDatabaseQueue databaseQueueWithPath:LOCAL_MAIN_DB_PATH];
        _dbNow = [FMDatabase databaseWithPath:LOCAL_MAIN_DB_PATH];
        [_dbNow open];
    }
    return self;
}

-(FMDatabaseQueue*)queue {
    return _queue;
}

-(FMDatabase *)db {
    return _dbNow;
}

@end
