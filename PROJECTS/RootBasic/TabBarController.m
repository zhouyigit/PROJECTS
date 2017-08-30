
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
    ViewController *vc1 = [[ViewController alloc] init];
    vc1.hidesBottomBarWhenPushed = NO;
    vc1.view.backgroundColor = [UIColor greenColor];
    vc1.title = @"vc1";
    NavigationController *navc1 = [[NavigationController alloc] initWithRootViewController:vc1];
    [self addChildViewController:navc1];
    
    ViewController *vc2 = [[ViewController alloc] init];
    vc2.hidesBottomBarWhenPushed = NO;
    vc2.view.backgroundColor = [UIColor yellowColor];
    vc2.title = @"vc2";
    NavigationController *navc2 = [[NavigationController alloc] initWithRootViewController:vc2];
    [self addChildViewController:navc2];
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
