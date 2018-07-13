//
//  SearchControllerVC2.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/7/13.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "SearchControllerVC2.h"
#import "SearchControllerCell.h"
#import "SearchResultVC.h"
@interface SearchControllerVC2 ()<UITableViewDataSource,UITableViewDelegate,UISearchControllerDelegate,UISearchResultsUpdating>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) SearchResultVC *searchResultVC;
@end

@implementation SearchControllerVC2

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"方式二";
    //方式二用另一VC来显示搜索到的结果，层次会比较清晰
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SearchControllerCell" bundle:nil] forCellReuseIdentifier:@"SearchControllerCell"];

    for (int i = 0; i < 100; i++) {
        NSInteger num = arc4random()%100;
        [self.dataSource addObject:[NSString stringWithFormat:@"我是数字%ld",(long)num]];
    }
    
    SearchResultVC *vc = [[SearchResultVC alloc] initWithNibName:@"SearchResultVC" bundle:nil];
    self.searchResultVC = vc;
    UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:vc];
    searchController.delegate = self;
    searchController.searchResultsUpdater = self;
    searchController.dimsBackgroundDuringPresentation = YES;
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
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchControllerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchControllerCell"];
    cell.contentLB.text = self.dataSource[indexPath.row];
    cell.lineView.hidden = indexPath.row < self.dataSource.count-1;
    return cell;
}

#pragma mark -UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

#pragma mark -UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *inputText = searchController.searchBar.text;
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (NSString *string in self.dataSource) {
        if ([string rangeOfString:inputText].length > 0) {
            [arr addObject:string];
        }
    }
    self.searchResultVC.dataSource = arr;
}

#pragma mark -UISearchControllerDelegate
- (void)willPresentSearchController:(UISearchController *)searchController {
    searchController.searchBar.backgroundColor = [UIColor clearColor];
}

- (void)willDismissSearchController:(UISearchController *)searchController {
    searchController.searchBar.backgroundColor = RGB(245, 245, 245);
}

@end
