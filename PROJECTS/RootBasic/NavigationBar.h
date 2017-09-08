//
//  NavigationBar.h
//  JinFu
//
//  Created by yanggx on 16/12/28.
//  Copyright © 2016年 yangguixia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavigationBar : UIImageView
{
    UILabel *_title;//标题
    UIButton *_leftItem;//左键
    UIButton *_rightItem;//右键
    UILabel *_rightBadge;//右键消息提醒
    UIView *_lineView;//底部分割线
    UIImageView *_titleImageV;//图片标题
}

/**
 *设置标题
 */
-(void)setTitle:(nullable NSString*)title;

/**
 *获取标题
 */
-(nullable NSString*)getTitle;

/**
 *获取标题图片
 */
-(void)setTitleImage:(UIImage*_Nullable)image;

/**
 *获取标题图片
 */
-(UIImage*_Nullable)getTitleImage;

/**
 *设置左键事件
 */
-(void)setLeftItemTarget:(nullable id)target action:(nullable SEL)action forControlEvents:(UIControlEvents)controlEvents;

/**
 *设置右键事件
 */
-(void)setRightItemTarget:(nullable id)target action:(nullable SEL)action forControlEvents:(UIControlEvents)controlEvents;

/**
 *设置右键图片
 */
-(void)setRightItemImage:(nullable UIImage*)image forState:(UIControlState)state;

/**
 *设置右键文本
 */
-(void)setRightItemText:(nullable NSString*)text forState:(UIControlState)state;

/**
 *设置左键隐藏
 */
-(void)setLeftItemHidden:(BOOL)hidden;

/**
 *设置右键隐藏
 */
-(void)setRightItemHidden:(BOOL)hidden;

/**
 *设置右键badge
 */
-(void)setRightItemBadge:(int)badge;
/**
 * 设置底部分割线隐藏
 */
- (void)setLineViewHidder:(BOOL)hidden;

@end
