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

-(instancetype)initWithDbSet:(FMResultSet*)set
{
    self = [super init];
    if (self) {
//        _ID = [set intForColumnIndex:0];
    }
    return self;
}

-(instancetype)initWithDictionary:(NSDictionary*)dictionary
{
    self = [super init];
    if (self) {
        self = [[self class] mj_objectWithKeyValues:dictionary];//没有单引号替换才可用
    }
    return self;
}

@end
