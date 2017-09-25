//
//  BaseNetwork.h
//  PROJECTS
//
//各种网络事务的基类，调用BaseNetworkManager发起事务
//配置host | 封装公共参数 | 封装token

#import <Foundation/Foundation.h>
#import "NetworkManager.h"
#import "AFURLRequestSerialization.h"

#define HTTPHOST @"http://gank.io/api/data/"

#define UrlBuilder(__C1__) [[NSString stringWithFormat:@"%@%@",HTTPHOST, __C1__] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]

@interface BaseNetwork : NSObject



/**
 *post请求
 *请求路径（不包含host）
 *请求参数
 *网络事务结果block(error非空时 相对于 网络事务失败block)
 */
+ (NSURLSessionDataTask * _Nullable )POST:(NSString * _Nullable)urlPath
                               parameters:(id _Nullable)parameters
                        completionHandler:(void (^_Nonnull)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject, NSError * _Nullable error))handler;

/**
 *post请求
 *请求路径（不包含host）
 *请求参数
 *网络事务结果block(error非空时 相对于 网络事务失败block)
 */
+ (NSURLSessionDataTask * _Nullable )POST:(NSString * _Nullable)urlPath
                               json:(id _Nullable)json
                        completionHandler:(void (^_Nonnull)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject, NSError * _Nullable error))handler;

/**
 *get请求
 *请求路径（不包含host）
 *请求参数
 *网络事务结果block(error非空时 相对于 网络事务失败block)
 */
+ (NSURLSessionDataTask * _Nullable )GET:(NSString * _Nullable)urlPath
                               parameters:(id _Nullable)parameters
                        completionHandler:(void (^_Nonnull)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject, NSError * _Nullable error))handler;

/**
 *post请求
 *请求路径（不包含host）
 *请求参数
 *网络事务成功block
 *网络事务失败block
 */
+ (NSURLSessionDataTask * _Nullable )POST:(NSString * _Nullable)urlPath
                               parameters:(id _Nullable)parameters
                                  success:(void (^ _Nullable)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))success
                                  failure:(void (^ _Nullable)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure;


/**
 *post请求
 *请求路径（不包含host）
 *请求参数
 *网络事务结果block(error非空时 相对于 网络事务失败block)
 */
+ (nullable NSURLSessionDataTask *)POST:(NSString *_Nonnull)URLString
                                   json:(nullable NSDictionary*)json
                               progress:(nullable void (^)(NSProgress * _Nullable uploadProgress))uploadProgress
                                success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure;

/**
 *get请求
 *请求路径（不包含host）
 *请求参数
 *网络事务成功block
 *网络事务失败block
 */
+ (NSURLSessionDataTask * _Nullable )GET:(NSString * _Nullable)urlPath
                              parameters:(id _Nullable)parameters
                                 success:(void (^ _Nullable)(NSURLSessionDataTask * _Nonnull task , id _Nullable responseObject))success
                                 failure:(void (^ _Nullable)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure;

/**
 *post上传
 *请求路径（不包含host）
 *请求参数
 *生成文件封装block
 *网络事务成功block
 *网络事务失败block
 */
+ (nullable NSURLSessionDataTask *)POST:(NSString * _Nullable)urlPath
                             parameters:(nullable id)parameters
              constructingBodyWithBlock:(nullable void (^)(id <AFMultipartFormData> _Nullable formData))block
                                success:(nullable void (^)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))success
                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *_Nonnull error))failure;

@end
