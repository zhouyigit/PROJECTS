//
//  TestNetwork.m
//  PROJECTS
//
//

#import "TestNetwork.h"

@implementation TestNetwork

+(NSURLSessionDataTask *)getWellBeingCompletionHandler:(void (^)(NSURLSessionDataTask * _Nullable, id _Nullable, NSError * _Nullable))handler
{
    return [[self class] GET:@"福利/10/1" parameters:nil completionHandler:handler];
}

+(NSURLSessionDataTask *)testLocalParameters:(NSDictionary *)parameters completionHandler:(void (^)(NSURLSessionDataTask * _Nullable, id _Nullable, NSError * _Nullable))handler
{
    NSString *url = @"http://192.168.1.138:8080/base";
//    [[NetworkManager sharedManager].requestSerializer setValue:@"token" forHTTPHeaderField:@"Authorization"];
//    [[NetworkManager sharedManager].requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"contentType"];
    NSURLSessionDataTask *task = nil;
    task = [[NetworkManager sharedManager] POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, id  _Nullable responseObject) {
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

@end
