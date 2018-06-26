//
//  ViewController.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/1/2.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "ViewController.h"
//Util
#import "BarCodeFuncVC.h"
#import "GetContactMethodListVC.h"
#import "JavaScriptAndOCFunVC.h"
#import "DataHandleVC.h"
#import "TestRuntimeVC.h"
#import "SystemFuncVC.h"

//UI
#import "XibViewTestVC.h"
#import "DrawFuncVC.h"
#import "TestAttrinuteStringTapVC.h"
#import "ViewFitFuncVC.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)NSArray *functionList;
@end

@implementation ViewController

//懒加载
- (NSArray *)functionList {
    if (!_functionList) {
        //读取plist文件信息
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"functionList" ofType:@"plist"];
        NSArray *functions = [NSArray arrayWithContentsOfFile:plistPath];
        _functionList = [[NSArray alloc] initWithArray:functions];
    }
    return _functionList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"功能列表";
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-Navi_Height) style:UITableViewStyleGrouped];
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
    return self.functionList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *item = self.functionList[section];
    NSArray *functions = [item valueForKey:@"Function"];
    return functions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"FunctionListCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;//去除点击效果，不会变灰
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//显示右边箭头，一般代表可以跳转下个界面
    }
    NSDictionary *item = self.functionList[indexPath.section];
    NSArray *functions = [item valueForKey:@"Function"];
    cell.textLabel.text = functions[indexPath.row];
    return cell;
}

#pragma mark -UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            BarCodeFuncVC *vc = [[BarCodeFuncVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        } else if (indexPath.row == 1) {
            GetContactMethodListVC *vc = [[GetContactMethodListVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        } else if (indexPath.row == 2) {
            JavaScriptAndOCFunVC *vc = [[JavaScriptAndOCFunVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        } else if (indexPath.row == 3) {
            DataHandleVC *vc = [[DataHandleVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        } else if (indexPath.row == 4) {
            TestRuntimeVC *vc = [[TestRuntimeVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        } else if (indexPath.row == 5) {
            SystemFuncVC *vc = [[SystemFuncVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    } else {
        if (indexPath.row == 0) {
            XibViewTestVC *vc = [[XibViewTestVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        } else if (indexPath.row == 1) {
            DrawFuncVC *vc = [[DrawFuncVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        } else if (indexPath.row == 2) {
            TestAttrinuteStringTapVC *vc = [[TestAttrinuteStringTapVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        } else if (indexPath.row == 3) {
            ViewFitFuncVC *vc = [[ViewFitFuncVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;//默认
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    headerView.backgroundColor = [UIColor clearColor];
    
    NSDictionary *item = self.functionList[section];
    NSString *header = [item valueForKey:@"Category"];
    UILabel *tipsLB = [[UILabel alloc] initWithFrame:CGRectMake(16, 10, SCREEN_WIDTH-16, 24)];
    tipsLB.backgroundColor = [UIColor clearColor];
    tipsLB.textColor = [UIColor grayColor];
    tipsLB.font = [UIFont systemFontOfSize:16];
    tipsLB.text = header;
    [headerView addSubview:tipsLB];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;//不能返回0，0是无效的
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.01)];
    footerView.backgroundColor = [UIColor clearColor];
    return footerView;
}




@end
