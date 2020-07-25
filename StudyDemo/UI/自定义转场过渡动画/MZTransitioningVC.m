//
//  MZTransitioningVC.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/10/15.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "MZTransitioningVC.h"
#import "MZImagesVC.h"
#import "MZOtherImagesVC.h"
#import "MZCollectionImagesVC.h"
#import "MZScrollImagesVC.h"

@interface MZTransitioningVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MZTransitioningVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"自定义转场过渡动画";
}

#pragma mark -UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *titles = @[@"图片浏览器1",@"图片浏览器2",@"图片浏览器3",@"图片浏览器4"];
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text = titles[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark -UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        MZImagesVC *vc = [[MZImagesVC alloc] initWithNibName:@"MZImagesVC" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 1) {
        MZOtherImagesVC *vc = [[MZOtherImagesVC alloc] initWithNibName:@"MZOtherImagesVC" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 2) {
        MZCollectionImagesVC *vc = [[MZCollectionImagesVC alloc] initWithNibName:@"MZCollectionImagesVC" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 3) {
        MZScrollImagesVC *vc = [[MZScrollImagesVC alloc] initWithNibName:@"MZScrollImagesVC" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
