//
//  TopTabBarViewController.m
//  PROJECTS
//
//

#import "TopTabBarViewController.h"

@interface TopTabBarViewController ()

@end

@implementation TopTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.hidesBottomBarWhenPushed = NO;
}

-(void)initTitleButtons:(NSArray<NSString*>*)titles
{
    _top = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 64)];
    _top.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_top];
    
    _buttons = [NSMutableArray arrayWithCapacity:titles.count];
    for (int i=0; i<titles.count; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.bounds)/2+100*(i-1), 20, 100, 44)];
        button.tag = i;
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(titleButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            [button setSelected:YES];
        } else {
            [button setSelected:NO];
        }
        [_top addSubview:button];
        [_buttons addObject:button];
    }
}
-(void)titleButtonDidClicked:(UIButton*)button;
{
    _currentIndex = (int)button.tag;
    [self reloadTitleButtons];
    [_scrollView setContentOffset:CGPointMake(CGRectGetWidth(_scrollView.bounds)*_currentIndex, 0) animated:YES];
}

-(void)initRightButton:(NSString*)title target:(id)target sel:(SEL)sel
{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(_top.bounds)-64, 20, 64, 44)];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    [_top addSubview:button];
}

-(void)initVCs
{
    self.automaticallyAdjustsScrollViewInsets = NO;//scrollview偏移20
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-64-49)];
    _scrollView.pagingEnabled = YES;
    _scrollView.contentSize = CGSizeMake(2*CGRectGetWidth(_scrollView.bounds), 0);
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    _vcs = [NSMutableArray arrayWithCapacity:2];
}

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    CGFloat x = targetContentOffset->x;
    float l = x/CGRectGetWidth(scrollView.bounds);
    _currentIndex = (int)(l+0.5);
    
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (decelerate) {
        //
    } else {
        [self reloadTitleButtons];
    }
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self reloadTitleButtons];
}

-(void)reloadTitleButtons
{
    for (int i=0; i<_buttons.count; i++) {
        UIButton *button = _buttons[i];
        if (button.tag == _currentIndex) {
            [button setSelected:YES];
        } else {
            [button setSelected:NO];
        }
    }
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
