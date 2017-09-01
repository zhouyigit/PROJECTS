//
//  NetworkManager.m
//  PROJECTS
//
//

#import "NetworkManager.h"

@implementation NetworkManager

+ (instancetype)sharedManager {
    
    //PS:3.0非单例会发生内存泄露
    //单例Manager
    //Manager内部使用operationQueue
    //并且operationQueue.maxConcurrentOperationCount = 1
    
    static NetworkManager *_share = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _share = [[self class] manager];
        _share.requestSerializer.timeoutInterval = 30;
        _share.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    return _share;
}

-(void)dealloc {
    NSLog(@"单例释放不了了");
}

@end
