//
//  SearchControllerVC3.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/7/13.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "SearchControllerVC3.h"
#import "SearchControllerCell.h"
@interface SearchControllerVC3 ()<UITableViewDataSource,UITableViewDelegate,UISearchControllerDelegate,UISearchResultsUpdating>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTop;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *filterDataSource;
@end

@implementation SearchControllerVC3

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
    UIImageView *navi = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Navi_Height)];
    navi.userInteractionEnabled = YES;
    navi.image = [UIImage getImageWithColor:RGB(26, 126, 248)];
    [self.view addSubview:navi];
    
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, Navi_Height-44, 44, 44)];
    backImage.image = [UIImage imageNamed:@"btn_返回_n"];
    [navi addSubview:backImage];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, Navi_Height-44, SCREEN_WIDTH, 44);
    backBtn.backgroundColor = [UIColor clearColor];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [navi addSubview:backBtn];
    
    UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(80, Navi_Height-44, SCREEN_WIDTH-160, 44)];
    if (@available(iOS 8.2, *)) {
        titleLB.font = [UIFont systemFontOfSize:17 weight:UIFontWeightSemibold];
    } else {
        titleLB.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:17];
    }
    titleLB.text = @"方式三";
    titleLB.textColor = [UIColor whiteColor];
    titleLB.textAlignment = NSTextAlignmentCenter;
    [navi addSubview:titleLB];
    
    self.tableViewTop.constant = Navi_Height;
    
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
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SearchControllerCell" bundle:nil] forCellReuseIdentifier:@"SearchControllerCell"];
    
    UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    searchController.searchResultsUpdater = self;
    searchController.delegate = self;
    searchController.dimsBackgroundDuringPresentation = NO;
    self.tableView.tableHeaderView = searchController.searchBar;
    self.searchController = searchController;
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
    searchController.searchBar.tintColor = [UIColor whiteColor];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
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
    searchController.searchBar.backgroundColor = RGB(26, 126, 248);
    self.tableViewTop.constant = (Navi_Height-44);
}

- (void)willDismissSearchController:(UISearchController *)searchController {
    searchController.searchBar.backgroundColor = RGB(245, 245, 245);
    self.tableViewTop.constant = Navi_Height;
    [self.filterDataSource removeAllObjects];
    [self.tableView reloadData];
}

@end
