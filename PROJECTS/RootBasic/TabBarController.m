
//
//  TabBarController.m
//  PROJECTS
//
//

#import "TabBarController.h"

@interface TabBarController ()

@end

@implementation TabBarController

-(instancetype)init
{//调用顺序init->viewDidLoad->init
    self = [super init];
    if (self) {
        [self addChildViewControllers];
    }
    return self;
}

#pragma mark 创建各个tab类
-(void)addChildViewControllers
{
    WechatGroupViewController *vc1 = [[WechatGroupViewController alloc] init];
    NavigationController *navc1 = [[NavigationController alloc] initWithRootViewController:vc1];
    [self addChildViewController:navc1];
    
//    TopTabBarViewController *vc2 = [[TopTabBarViewController alloc] initWithTitle:@"任务"];
//    vc2.hidesBottomBarWhenPushed = NO;
//    NavigationController *navc2 = [[NavigationController alloc] initWithRootViewController:vc2];
//    [self addChildViewController:navc2];
    
    ViewController *vc3 = [[ViewController alloc] init];
    vc3.hidesBottomBarWhenPushed = NO;
    vc3.view.backgroundColor = [UIColor yellowColor];
    vc3.title = @"我";
    NavigationController *navc3 = [[NavigationController alloc] initWithRootViewController:vc3];
    [self addChildViewController:navc3];
    
    MapViewController *vc4 = [[MapViewController alloc] init];
    vc4.hidesBottomBarWhenPushed = NO;
    vc4.title = @"地图";
    NavigationController *navc4 = [[NavigationController alloc] initWithRootViewController:vc4];
    [self addChildViewController:navc4];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
