//
//  UIColor+Hex.h
//  PROJECTS
//
//颜色扩展十六进制

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

/**
*十六进制的颜色（以0x或0X开头）默认透明度1
*/
+ (UIColor*) colorWithHex:(long)hexColor;

/**
 *十六进制的颜色（以0x或0X开头）透明度
 */
+ (UIColor *)colorWithHex:(long)hexColor alpha:(float)alpha;

/**
 *十六进制的颜色字符串（以#开头）默认透明度1
 */
+ (UIColor *) colorWithHexString: (NSString *)color;

/**
 *十六进制的颜色字符串（以#开头）透明度
 */
+(UIColor*)colorWithHexString:(NSString*)color alpha:(float)alpha;

@end
