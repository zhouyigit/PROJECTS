//
//  BaseNetwork.m
//  PROJECTS
//
//

#import "BaseNetwork.h"

@implementation BaseNetwork

+(NSURLSessionDataTask *)POST:(NSString *)urlPath parameters:(id)parameters completionHandler:(void (^)(NSURLSessionDataTask * _Nullable, id _Nullable, NSError * _Nullable))handler
{
    [[NetworkManager sharedManager].requestSerializer setValue:@"token" forHTTPHeaderField:@"Authorization"];
    NSURLSessionDataTask *task = nil;
    task = [[NetworkManager sharedManager] POST:UrlBuilder(urlPath) parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, id  _Nullable responseObject) {
        if (handler) {
            handler(task, responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
        if (handler) {
            handler(task, nil, error);
        }
    }];
    return task;
}

+(NSURLSessionDataTask *)GET:(NSString *)urlPath parameters:(id)parameters completionHandler:(void (^)(NSURLSessionDataTask * _Nullable, id _Nullable, NSError * _Nullable))handler
{
    [[NetworkManager sharedManager].requestSerializer setValue:@"token" forHTTPHeaderField:@"Authorization"];
    NSURLSessionDataTask *task = nil;
    task = [[NetworkManager sharedManager] GET:UrlBuilder(urlPath) parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, id  _Nullable responseObject) {
        if (handler) {
            handler(task, responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
        if (handler) {
            handler(task, nil, error);
        }
    }];
    return task;
}

+(NSURLSessionDataTask *)POST:(NSString *)urlPath
    parameters:(id)parameters
    success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
    failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure
{
    [[NetworkManager sharedManager].requestSerializer setValue:@"token" forHTTPHeaderField:@"Authorization"];
    
    NSURLSessionDataTask *task = nil;
    task = [[NetworkManager sharedManager] POST:UrlBuilder(urlPath) parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(task, responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(task, error);
        }
        
    }];
    return task;
}

+(NSURLSessionDataTask *)GET:(NSString *)urlPath
    parameters:(id)parameters
    success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
    failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure
{
    [[NetworkManager sharedManager].requestSerializer setValue:@"token" forHTTPHeaderField:@"Authorization"];
    
    NSURLSessionDataTask *task = nil;
    task = [[NetworkManager sharedManager] GET:UrlBuilder(urlPath) parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(task, responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(task, error);
        }
        
    }];
    
    return task;
}

+(NSURLSessionDataTask *)POST:(NSString *)urlPath
    parameters:(id)parameters
    constructingBodyWithBlock:(void (^)(id<AFMultipartFormData> _Nullable))block
    success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
    failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure
{
    [[NetworkManager sharedManager].requestSerializer setValue:@"token" forHTTPHeaderField:@"Authorization"];
    
    NSURLSessionDataTask *task = nil;
    task = [[NetworkManager sharedManager] POST:UrlBuilder(urlPath) parameters:parameters constructingBodyWithBlock:block progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(task, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(task, error);
        }
    }];
    return task;
}

@end
