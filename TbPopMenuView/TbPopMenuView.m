//
//  TbPopMenuVIew.m
//  AetosTrade
//
//  Created by mac on 16/12/1.
//  Copyright © 2016年 vst-Tb. All rights reserved.
//
#define timerInterval 0.25
#define TbPopMenuViewSelectRow @"selectRow"
#define  ATdeviceScaleWidth  [UIScreen mainScreen].bounds.size.width
#define  ATdeviceScaleHight  [UIScreen mainScreen].bounds.size.height

#import "TbPopMenuView.h"
@interface TbPopMenuView()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger selectRow;
}
@property (weak, nonatomic) IBOutlet UITableView *popTableView;
@property (nonatomic,strong)NSArray *titles;
@property (nonatomic,strong)NSArray *images;
@property (nonatomic,copy)void(^selectRowBlock)(NSString *,NSInteger);
@property (nonatomic,strong)UIView *bgView;


@end

@implementation TbPopMenuView


//void(^block)()
- (instancetype)initWithTitle:(NSArray *)title imageName:(NSArray *)imageName clickRowComplete:(void(^)(NSString *,NSInteger))clickRowComplete
{
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"TbPopMenuView" owner:nil options:nil] firstObject];
        self.titles = title;
        self.images = imageName;
        _selectRowBlock = clickRowComplete;
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:self.bgView];
        [window addSubview:self];
        CGPoint center = self.center;
        center.x = ATdeviceScaleWidth * 0.5;
        center.y = ATdeviceScaleHight * 0.5;
        self.center = center;
        
        [self setupTableViewCheck];
    }
    return self;
}

// 控制tableview的cell选中
- (void)setupTableViewCheck
{
    if ([[NSUserDefaults standardUserDefaults] integerForKey:TbPopMenuViewSelectRow] == 0) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self tableView:self.popTableView didSelectRowAtIndexPath:indexPath];
    } else {
        NSInteger selectPath = [[NSUserDefaults standardUserDefaults] integerForKey:TbPopMenuViewSelectRow];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:selectPath inSection:0];
        [self tableView:self.popTableView didSelectRowAtIndexPath:indexPath];
    }
}
- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        _bgView.hidden = YES;
        
    }
    return _bgView;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self.layer setCornerRadius:4];
}

- (void)hide
{
    [UIView animateWithDuration:timerInterval animations:^{
        _bgView.hidden = YES;
        
    } completion:^(BOOL finished) {
        [_bgView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

- (void)show
{
    [UIView animateWithDuration:timerInterval animations:^{
        _bgView.hidden = NO;
    }];
}

- (IBAction)cancel:(id)sender
{
    [self hide];
}

- (IBAction)ok:(id)sender
{
    [self hide];
    !self.selectRowBlock ? :self.selectRowBlock(self.titles[selectRow],selectRow);
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.images.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID =@"cell";
    UITableViewCell  *cell =[tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone; //选中cell时无色
    }
    cell.textLabel.text = self.titles[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:_images[indexPath.row]];
    
    
    if ([[NSUserDefaults standardUserDefaults] integerForKey:TbPopMenuViewSelectRow] == indexPath.row)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectRow = indexPath.row;
    [[NSUserDefaults standardUserDefaults] setInteger:indexPath.row forKey:TbPopMenuViewSelectRow];
    [self.popTableView reloadData];
}

@end
