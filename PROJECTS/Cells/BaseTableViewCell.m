//
//  BaseTableViewCell.m
//  PROJECTS
//
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(BaseModel *)model atIndexPaht:(NSIndexPath *)indexPath
{
    _model = model;
    _indexPath = indexPath;
}

-(void)dealloc
{
    
}

@end
