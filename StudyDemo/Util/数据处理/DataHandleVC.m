//
//  DataHandleVC.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/1/11.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "DataHandleVC.h"
#import "AboutNullVC.h"
#import "FloatNumberDealWithRoundVC.h"
@interface DataHandleVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation DataHandleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"数据处理";
    [self initUI];
}

- (void)initUI {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-Navi_Height) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:tableView];
    
    if (iOS11Later) {
        adjustsScrollViewInsets_NO(tableView, self);
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

#pragma mark -UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *titles = @[@"关于(null)和<null>",@"处理小数点问题"];
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text = titles[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark -UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        AboutNullVC *vc = [[AboutNullVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 1) {
        FloatNumberDealWithRoundVC *vc = [[FloatNumberDealWithRoundVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}




@end
