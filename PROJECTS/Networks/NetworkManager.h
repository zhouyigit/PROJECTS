//
//  NetworkManager.h
//  PROJECTS
//
//网络事务 真正的发起者

#import "AFHTTPSessionManager.h"

@interface NetworkManager : AFHTTPSessionManager

+ (_Nonnull instancetype)sharedManager;

@end
