//
//  BaseNetwork.m
//  PROJECTS
//
//

#import "BaseNetwork.h"

@implementation BaseNetwork

+(void)commonRequest
{
    [[NetworkManager sharedManager].requestSerializer setValue:@"token" forHTTPHeaderField:@"Authorization"];
}

+(NSURLSessionDataTask *)POST:(NSString *)urlPath parameters:(id)parameters completionHandler:(void (^)(NSURLSessionDataTask * _Nullable, id _Nullable, NSError * _Nullable))handler
{
    [[self class] commonRequest];
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

+(NSURLSessionDataTask *)POST:(NSString *)urlPath json:(id)json completionHandler:(void (^)(NSURLSessionDataTask * _Nullable, id _Nullable, NSError * _Nullable))handler
{
    [[self class] commonRequest];
    __block NSURLSessionDataTask *task = nil;
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:UrlBuilder(urlPath)]];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [[json mj_JSONString] dataUsingEncoding:NSUTF8StringEncoding];
    
    task = [[NetworkManager sharedManager] dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        handler(task, responseObject, error);
    }];
    
    return task;
}

+(NSURLSessionDataTask *)GET:(NSString *)urlPath parameters:(id)parameters completionHandler:(void (^)(NSURLSessionDataTask * _Nullable, id _Nullable, NSError * _Nullable))handler
{
    [[self class] commonRequest];
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
    [[self class] commonRequest];
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

+(NSURLSessionDataTask *)POST:(NSString *)URLString json:(NSDictionary *)json progress:(void (^)(NSProgress * _Nullable))uploadProgress success:(void (^)(NSURLSessionDataTask * _Nullable, id _Nullable))success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nullable))failure
{
    [[self class] commonRequest];
    __block NSURLSessionDataTask *task = nil;
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [[json mj_JSONString] dataUsingEncoding:NSUTF8StringEncoding];
    
    task = [[NetworkManager sharedManager] dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (!error) {
            if (success) {
                success(task, responseObject);
            }
        } else {
            if (failure) {
                failure(task, error);
            }
        }
    }];
    
    return task;
}

+(NSURLSessionDataTask *)GET:(NSString *)urlPath
    parameters:(id)parameters
    success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
    failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure
{
    [[self class] commonRequest];
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
    [[self class] commonRequest];
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
