//
//  DrawFuncVC.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/1/11.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "DrawFuncVC.h"
#import "CreateImageWithColorVC.h"
#import "BezierPathVC.h"
#import "ShapeLayerMaskVC.h"
#import "LineLabelTestVC.h"
#import "ClipsImageVC.h"
#import "WaveViewTestVC.h"
@interface DrawFuncVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation DrawFuncVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"绘图";
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
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *titles = @[@"根据颜色生成图片",@"贝塞尔曲线绘制",@"view的遮罩效果",@"划掉效果的UILabel",@"截取图片",@"双波浪UI"];
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text = titles[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark -UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        CreateImageWithColorVC *vc = [[CreateImageWithColorVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 1) {
        BezierPathVC *vc = [[BezierPathVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 2) {
        ShapeLayerMaskVC *vc = [[ShapeLayerMaskVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 3) {
        LineLabelTestVC *vc = [[LineLabelTestVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 4) {
        ClipsImageVC *vc = [[ClipsImageVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 5) {
        WaveViewTestVC *vc = [[WaveViewTestVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}



@end
