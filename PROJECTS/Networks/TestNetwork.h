//
//  TestNetwork.h
//  PROJECTS
//
//网络事务封装和使用demo
//把同一模块的网络事务新建一个类

#import "BaseNetwork.h"

@interface TestNetwork : BaseNetwork

/**
*获取福利
*/
+ (NSURLSessionDataTask * _Nullable )getWellBeingCompletionHandler:(void (^_Nonnull)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject, NSError * _Nullable error))handler;


/**
 *本地网络测试
 */
+ (NSURLSessionDataTask * _Nullable )testLocalParameters:(NSDictionary*_Nullable)parameters completionHandler:(void (^_Nonnull)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject, NSError * _Nullable error))handler;

@end
