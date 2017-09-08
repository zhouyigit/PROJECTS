//
//  TableViewController.h
//  PROJECTS
//
//

#import "BaseViewController.h"

@interface TableViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource, WellBeingCellDelegate, UIAlertViewDelegate>
{
    NSMutableArray<NSIndexPath *> *_needReloadIndexPaths;//需要刷新的
    NSMutableArray<NSIndexPath *> *_hadReloadIndexPaths;//已经刷新过的
    BOOL _tableViewScrolling;
    BOOL _showError;
}

@property(strong, nonatomic) UITableView *tableView;
@property(strong, nonatomic) NSMutableArray<WellBeingModel *> *dataSource;

-(instancetype)initWithDataSource:(NSArray*)array;

@end
