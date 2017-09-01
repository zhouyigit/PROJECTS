//
//  UIImage+Color.m
//  PROJECTS
//
//

#import "UIImage+Color.h"

@implementation UIImage (Color)

#pragma mark 纯色图片 默认size(1,1)
+ (UIImage *)imageWithColor:(UIColor *)color
{
    return [[self class] imageWithColor:color size:CGSizeMake(1, 1)];//如果设置一个像素，填充imageView时会变得有透明度
}
#pragma mark 纯色图片 默认size(1,1)
+(UIImage*)imageWithHexColor:(long)hexColor
{
    UIColor *color = [UIColor colorWithHex:hexColor];
    return [[self class] imageWithColor:color];
}

#pragma mark 纯色图片 默认size(1,1)
+(UIImage*)imageWithHexStringColor:(NSString*)hexString
{
    UIColor *color = [UIColor colorWithHexString:hexString];
    return [[self class] imageWithColor:color];
}

#pragma mark 纯色图片 尺寸
+(UIImage*)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

#pragma mark 圆角图片 有锯齿唉
-(UIImage*)imageWithCornerRadius:(CGFloat)radius
{
    UIImage *original = self;
    CGRect frame = CGRectMake(0, 0, original.size.width, original.size.height);
    // 开始一个Image的上下文
    UIGraphicsBeginImageContextWithOptions(original.size, NO, 1.0);
    // 添加圆角
    [[UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:radius] addClip];
    // 绘制图片
    [original drawInRect:frame];
    // 接受绘制成功的图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark 纯色圆角图片 有锯齿唉
+(UIImage*)imageWithHexColor:(long)hexColor size:(CGSize)size cornerRadius:(CGFloat)radius
{
    UIColor *color = [UIColor colorWithHex:hexColor];
    UIImage *image = [[self class] imageWithColor:color size:size];
    return [image imageWithCornerRadius:radius];
}

@end
