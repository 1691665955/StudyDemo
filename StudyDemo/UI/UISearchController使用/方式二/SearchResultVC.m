//
//  SearchResultVC.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/7/13.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "SearchResultVC.h"
#import "SearchControllerCell.h"
@interface SearchResultVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTop;

@end

@implementation SearchResultVC

- (void)setDataSource:(NSArray *)dataSource {
    _dataSource = dataSource;
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.tableView registerNib:[UINib nibWithNibName:@"SearchControllerCell" bundle:nil] forCellReuseIdentifier:@"SearchControllerCell"];
}

- (void)viewDidLayoutSubviews {
    self.tableViewTop.constant = Navi_Height;
    self.tableView.contentInset = UIEdgeInsetsMake(-44, 0, 0, 0);
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

@end
