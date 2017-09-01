//
//  UIImage+Color.h
//  PROJECTS
//
//UIImage扩展纯色绘图方法

#import <UIKit/UIKit.h>

@interface UIImage (Color)

/**
 *纯色图片 默认size(1,1)
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 *纯色图片 默认size(1,1)
 */
+(UIImage*)imageWithHexColor:(long)hexColor;

/**
 *纯色图片 默认size(1,1)
 */
+(UIImage*)imageWithHexStringColor:(NSString*)hexString;

/**
 *纯色图片 尺寸
 */
+(UIImage*)imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 *圆角图片 有锯齿唉
 */
//-(UIImage*)imageWithCornerRadius:(CGFloat)radius;

/**
 *纯色圆角图片 有锯齿唉
 */
//+(UIImage*)imageWithHexColor:(long)color size:(CGSize)size cornerRadius:(CGFloat)radius;

@end
