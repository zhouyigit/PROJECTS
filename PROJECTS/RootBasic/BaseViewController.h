//
//  BaseViewController.h
//  PROJECTS
//
//所有可视ViewController的基类，编码基本布局和样式

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property(strong, nonatomic) NSString *umengPage;

/** 保存执行中的task，删除被取消和完成的task */
@property(strong, nonatomic) NSMutableDictionary *tasks;

/**
 *（需要手动释放的子类，覆盖该方法）vc被pop后，手动释放something，从而是dealloc方法可以被调用，达到真正的vc释放
 */
-(void)releaseSomething;

/**
 *保存执行中的task
 */
-(void)saveTask:(NSURLSessionDataTask*)task;

/**
 *删除被取消和完成的task
 */
-(void)deleteTask:(NSURLSessionDataTask*)task;

/**
 *删除被取消和完成的task
 */
-(void)deleteTasks;

@end
