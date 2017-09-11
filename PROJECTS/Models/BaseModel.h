//
//  BaseModel.h
//  PROJECTS
//
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

/** model决定cell的height */
@property(assign, nonatomic) CGFloat height;

/** MJExtension 可以把后台返回的json串中的key，替换为自己的 */
+ (NSDictionary *)mj_replacedKeyFromPropertyName;

/** 数据库封装 */
-(instancetype)initWithDbSet:(FMResultSet*)set;

/** 没有单引号替换才可用 */
-(instancetype)initWithDictionary:(NSDictionary*)dictionary;

@end
