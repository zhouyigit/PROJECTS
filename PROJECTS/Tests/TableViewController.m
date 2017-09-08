//
//  TableViewController.m
//  PROJECTS
//
//

#import "TableViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController

-(instancetype)initWithDataSource:(NSArray*)array
{
    self = [super init];
    if (self) {
        _dataSource = [NSMutableArray arrayWithArray:array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = YES;
    
    
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView registerClass:[WellBeingCell class] forCellReuseIdentifier:@"cell"];
    _tableView.estimatedRowHeight = 44;
    [self.view addSubview:_tableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSLog(@"numberOfRowsInSection-%ld", (long)section);
    return _dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WellBeingModel *model = _dataSource[indexPath.row];
//    NSLog(@"heightForRowAtIndexPath-%ld-%f", indexPath.row, model.height);
    return model.height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"cellForRowAtIndexPath-%ld", indexPath.row);
    WellBeingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.delegate = self;
    WellBeingModel *model = _dataSource[indexPath.row];
    [cell setModel:model atIndexPaht:indexPath];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    [_dataSource replaceObjectAtIndex:indexPath.row withObject:@(100)];
    
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
//    NSLog(@"willBeginDragging");
    _tableViewScrolling = YES;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSLog(@"didScroll");
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (decelerate) {
        //
    } else {
        [self reloadNeedReloadIndexPaths];
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self reloadNeedReloadIndexPaths];
}

-(void)reloadNeedReloadIndexPaths
{
    if (_needReloadIndexPaths.count > 0) {
        [_tableView reloadRowsAtIndexPaths:_needReloadIndexPaths withRowAnimation:UITableViewRowAnimationNone];
    }
    [_needReloadIndexPaths removeAllObjects];
    _tableViewScrolling = NO;
}

-(void)wellBeingCellNeedReloadAtIndexPath:(NSIndexPath *)indexPath
{
    if (!_needReloadIndexPaths) {
        _needReloadIndexPaths = [NSMutableArray arrayWithCapacity:0];
    }
    [_needReloadIndexPaths addObject:indexPath];
    if (_tableViewScrolling == NO) {
        [self reloadNeedReloadIndexPaths];
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
