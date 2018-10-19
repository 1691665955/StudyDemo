//
//  MZTestSDWebImageVC.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/7/12.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "MZTestSDWebImageVC.h"
#import "MZImageBrowsingVC.h"
#import "MZImageBrowsingTestCell.h"

@interface MZTestSDWebImageVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MZTestSDWebImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"测试";
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-Navi_Height) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerNib:[UINib nibWithNibName:@"MZImageBrowsingTestCell" bundle:nil] forCellReuseIdentifier:@"MZImageBrowsingTestCell"];
    [self.view addSubview:tableView];
}

#pragma mark -UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MZImageBrowsingTestCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MZImageBrowsingTestCell"];
    [cell loadImageViews];
    WeakSelf(self);
    cell.previewImage = ^(NSArray<UIImageView *> *imageViewArray, NSInteger currentIndex) {
        StrongSelf(self);
        MZImageBrowsingVC *vc = [[MZImageBrowsingVC alloc] initWithImageViewArray:imageViewArray currentIndex:currentIndex];
        [self presentViewController:vc animated:YES completion:nil];
    };
    return cell;
}

#pragma mark -UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110;
}

@end
