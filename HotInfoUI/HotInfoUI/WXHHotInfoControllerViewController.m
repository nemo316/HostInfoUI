//
//  WXHHotInfoControllerViewController.m
//  HotInfoUI
//
//  Created by 初七 on 2016/12/22.
//  Copyright © 2016年 nemo. All rights reserved.
//

#import "WXHHotInfoControllerViewController.h"
#import "UIImage+Image.h"

#define kOriginalHeight 200
#define kOriginalOffset -244
@interface WXHHotInfoControllerViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bgImgContrait;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

static NSString *const ID = @"cell";
@implementation WXHHotInfoControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 注册cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    // 不要自动设置偏移量
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 设置tableView的初始contentInset(会调用scrollViewDidScroll)
    self.tableView.contentInset = UIEdgeInsetsMake(244, 0, 0, 0);
    // 处理navigationBar
    [self setupNavigationBar];
}

#pragma mark - 处理navigationBar
- (void)setupNavigationBar{
    // 隐藏系统navigationBar
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    // 设置导航栏标题
    UILabel *label = [[UILabel alloc] init];
    label.text = @"详情界面";
    [label sizeToFit];
    label.textColor = [UIColor colorWithWhite:0 alpha:0];
    self.navigationItem.titleView = label;
}

#pragma mark - <UITableViewDelegate>
#pragma mark * 滚动视图调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 滚动时改变背景图片大小
        // 求偏移量
    CGFloat offSet = self.tableView.contentOffset.y - kOriginalOffset;
        // 实时变化的背景图片的高度
    CGFloat bgHeight = kOriginalHeight - offSet;
        // 判断
    if (bgHeight <= 64) {
        bgHeight = 64;
    }
        // 改变大小
    self.bgImgContrait.constant = bgHeight;
    
    // 滚动时改变导航栏的透明度
        // 根据透明度来生成图片
        // 极限最大值
    CGFloat alpha = offSet / 136.0;
    if (alpha >= 1) {
        alpha = 0.99;
    }
        // 改变导航栏透明度
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithWhite:1 alpha:alpha]] forBarMetrics:UIBarMetricsDefault];
        // 改变导航栏标题的透明度
    UILabel *titleLabel = (UILabel *)self.navigationItem.titleView;
    titleLabel.textColor = [UIColor colorWithWhite:0 alpha:alpha];
}
#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.textLabel.text = @"HotInfoUI";
    return cell;
}
@end
