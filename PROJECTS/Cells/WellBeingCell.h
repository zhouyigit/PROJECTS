//
//  WellBeingCell.h
//  PROJECTS
//
//福利cell

#import "BaseTableViewCell.h"

@protocol WellBeingCellDelegate <NSObject>

-(void)wellBeingCellNeedReloadAtIndexPath:(NSIndexPath*)indexPath;

@end

@interface WellBeingCell : BaseTableViewCell

@property(weak, nonatomic) id<WellBeingCellDelegate> delegate;

@property (strong, nonatomic) UIImageView *IV;

@end
