//
//  ViewController.m
//  PROJECTS
//
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGRect frame = CGRectMake(0, 64, 64, 44);
    UIButton *push = [[UIButton alloc] initWithFrame:frame];
    [push setTitle:@"push" forState:UIControlStateNormal];
//    UIImage *bgImage = [UIImage imageWithHexColor:0xfff000 size:CGSizeMake(64, 44) cornerRadius:22];
    UIImage *bgImage = [UIImage imageWithHexColor:hexBackground];
    push.layer.masksToBounds = YES;
    push.layer.cornerRadius = 22;
    [push setBackgroundImage:bgImage forState:UIControlStateNormal];
    [push addTarget:self action:@selector(pushAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:push];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 200, 100, 200)];
    imageView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"victory"]];
    UIImage *image = [UIImage imageWithColor:[UIColor redColor]];
//    UIImage *image = [UIImage imageNamed:@"victory"];
    imageView.image = image;
//    imageView.contentMode = UIViewContentModeCenter;
    [self.view addSubview:imageView];
    
    UIButton *wellBeing = [[UIButton alloc] init];
    [wellBeing setTitle:@"wellBeing" forState:UIControlStateNormal];
    wellBeing.backgroundColor = [UIColor colorWithHex:0x345234];
    [wellBeing addTarget:self action:@selector(wellBeing) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:wellBeing];
    [wellBeing mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(push.mas_right).offset(msLeftRightMargin);
        make.top.offset(164);
        make.width.offset(100);
        make.height.offset(44);
    }];
    
    UIButton *localTest = [[UIButton alloc] init];
    [localTest setTitle:@"localTest" forState:UIControlStateNormal];
    localTest.backgroundColor = [UIColor colorWithHex:0x345234];
    [localTest addTarget:self action:@selector(localTest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:localTest];
    [localTest mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(push.mas_right).offset(msLeftRightMargin);
        make.top.offset(100);
        make.width.offset(100);
        make.height.offset(44);
    }];
}

-(void)wellBeing
{
    __block MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:NO];
    hud.label.text = @"我日ing";
    
    __block ViewController *weak = self;
    NSURLSessionDataTask *task = [TestNetwork getWellBeingCompletionHandler:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (!error) {
            //该网络事务是成功完成的
            if (responseObject[@"error"] == 0) {//这个判断由返回的json串定义
                //获取数据成功（获取数据的成功或失败 与 网络事务的成功失败 无关）
            }
        } else {
            //该网络事务失败
            if (error.code == -999) {
                //网络事务被取消
            }
        }
        [weak deleteTask:task];
        //        [MBProgressHUD hideHUDForView:weak.view animated:NO];
                [hud hideAnimated:NO];
    }];
    [self saveTask:task];
}

-(void)localTest
{
    __block MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:NO];
    hud.label.text = @"我日ing";
    
    __block ViewController *weak = self;
    NSURLSessionDataTask *task = [TestNetwork testLocalParameters:@{@"username":@"maomao", @"password":@"111111"} completionHandler:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (!error) {
            //该网络事务是成功完成的
        } else {
            //该网络事务失败
            if (error.code == -999) {
                //网络事务被取消
            }
        }
        [weak deleteTask:task];
        //        [MBProgressHUD hideHUDForView:weak.view animated:NO];
        [hud hideAnimated:NO];
    }];
    [self saveTask:task];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.navigationController.viewControllers.count > 5) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

-(void)pushAction:(UIButton*)button
{
    ViewController *vc = [[ViewController alloc] init];
    static int i = 0;
    vc.title = [NSString stringWithFormat:@"%d", i];
    i++;
    [self.navigationController pushViewController:vc animated:YES];
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
