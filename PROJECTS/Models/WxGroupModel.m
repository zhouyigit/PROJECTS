//
//  WxGroupModel.m
//  PROJECTS
//
//

#import "WxGroupModel.h"

@implementation WxGroupModel

-(instancetype)initWithDbSet:(FMResultSet*)set
{
    self = [super init];
    if (self) {
        _gid = [set longForColumnIndex:0];
        _name = DanYinHaoOuter([set stringForColumnIndex:1]);
        _image = DanYinHaoOuter([set stringForColumnIndex:2]);
        _currentCount = [set longForColumnIndex:3];
        _maxCount = [set longForColumnIndex:4];
        _isManager = [set boolForColumnIndex:5];
        _desc = DanYinHaoOuter([set stringForColumnIndex:6]);
    }
    return self;
}

@end
