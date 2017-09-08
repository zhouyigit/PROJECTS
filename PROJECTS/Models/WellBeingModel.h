//
//  WellBeingModel.h
//  PROJECTS
//
//福利模型
/**
 "_id" = 59a8cfdc421aa901c1c0a8c7;
 createdAt = "2017-09-01T11:11:24.81Z";
 desc = "9-1";
 publishedAt = "2017-09-01T12:55:52.582Z";
 source = chrome;
 type = "\U798f\U5229";
 url = "https://ws1.sinaimg.cn/large/610dc034ly1fj3w0emfcbj20u011iabm.jpg";
 used = 1;
 who = daimajia;
 */

#import "BaseModel.h"

@interface WellBeingModel : BaseModel

@property(strong, nonatomic) NSString *_id;
@property(strong, nonatomic) NSString *createdAt;
@property(strong, nonatomic) NSString *desc;
@property(strong, nonatomic) NSString *publishedAt;
@property(strong, nonatomic) NSString *source;
@property(strong, nonatomic) NSString *type;
@property(strong, nonatomic) NSString *url;
@property(strong, nonatomic) NSString *used;
@property(strong, nonatomic) NSString *who;
@property(assign, nonatomic) CGFloat imageHeight;

@end
