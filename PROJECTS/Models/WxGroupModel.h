//
//  WxGroupModel.h
//  PROJECTS
//
//微信群数据模型

#import "BaseModel.h"

@interface WxGroupModel : BaseModel

@property (assign, nonatomic) NSInteger gid;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *image;
@property (assign, nonatomic) NSInteger currentCount;
@property (assign, nonatomic) NSInteger maxCount;
@property (assign, nonatomic) BOOL isManager;
@property (strong, nonatomic) NSString *desc;

@end
