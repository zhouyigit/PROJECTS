//
//  DBWorks.h
//  PROJECTS
//
//数据库操作集合

#ifndef DBWorks_h
#define DBWorks_h


/// Document dir
#define APP_PATH_DOCUMENT	 [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
/// 本地主数据库名称
#define LOCAL_MAIN_DB_NAME      @"db.sqlite"
/// 本地主数据库完整路径
#define LOCAL_MAIN_DB_PATH      [APP_PATH_DOCUMENT stringByAppendingPathComponent:LOCAL_MAIN_DB_NAME]

//单引号 入库 出库
#define DanYinHaoEnter(__C1__) [__C1__ stringByReplacingOccurrencesOfString:@"'" withString:@"`~`~`"]
#define DanYinHaoOuter(__C1__) [__C1__ stringByReplacingOccurrencesOfString:@"`~`~`" withString:@"'"]

//我加入的微信群
#define Table_joined @"table_joined"
//我管理的微信群
#define Table_managed @"table_managed"

#import "WxGroupSqlWork.h"
#import "DBConfigLogic.h"

#endif /* DBWorks_h */
