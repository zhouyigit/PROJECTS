//
//  DBConfigLogic.m
//  ARDBConfigDemo
//
//  功能说明：
//  提供一个数据库表结构更新的机制，保证用户无论从哪个版本安装程序，数据库结构保证适配。
//  如:用户A数据库版本是v1，用户B是v2，用户C没装过App这次新装；所有用户安装运行数据库版本是v3的App后，用户A数据库会v1->v2->v3依次升级，用户B会v2->v3依次升级，用户C会v1->v2->v3依次升级数据库。
//
//  使用说明：
//  1、第一次创建工程，新建数据库的情况（数据库版本为1）：
//  （1）新建一个继承于RLDBConfigBase的类，如DBConfigLogic。
//  （2）添加int类型只读属性dbVersion，实现get方法并return 1；
//  （3）添加覆盖父类方法onCreate，并在方法内写下第一次创建数据表结构的SQL及代码。
//  （4）在程序启动时（如AppDelegate.m）实例化DBConfigLogic类并调用checkDatabase方法，即可完成数据库的初始化动作。
//
//  2、App在某一版本数据库结构需要改动时（数据库版本升为2）：
//  （1）在步骤1的基础上，修改dbVersion属性方法的返回值为return 2。
//  （2）在步骤1的基础上，添加覆盖父类方法onUpgrade，使用本文onUpgrade内示范代码，只需修改switch内的代码。
//  （3）如果在数据库结构升级完成后需要做一些后续数据处理，可以添加覆盖父类的方法didChecked，写入数据库操作的代码。
//  （4）在程序启动时（如AppDelegate.m）实例化DBConfigLogic类并调用checkDatabase方法，即可完成数据库的初始化和升级动作。
//
//  Created by LongJun on 15/3/23.
//  Copyright (c) 2015年 Arwer. All rights reserved.
//

#import "DBConfigLogic.h"

@implementation DBConfigLogic


#pragma mark 自定义方法开始
-(BOOL)createGroupTable:(NSString*)table withDB:(FMDatabase*)db {
    NSString *sql = [NSString stringWithFormat:@"create table if not exists %@ \
                     (gid long,\
                     name text,\
                     image text,\
                     currentCount lone,\
                     maxCount lone,\
                     isManager int,\
                     desc text)"
                     ,table];
    BOOL result = [db executeUpdate:sql];
    if (result) {
        
    }else{
        NSLog(@"create table news failed");
    }
    return result;
}
#pragma mark 自定义方法结束


#pragma mark - Override the parent class's methods

/**
 * 第一次创建数据库时的sql。注意不需要写事务，父类已经启动事务
 *
 * @param db FMDB的数据库对象
 */
- (BOOL)onCreate:(FMDatabase *)db
{
    NSLog(@">>> onCreate");
    
    if (!db) {
        NSAssert(0, @"db can't be null");
        return false;
    }
    
    @try {
        
        //////////////// 在此处添加第一次创建表和初始化的SQL ///////////////////////////////
        
        
        BOOL result = YES;
        
        //  执行表创建工作
        result = [self createGroupTable:Table_joined withDB:db];
        result = [self createGroupTable:Table_managed withDB:db];
        
        //建表结果
        if (result) {
            //
        }else{
            NSLog(@"有表创建失败");
            return NO;
        }
        /////////////////////////////////////// END ////////////////////////////////////////////
        
        
        //第一次创建数据库即self.dbVersion=1时，可以不用实现覆盖方法onUpgrade，此处可以直接return true;
        //self.dbVersion>1时,实现覆盖方法onUpgrade并调用它，是为了保证用户从不管从哪个版本新安装，都保证数据库版本更新到最新版。
        //如:用户A数据库版本是v1，用户B是v2，用户C没装过App这次新装；当前数据库版本是v3，安装运行App后，用户A会v1->v2->v3，用户B会v2->v3，用户C会v1->v2->v3依次升级数据库。
        return [self onUpgrade:db oldVersion:DBCONFIG_FIRST_VER newVersion:self.dbVersion];
        
    }
    @catch (NSException *exception) {
        NSAssert1(0, @"Exception: %@", exception.reason);
        return false;
    }
    @finally {
        
    }
    
}

/**
 * 数据库版本相等时需要做的事情可以在该方法实现。
 *
 * @param db FMDB的数据库对象
 * @param oldVersion 当期数据库的版本
 * @param newVersion 要更新的新的数据库的版本
 */
- (BOOL)onEqual:(FMDatabase *)db oldVersion:(int)oldVersion newVersion:(int)newVersion {
    
    NSLog(@">>> onEqual, oldVersion=%d, newVersion=%d", oldVersion, newVersion);
    
//    //Such as:
//    //Clear table t_Worklog (demo need)
//    BOOL result = [db executeUpdate:@"DELETE FROM t_Worklog"];
//    if (!result) {
//        //JFLog(@"remove table t_Worklog all rows Failed");
//        return false;
//    }
    return true;
}

/**
 * 数据库版本增加时的方法，比如数据库表结构发生变化，要从版本v1升级到版本v2
 *
 * @param db FMDB的数据库对象
 * @param oldVersion 当期数据库的版本
 * @param newVersion 要更新的新的数据库的版本
 */
- (BOOL)onUpgrade:(FMDatabase *)db oldVersion:(int)oldVersion newVersion:(int)newVersion
{
    NSLog(@">>> onUpgrade, oldVersion=%d, newVersion=%d", oldVersion, newVersion);
    
    if (!db) {
        NSAssert(0, @"db can't be null");
        return false;
    }
    
    @try {
        // 升级数据库
        // 使用for实现跨版本升级数据库，代码逻辑始终会保证顺序递增升级。
        BOOL rev = NO;
        for(int ver = oldVersion; ver < newVersion; ver++) {
            rev = NO;
            switch(ver) {
                case 1: //v1-->v2
                    rev = [self upgradeVersion1To2:db];
                    break ;
                case 2: //v2-->v3
//                    rev = [self upgradeVersion2To3:db];
                    rev = YES;//因为v4到v5把表删除了，所以这里就忽略了直接返回YES
                    break ;
                case 3: //v3-->v4
//                    rev = [self upgradeVersion3To4:db];
                    rev = YES;//因为v4到v5把表删除了，所以这里就忽略了直接返回YES
                    break ;
                    
                //变更比较大 删除后重建
                case 4: //v4-->v5
                    rev = [self upgradeVersion4To5:db];
                    break ;
                    
                    
                    
                    
                    
                    //有新的版本在此处添加case 3、case 4等等。
                default :
                    break ;
            }
            if (!rev) return false;
        }
        
        //
        return true;
    }
    @catch (NSException *exception) {
        NSAssert1(0, @"Exception: %@", exception.reason);
        return false;
    }
    @finally {
        
    }
}

///**
// * 数据库版本降级时的方法。实现数据库版本降级时的代码。
// * 注：默认降级是禁止的，如果要使用，在本类实例化后，设置allowDowngrade = YES;然后再调用checkDatabase方法。
// *
// * @param db FMDB的数据库对象
// * @param oldVersion 当期数据库的版本
// * @param newVersion 要更新的新的数据库的版本
// * @return YES=成功，NO=失败
// */
//- (BOOL)onDowngrade:(FMDatabase *)db oldVersion:(int)oldVersion newVersion:(int)newVersion {
//
//    JFLog(@">>> onDowngrade, oldVersion=%d, newVersion=%d", oldVersion, newVersion);
//
//    if (!db) {
//        NSAssert(0, @"db can't be null");
//        return false;
//    }
//
//    @try {
//        // 降级数据库
//        // 使用for实现跨版本降级数据库，代码逻辑始终会保证顺序递减。
//        BOOL rev = NO;
//        for(int ver = oldVersion; ver > newVersion; ver--) {
//            rev = NO;
//            switch(ver) {
//                case 3: //v3-->v2
////                    rev = [self downgradeVersion3To2:db];
//                    break ;
//                case 2: //v2-->v1
////                    rev = [self downgradeVersion2To1:db];
//                    break ;
//                default :
//                    break ;
//            }
//            if (!rev) return false;
//        }
//
//        //
//        return true;
//    }
//    @catch (NSException *exception) {
//        NSAssert1(0, @"Exception: %@", exception.reason);
//        return false;
//    }
//    @finally {
//
//    }
//}

/**
 * 数据库配置检查完成后会调用的方法。可以实现数据库版本升级后的一些后续数据处理。
 *
 * @param db FMDB的数据库对象
 * @param dbCheckIsSuccess 数据库配置检查是否成功了
 */
- (void)didChecked:(FMDatabase *)db dbCheckIsSuccess:(BOOL)dbCheckIsSuccess
{
    if (!dbCheckIsSuccess) return;
    
    //do db something
    //...
    
}

#pragma mark - Custom Method

/**
 * 数据库版本从v1升级到v2。
 *
 * 主要功能有：
 * 1.缓存功能表 新增file_size列
 */
- (BOOL)upgradeVersion1To2:(FMDatabase *)db
{
    return YES;
}

/**
 * 数据库版本从v2升级到v3。
 *
 * 主要功能有：
 * 1.给主表(首页的关注，热门，最新三个表)增加字段shareDesc
 */
- (BOOL)upgradeVersion2To3:(FMDatabase *)db
{
    return true;
}

/**
 * 数据库版本从v3升级到v4。
 *
 * 主要功能有：
 * 1.给主表(首页的关注，热门，最新三个表)增加字段hotTime
 */
- (BOOL)upgradeVersion3To4:(FMDatabase *)db
{
    //do something...
    return true;
}


/**
 *从v4到v5，删除老表创建新表
 */
-(NSString*)deleteOldTable:(NSString*)table
{
    return [NSString stringWithFormat:@"DROP TABLE %@;",table];
}

/**
 * 数据库版本从v4升级到v5。
 *
 * 主要功能有：删除主表并重建
 * xxxxx
 */
- (BOOL)upgradeVersion4To5:(FMDatabase *)db
{
    //do something...
    
    return true;
}

/**
 * 数据库版本从v5升级到v6。
 *
 * 主要功能有：
 * xxxxx
 */
- (BOOL)upgradeVersion5To6:(FMDatabase *)db
{
    //do something...
    
    
    return true;
}

#pragma mark - Custom Property

/**
 * 只读属性，当前项目的数据库版本号，如果下一次数据库表结构或数据要更改，请在原数字上加1.
 *
 * 如：第一次工程创建时dbVersion请设为1；软件迭代升级了几次后要修改数据库表结构或数据要更改，则修改dbVersion=2；每次升级数据库请把版本号累加。
 */
- (int)dbVersion
{
    /*
     备注：
     DB走DB的版本号，App走App的版本号，互不冲突，互不影响，这里备注只是记录而已。
     dbVersion=1，appVersion=1.3.2：首页列表(创建第一版数据库)。
     dbVersion=1，appVersion=1.3.3：缓存列表
     dbVersion=1，appVersion=1.3.6:缓存列表报错（file_size)
     dbVersion=2，appVersion=1.3.7:修复1.3.2-1.3.6的数据库错误（dbVersion=1的记录有些混乱，从2开始重新记录）
     dbVersion=2，appVersion=1.3.8:(尼玛1.3.7发布的时候是不是没有改成2啊)
     dbVersion=2,appVersion=1.3.9:新增categoryVersion表
     */
    return 1;//数据库新增表（onCreate）时，不变；修改老表(onUpgrade)时，+1；
}

@end
