//
//  BaseSqlWork.m
//  YiYaHanYu
//
//

#import "BaseSqlWork.h"

@implementation BaseSqlWork

+(void)executeUpdate:(NSString*)sql {
    
    sql = [sql stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
    
    [[BaseSqlManager shareInstance].queue inDatabase:^(FMDatabase *db) {
        BOOL result = [db executeUpdate:sql];
        if (result) {
//            NSLog(@"数据库操作成功");
        }else{
            NSLog(@"数据库操作失败");
        }
    }];
}

+(void)executeUpdate:(NSString*)sql completedBlock:(void(^)(BOOL result))block
{
    
    sql = [sql stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
    
    [[BaseSqlManager shareInstance].queue inDatabase:^(FMDatabase *db) {
        BOOL result = [db executeUpdate:sql];
        if (result) {
//            YYLog(@"数据库操作成功");
        }else{
            NSLog(@"数据库操作失败");
        }
        block(result);
    }];
}

+(FMResultSet*)executeQuery:(NSString*)sql {
    FMResultSet *set = [[BaseSqlManager shareInstance].db executeQuery:sql];
    return set;
}

+(void)clearTable:(NSString*)table {
    NSString *sql = [NSString stringWithFormat:@"delete from %@",table];
    [self executeUpdate:sql];
}

@end
