//
//  SearchControllerListVC.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/7/13.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "SearchControllerListVC.h"
#import "SearchControllerVC1.h"
#import "SearchControllerVC2.h"
#import "SearchControllerVC3.h"
@interface SearchControllerListVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SearchControllerListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"UISearchController使用";
}

#pragma mark -UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *titles = @[@"方式一",@"方式二",@"方式三"];
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text = titles[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark -UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        SearchControllerVC1 *vc = [[SearchControllerVC1 alloc] initWithNibName:@"SearchControllerVC1" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 1) {
        SearchControllerVC2 *vc = [[SearchControllerVC2 alloc] initWithNibName:@"SearchControllerVC2" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 2) {
        SearchControllerVC3 *vc = [[SearchControllerVC3 alloc] initWithNibName:@"SearchControllerVC3" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


@end
