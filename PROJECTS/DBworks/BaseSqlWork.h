//
//  BaseSqlWork.h
//  YiYaHanYu
//
//数据库事务创建基类

#import <Foundation/Foundation.h>
#import "BaseSqlManager.h"

#define DanYinHaoChangeOuter(__C1__) [__C1__ stringByReplacingOccurrencesOfString:@"'" withString:@"`~`~`"]
#define DanYinHaoChangeEnter(__C1__) [__C1__ stringByReplacingOccurrencesOfString:@"`~`~`" withString:@"'"]

@interface BaseSqlWork : NSObject

/**
 *查询以外的操作
 */
+(void)executeUpdate:(NSString*)sql;
+(void)executeUpdate:(NSString*)sql completedBlock:(void(^)(BOOL result))block;

/**
 *查询操作
 */
+(FMResultSet*)executeQuery:(NSString*)sql;

+(void)clearTable:(NSString*)table;

@end
