//
//  SearchControllerVC1.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/7/13.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "SearchControllerVC1.h"
#import "SearchControllerCell.h"
@interface SearchControllerVC1 ()<UITableViewDataSource,UITableViewDelegate,UISearchControllerDelegate,UISearchResultsUpdating>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTop;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *filterDataSource;
@end

@implementation SearchControllerVC1

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

- (NSMutableArray *)filterDataSource {
    if (!_filterDataSource) {
        _filterDataSource = [[NSMutableArray alloc] init];
    }
    return _filterDataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"方式一";
    
    //该方式搜索结果在本界面显示，但是搜索状态下导航栏的颜色最好为白色，和状态栏颜色统一，如果设为其他颜色会和状态栏的白色冲突，效果不佳
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SearchControllerCell" bundle:nil] forCellReuseIdentifier:@"SearchControllerCell"];
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.edgesForExtendedLayout = UIRectEdgeNone;
    for (int i = 0; i < 100; i++) {
        NSInteger num = arc4random()%100;
        [self.dataSource addObject:[NSString stringWithFormat:@"我是数字%ld",(long)num]];
    }
    
    UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    searchController.delegate = self;
    searchController.searchResultsUpdater = self;
    searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController = searchController;
    self.tableView.tableHeaderView = searchController.searchBar;
    self.definesPresentationContext = YES;
    
    //设置搜索栏样式
    [[[[searchController.searchBar.subviews firstObject] subviews] firstObject] removeFromSuperview];
    searchController.searchBar.backgroundColor = RGB(245, 245, 245);
    CGRect frame = searchController.searchBar.frame;
    frame.origin.x = 17;
    frame.size.width = SCREEN_WIDTH-34;
    searchController.searchBar.frame = frame;
    UITextField *textFiled = [searchController.searchBar valueForKey:@"searchField"];
    textFiled.layer.borderWidth = 0.5;
    textFiled.layer.borderColor = RGB(223, 223, 223).CGColor;
    textFiled.layer.cornerRadius = 18;
    textFiled.layer.masksToBounds = YES;
    textFiled.font = [UIFont systemFontOfSize:14];
    searchController.searchBar.placeholder = @"请输入关键字搜索";
    searchController.searchBar.tintColor = RGB(102, 102, 102);
}

#pragma mark -UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchController.active ? self.filterDataSource.count : self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchControllerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchControllerCell"];
    cell.contentLB.text = self.searchController.active ? self.filterDataSource[indexPath.row] : self.dataSource[indexPath.row];
    cell.lineView.hidden = indexPath.row < (self.searchController.active ? self.filterDataSource.count-1 : self.dataSource.count-1);
    return cell;
}

#pragma mark -UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

#pragma mark -UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *inputText = searchController.searchBar.text;
    [self.filterDataSource removeAllObjects];
    for (NSString *string in self.dataSource) {
        if ([string rangeOfString:inputText].length > 0) {
            [self.filterDataSource addObject:string];
        }
    }
    [self.tableView reloadData];
}

#pragma mark -UISearchControllerDelegate
- (void)willPresentSearchController:(UISearchController *)searchController {
    searchController.searchBar.backgroundColor = [UIColor whiteColor];
}

- (void)willDismissSearchController:(UISearchController *)searchController {
    searchController.searchBar.backgroundColor = RGB(245, 245, 245);
    [self.filterDataSource removeAllObjects];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if (self.searchController.active) {
        self.tableViewTop.constant = Navi_Height-44;
    } else {
        self.tableViewTop.constant = 0;
    }
}

@end
