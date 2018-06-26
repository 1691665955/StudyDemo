//
//  XibViewTestVC.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/1/5.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "XibViewTestVC.h"
#import "XibView.h"
#import "ErrorXibView.h"
#import "XibTestCell.h"
@interface XibViewTestVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation XibViewTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"xib适配问题";
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-Navi_Height) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [tableView registerNib:[UINib nibWithNibName:@"XibTestCell" bundle:nil] forCellReuseIdentifier:@"XibTestCell"];
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    UILabel *tipsLB = [[UILabel alloc] initWithFrame:CGRectMake(15, 30, SCREEN_WIDTH-30, 120)];
    tipsLB.text = @"当将一个xib自定义的view添加到一个UITableViewCell的时候，此时的view将无法适配到所有的机型，本例子在5s上可以适配成功，在7plus上无法适配";
    tipsLB.textColor = TipsColor;
    tipsLB.numberOfLines = 0;
    [footerView addSubview:tipsLB];
    tableView.tableFooterView = footerView;
    [self.view addSubview:tableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XibTestCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XibTestCell"];
    if (indexPath.row%2 == 0) {
        XibView *view = [[XibView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        [cell addSubview:view];
    } else {
        ErrorXibView *view = [[[NSBundle mainBundle] loadNibNamed:@"ErrorXibView" owner:nil options:nil] firstObject];
        view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
        [cell addSubview:view];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}


@end
