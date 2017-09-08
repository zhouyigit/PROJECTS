//
//  TableViewController.h
//  PROJECTS
//
//

#import "BaseViewController.h"

@interface TableViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource, WellBeingCellDelegate>
{
    NSMutableArray *_needReloadIndexPaths;
    BOOL _tableViewScrolling;
}

@property(strong, nonatomic) UITableView *tableView;
@property(strong, nonatomic) NSMutableArray<WellBeingModel *> *dataSource;

-(instancetype)initWithDataSource:(NSArray*)array;

@end
