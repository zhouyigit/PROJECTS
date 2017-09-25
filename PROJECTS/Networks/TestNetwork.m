//
//  TestNetwork.m
//  PROJECTS
//
//

#import "TestNetwork.h"

@implementation TestNetwork

+(NSURLSessionDataTask *)getWellBeingCompletionHandler:(void (^)(NSURLSessionDataTask * _Nullable, id _Nullable, NSError * _Nullable))handler
{
    static int day = 0;
    day++;
    NSDictionary *dict = @{@"page" : StringFromInt(day)};
    [MobClick event:@"getWellBeing" attributes:dict];
    NSString *path = [NSString stringWithFormat:@"福利/10/%d", day];
    return [[self class] GET:path parameters:nil completionHandler:handler];
}

+(NSURLSessionDataTask *)testLocalParameters:(NSDictionary *)parameters completionHandler:(void (^)(NSURLSessionDataTask * _Nullable, id _Nullable, NSError * _Nullable))handler
{
    NSString *url = @"http://192.168.1.137:8080/base";
    NSURLSessionDataTask *task = nil;
    task = [[self class] POST:url json:parameters progress:nil success:^(NSURLSessionDataTask *task, id  _Nullable responseObject) {
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
