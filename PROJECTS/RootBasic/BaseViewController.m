//
//  BaseViewController.m
//  PROJECTS
//
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

-(instancetype)init
{
    self = [super init];
    if (self) {
        
        
        //初始化task容器
        self.tasks = [[NSMutableDictionary alloc] initWithCapacity:0];
        
        //vc展现时，隐藏tabbar
        self.hidesBottomBarWhenPushed = YES;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置背景色，该方法如果放在init方法中，会触发viewDidLoad方法
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:self.umengPage];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:self.umengPage];
}

//-(void)willMoveToParentViewController:(UIViewController *)parent
//{
//    [super willMoveToParentViewController:parent];
//}

-(void)didMoveToParentViewController:(UIViewController *)parent
{
    [super didMoveToParentViewController:parent];
    if (parent == nil) {
        NSLog(@"vc_%@ did poped.", self.title);
        [self releaseSomething];
    }
}

-(void)releaseSomething
{
    [self deleteTasks];
    self.tasks = nil;
}

-(void)saveTask:(NSURLSessionDataTask *)task
{
    NSLog(@"inside==%@", task);
    [self.tasks setObject:task forKey:@(task.taskIdentifier)];
}

-(void)deleteTask:(NSURLSessionDataTask *)task
{
    NSLog(@"inside==%@", task);
    if (task.state == NSURLSessionTaskStateRunning) {
        [task cancel];
    }
    [self.tasks removeObjectForKey:@(task.taskIdentifier)];
}

-(void)deleteTasks
{
    for (NSURLSessionDataTask *task in self.tasks.allValues) {
        if (task.state == NSURLSessionTaskStateRunning) {
            [task cancel];
        }
    }
    [self.tasks removeAllObjects];
}

-(void)dealloc
{
    NSLog(@"vc_%@ did dealloc", self.title);
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
