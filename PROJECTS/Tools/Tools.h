//
//  Tools.h
//  PROJECTS
//
//工具类的集合

#ifndef Tools_h
#define Tools_h

/** 一像素 */
#define OnePX (1/[UIScreen mainScreen].scale)
/** 屏幕宽度 */
#define WIDTH [UIScreen mainScreen].bounds.size.width
/** 屏幕高度 */
#define HEIGHT [UIScreen mainScreen].bounds.size.height

/** 导航控制器 **/
#define NavC ((NavigationController*)TabC.selectedViewController)
#define TabC ((TabBarController*)[UIApplication sharedApplication].delegate.window.rootViewController)
/** 字符串转换 **/
#define StringFromAny(__C1__) [NSString stringWithFormat:@"%@",__C1__]
#define StringFromLong(__C1__) [NSString stringWithFormat:@"%ld",__C1__]
#define StringFromInt(__C1__) [NSString stringWithFormat:@"%d",__C1__]
#define StringFromFloat(__C1__) [NSString stringWithFormat:@"%f",__C1__]
#define StringFromFloat2(__C1__) [NSString stringWithFormat:@"%.2f",__C1__]
#define StringFromFloat4(__C1__) [NSString stringWithFormat:@"%.4f",__C1__]
/** 空字符串 **/
#define StringIsEmpty(__C1__) ((!__C1__) || ([@"" isEqualToString:__C1__]))

#import "UIImage+Color.h"
#import "UIColor+Hex.h"


#endif /* Tools_h */
