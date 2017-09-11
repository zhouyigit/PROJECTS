//
//  TopTabBarViewController.h
//  PROJECTS
//
//

#import <UIKit/UIKit.h>

@interface TopTabBarViewController : UIViewController<UIScrollViewDelegate>
{
    NSMutableArray<UIButton*> *_buttons;
}
@property(assign, nonatomic) int currentIndex;//当前显示的第几页
@property(strong, nonatomic) UIView *top;
@property(strong, nonatomic) UIScrollView *scrollView;
@property(strong, nonatomic) NSMutableArray *vcs;

-(void)initTitleButtons:(NSArray<NSString*>*)titles;
-(void)initVCs;
-(void)initRightButton:(NSString*)title target:(id)target sel:(SEL)sel;

@end
