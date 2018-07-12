//
//  MZTestSDWebImageVC.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/7/12.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "MZTestSDWebImageVC.h"
#import "MZTestSDWebImageCell.h"
@interface MZTestSDWebImageVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MZTestSDWebImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"测试SDWebImage在UITableView中的重用";
    [self.tableView registerNib:[UINib nibWithNibName:@"MZTestSDWebImageCell" bundle:nil] forCellReuseIdentifier:@"MZTestSDWebImageCell"];
    
    self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    }];
}

#pragma mark -UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MZTestSDWebImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MZTestSDWebImageCell"];
    [cell.iconView sd_setImageWithURL:[NSURL URLWithString:indexPath.row%2==0?@"http://test.newlife.trudian.com/upload/getfile.php?id=GqVjAZw3n&type=small":@"http://test.newlife.trudian.com/upload/getfile.php?id=l7OBKYjaZ&type=small"]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 300;
}
@end
