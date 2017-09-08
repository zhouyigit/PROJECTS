//
//  NavigationBar.m
//  JinFu
//
//自定义导航栏

#import "NavigationBar.h"

@implementation NavigationBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.tag = 1314;
        self.backgroundColor = [UIColor whiteColor];
        self.userInteractionEnabled = YES;
        
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat height = 44;
        CGFloat y = 20;
        
        _title = [[UILabel alloc] initWithFrame:CGRectMake(0, y, width, height)];
        _title.textAlignment = NSTextAlignmentCenter;
        _title.textColor = [UIColor blackColor];
        [self addSubview:_title];
        
        _leftItem = [[UIButton alloc] initWithFrame:CGRectMake(0, y, height, height)];
//        _leftItem.backgroundColor = [UIColor greenColor];
        _leftItem.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        [_leftItem setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [_leftItem addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_leftItem];
        
        _rightItem = [[UIButton alloc] initWithFrame:CGRectMake(width-80, y, 80, height)];
        [_rightItem.titleLabel setFont:[UIFont systemFontOfSize:16]];
        _rightItem.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        [_rightItem setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
//        _rightItem.titleEdgeInsets = UIEdgeInsetsZero;
//        [_rightItem setImage:[UIImage jf_imageWithColor:[UIColor redColor] andSize:CGSizeMake(24, 24)] forState:UIControlStateNormal];
        [self addSubview:_rightItem];
        
        _rightBadge = [[UILabel alloc] initWithFrame:CGRectMake(34, 0, 10, 10)];
        _rightBadge.backgroundColor = [UIColor redColor];
        _rightBadge.textColor = [UIColor whiteColor];
        _rightBadge.font = [UIFont systemFontOfSize:12];
        _rightBadge.textAlignment = NSTextAlignmentCenter;
        _rightBadge.layer.masksToBounds = YES;
        _rightBadge.layer.cornerRadius = 5;
        _rightBadge.hidden = YES;
        [_rightItem addSubview:_rightBadge];
        
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(frame)-OnePX, width, OnePX)];
        _lineView.backgroundColor = [UIColor redColor];
        [self addSubview:_lineView];
        
        _titleImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 135, 27.5)];
        _titleImageV.center = _title.center;
        [self addSubview:_titleImageV];
    }
    return self;
}

-(void)goback {
    
    TabBarController *tabc = (TabBarController*)[UIApplication sharedApplication].keyWindow.rootViewController;
    NavigationController *navc = tabc.selectedViewController;
    [((BaseViewController*)navc.topViewController) releaseSomething];
    [navc popViewControllerAnimated:YES];
}

-(void)setTitle:(NSString*)title {
    _title.text = title;
    _titleImageV.hidden = YES;
    _title.hidden = NO;
}

-(NSString*)getTitle {
    return _title.text;
}

-(void)setTitleImage:(UIImage*)image
{
    _titleImageV.image = image;
    _titleImageV.hidden = NO;
    _title.hidden = YES;
}

-(UIImage*)getTitleImage
{
    return _titleImageV.image;
}

-(void)setLeftItemTarget:(nullable id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    [_leftItem removeTarget:self action:NULL forControlEvents:UIControlEventTouchUpInside];
    [_leftItem addTarget:target action:action forControlEvents:controlEvents];
}

-(void)setRightItemTarget:(nullable id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    [_rightItem removeTarget:self action:NULL forControlEvents:UIControlEventTouchUpInside];
    [_rightItem addTarget:target action:action forControlEvents:controlEvents];
}

-(void)setRightItemImage:(UIImage*)image forState:(UIControlState)state
{
    [_rightItem setTitle:nil forState:state];
    [_rightItem setImage:image forState:state];
}

-(void)setRightItemText:(NSString*)text forState:(UIControlState)state {
    [_rightItem setImage:nil forState:state];
    [_rightItem setTitle:text forState:state];
}

-(void)setLeftItemHidden:(BOOL)hidden {
    _leftItem.hidden = hidden;
}

-(void)setRightItemHidden:(BOOL)hidden {
    _rightItem.hidden = hidden;
}

-(void)setRightItemBadge:(int)badge
{
    _rightBadge.text = StringFromInt(badge);
    if (badge <= 0) {
        _rightBadge.hidden = YES;
    } else {
        _rightBadge.hidden = NO;
    }
}

- (void)setLineViewHidder:(BOOL)hidden{
    _lineView.hidden = hidden;
}
@end
