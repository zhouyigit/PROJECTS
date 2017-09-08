//
//  BaseModel.m
//  PROJECTS
//
//

#import "BaseModel.h"

@implementation BaseModel

-(instancetype)init
{
    self = [super init];
    if (self) {
        _height = 44;
    }
    return self;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID" : @"id"};
}

@end
