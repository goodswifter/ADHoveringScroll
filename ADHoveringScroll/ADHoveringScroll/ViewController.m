//
//  ViewController.m
//  ADHoveringScroll
//
//  Created by jingshi on 2017/6/29.
//  Copyright © 2017年 zhongad. All rights reserved.
//

#import "ViewController.h"
#import "FSScrollContentView.h"
#import "UIView+Extension.h"
#import "UINavigationBar+Awesome.h"

#define titleViewH 50
#define TableHeaderH 200
#define NavH 64
#define NAVBAR_CHANGE_POINT 50

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, FSSegmentTitleViewDelegate, UIScrollViewDelegate>
/** titleView */
@property (nonatomic, weak) FSSegmentTitleView *titleView;
/** TableView */
@property (nonatomic, weak) UITableView *tableView;
/** 标题数组 */
@property (nonatomic, strong) NSArray *titles;
/** topView */
@property (nonatomic, strong) UIView *topView;
/** 是否手动拖拽视图 */
@property (nonatomic, assign, getter=isDrag) BOOL drag;
/** 是否点击了TitleView */
@property (nonatomic, assign, getter=isClickedTitle) BOOL clickedTitle;
@end

@implementation ViewController

- (NSArray *)titles {
    if (_titles == nil) {
        _titles = @[@"全部",@"服饰穿搭",@"生活百货"] ;
    }
    return _titles;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 隐藏导航栏
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, TableHeaderH)];
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, TableHeaderH - titleViewH)];
    imageV.image = [UIImage imageNamed:@"bg"];
    [view addSubview:imageV];
    //    view.backgroundColor = [UIColor redColor];
    
    FSSegmentTitleView *titleView = [[FSSegmentTitleView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageV.frame), CGRectGetWidth(self.view.bounds), titleViewH) titles:self.titles delegate:self indicatorType:FSIndicatorTypeEqualTitle];
    titleView.backgroundColor = [UIColor lightGrayColor];
    self.titleView = titleView;
    [view addSubview:titleView];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    //    tableView.delegate = self;
    self.tableView = tableView;
    [self.view addSubview:tableView];
    tableView.tableHeaderView = view;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    self.tableView.delegate = self;
    [self scrollViewDidScroll:self.tableView];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.tableView.delegate = nil;
    [self.navigationController.navigationBar lt_reset];
}

#pragma mark - <FSSegmentTitleViewDelegate>
- (void)FSSegmentTitleView:(FSSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex {
    self.tableView.contentInset = UIEdgeInsetsMake(titleViewH + NavH, 0, 0, 0);
    self.drag = NO;
    self.clickedTitle = YES;
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:endIndex] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

#pragma mark - <UITableViewDataSource>
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.titles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

#pragma mark - <UITableViewDelegate>
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld - cell - %ld", indexPath.section, indexPath.row];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.titles[section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.drag = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 隐藏/显示导航栏
    UIColor * color = [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1];
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_CHANGE_POINT) {
        CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
    } else {
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
    }
    
    if (!self.isDrag && self.isClickedTitle) {
        self.titleView._y = NavH;
        [self.view addSubview:self.titleView];
        return ;
    }
    
    self.tableView.contentInset = UIEdgeInsetsZero;
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y + titleViewH + NavH)];
    self.titleView.selectIndex = indexPath.section;
    
    if (offsetY >= TableHeaderH - titleViewH - NavH) {
        // 当向上滑动到状态栏边缘的时候，将红色控件添加到控制器View中
        self.titleView._y = NavH;
        [self.view addSubview:self.titleView];
    } else {
        // 下拉到scrollView顶部时候，将红色控件添加到控制器scrollView中
        self.titleView._y = TableHeaderH - titleViewH;
        [self.tableView.tableHeaderView addSubview:self.titleView];
    }
}

@end
