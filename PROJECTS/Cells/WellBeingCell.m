//
//  WellBeingCell.m
//  PROJECTS
//
//

#import "WellBeingCell.h"

@implementation WellBeingCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.IV = [[UIImageView alloc] init];
        [self.contentView addSubview:self.IV];
        [self.IV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    return self;
}

-(void)setModel:(BaseModel *)model atIndexPaht:(NSIndexPath *)indexPath
{
    [super setModel:model atIndexPaht:indexPath];
    
    __block WellBeingCell *weak = self;
    [_IV sd_setImageWithURL:[NSURL URLWithString:((WellBeingModel*)self.model).url] placeholderImage:[UIImage imageWithHexColor:0xeeeeee] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
        if (!error && weak.model.height == 44) {//把需要刷新的传到delegate中
            UITableView *tableView = (UITableView*)weak.superview.superview;
            ((WellBeingModel*)weak.model).imageHeight = (image.size.height/image.size.width)*CGRectGetWidth(tableView.bounds);
            if (weak.delegate && [weak.delegate respondsToSelector:@selector(wellBeingCellNeedReloadAtIndexPath:)]) {
                [weak.delegate wellBeingCellNeedReloadAtIndexPath:weak.indexPath];
            }
//            weak.model.height = (image.size.height/image.size.width)*CGRectGetWidth(tableView.bounds);
//            [tableView reloadData];
        }
        
    }];
}

@end
