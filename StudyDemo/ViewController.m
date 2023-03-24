//
//  ViewController.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/1/2.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "ViewController.h"
#import "MZNavigationController.h"
//Util
#import "BarCodeFuncVC.h"
#import "GetContactMethodListVC.h"
#import "JavaScriptAndOCFunVC.h"
#import "DataHandleVC.h"
#import "TestRuntimeVC.h"
#import "SystemFuncVC.h"
#import "PhoneNumberInputVC.h"
#import "CustomFontVC.h"

//UI
#import "XibViewTestVC.h"
#import "DrawFuncVC.h"
#import "TestAttrinuteStringTapVC.h"
#import "ViewFitFuncVC.h"
#import "MZTabBarController.h"
#import "TableViewKeyboardHiddenVC.h"
#import "OrientationVC.h"
#import "CustomTransitionVC.h"
#import "SearchControllerListVC.h"
#import "TestPayVC.h"
#import "MZTransitioningVC.h"

//Test
#import "MZTestSDWebImageVC.h"
#import "MZRSA.h"

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
    
    NSString *PUBLIC_KEY = @"MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEArdklK4kIsOMuxTZ8jG1PRPfXqSDmaCIQ+xEpIRSssQ6jiuvhYZTMUbV22osgtivuyKdnHm+cvzGuZCSB8QFyCcM7l09HZVs0blLkrBAU5CVSv+6BzPQTVJytoi/VO4mlf6me1Y9bXWrrPw1YtC1mnB2Ix9cuaxOLpucglfGbUaGEigsUZMTD2vuEODN5cJi39ap+G9ILitbrnt+zsW9354pokVnHw4Oq837Fd7ZtP0nAA5F6nE3FNDGQqLy2WYRoKC9clDecD8T933azUD98b5FSUGzIhwiuqHHeylfVbevbBW91Tvg9s7vUMr0Y2YDpEmPAf0q4PlDt8QsjctT9kQIDAQAB";
    NSString *PRIVATE_KEY = @"MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCt2SUriQiw4y7FNnyMbU9E99epIOZoIhD7ESkhFKyxDqOK6+FhlMxRtXbaiyC2K+7Ip2ceb5y/Ma5kJIHxAXIJwzuXT0dlWzRuUuSsEBTkJVK/7oHM9BNUnK2iL9U7iaV/qZ7Vj1tdaus/DVi0LWacHYjH1y5rE4um5yCV8ZtRoYSKCxRkxMPa+4Q4M3lwmLf1qn4b0guK1uue37Oxb3fnimiRWcfDg6rzfsV3tm0/ScADkXqcTcU0MZCovLZZhGgoL1yUN5wPxP3fdrNQP3xvkVJQbMiHCK6ocd7KV9Vt69sFb3VO+D2zu9QyvRjZgOkSY8B/Srg+UO3xCyNy1P2RAgMBAAECggEAInVN9skcneMJ3DEmkrb/5U2yw2UwBifqcbk/C72LVTTvmZOTgsH5laCARGUbQMCIfeEggVniGcuBI3xQ/TIqJmE6KI2gOyjOxadMiAZP/cCgHEbsF3Gxey3rBKCyhTCNSzaVswLNO0D8C+1bTatKEVuRRvsRykt/fL+HJ/FRteYYO9LuLv2WESJGE6zsi03P6snNiRracvYqz+Rnrvf1Xuyf58wC1C6JSjZ9D6tootPDBTEYaIIbpEnV+qP/3k5OFmA9k4WbkZI6qYzqSK10bTQbjMySbatovnCD/oqIUOHLwZpL051E9lz1ZUnDbrxKwT0BIU7y4DYaHSzrKqRsIQKBgQDTQ9DpiuI+vEj0etgyJgPBtMa7ClTY+iSd0ccgSE9623hi1CHtgWaYp9C4Su1GBRSF0xlQoVTuuKsVhI89far2Z0hR9ULr1J1zugMcNESaBBC17rPoRvXPJT16U920Ntwr00LviZ/DEyvmpVDagYy+mSK0Wq+kH7p5aR5zAHXWrQKBgQDSqQ6TBr5bDMvhpRi94unghiWyYL6srSRV9XjqDpiNU+yFwCLzSG610DyXFa3pV138P+ryunqg1LtKsOOtZJONzbS1paINnwkvfwzMpI7TjCq1+8rxeEhZ3AVmumDtPQK+YfGbxCQ+LAOJZOu8lGv1O7tsbXFp0vh5RmWHWHvy9QKBgCMGPi9JsCJ4cpvdddQyizLk9oFxwAlMxx9G9P08H7kdg4LW6l0Gs+yg/bBf86BFHVbmXW8JoBwHj418sYafO+Wnz8yOna6dTBEwiG13mNvzypVu4nKiuQPDh8Ks/rdu1OeLGbC+nzbnCcMuKw5epee/WYqO8kmCXRbdv4ePTvntAoGBAJYQ9F7saOI3pW2izJNIeE8HgQcnP+2GkeHiMjaaGzZiWJWXH86rBKLkKqV+PhuBr2QorFgpW34CzUER7b7xbOORbHASA/UsG8EIArgtacltimeFbTbC9td8kyRxFOcrlS7GWvUZrq/TbtmLWRtHp/hUitlcxXQbZAIQkfbuo62ZAoGBAKBURvLGM0ethkvUHFyGae2YGG/s+u+EYd2zNba7A6qnfzrlMHVPiPO6lx31+HwhuJ0tBZWMJKhEZ5PWByZzreVKVH5fE5LoQLo+B3VCTyTc1fJ9RKLAPrPqHuvzPHHP/n84XHGeit3e4ytd3Mm/6CNbrg7xux2M4RDQmN//1UOY";
    NSString *ss = @"fajsdajdadj";
    NSLog(@"%@",ss);
    ss = [MZRSA encryptString:ss publicKey:PUBLIC_KEY];
    NSLog(@"%@",ss);
    ss = [MZRSA decryptString:ss privateKey:PRIVATE_KEY];
    NSLog(@"%@",ss);
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
        } else if (indexPath.row == 6) {
            PhoneNumberInputVC *vc = [[PhoneNumberInputVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        } else if (indexPath.row == 7) {
            CustomFontVC *vc = [[CustomFontVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    } else if(indexPath.section == 1){
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
        } else if (indexPath.row == 4) {
            dispatch_async(dispatch_get_main_queue(), ^{
                MZTabBarController *tabbarController = [[MZTabBarController alloc] init];
                //系统自带转场动画
                tabbarController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                [self presentViewController:tabbarController animated:YES completion:nil];
            });
        } else if (indexPath.row == 5) {
            TableViewKeyboardHiddenVC *vc = [[TableViewKeyboardHiddenVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        } else if (indexPath.row == 6) {
            OrientationVC *vc = [[OrientationVC alloc] init];
            MZNavigationController *nvc = [[MZNavigationController alloc] initWithRootViewController:vc];
            nvc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [self presentViewController:nvc animated:YES completion:nil];
        } else if (indexPath.row == 7) {
            CustomTransitionVC *vc = [[CustomTransitionVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        } else if (indexPath.row == 8) {
            //xib推荐使用这种方式初始化
            SearchControllerListVC *vc = [[SearchControllerListVC alloc] initWithNibName:@"SearchControllerListVC" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
        } else if (indexPath.row == 9) {
            TestPayVC *vc = [[TestPayVC alloc] initWithNibName:@"TestPayVC" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
        } else if (indexPath.row == 10) {
            MZTransitioningVC*vc = [[MZTransitioningVC alloc] initWithNibName:@"MZTransitioningVC" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }
    } else {
        if (indexPath.row == 0) {
            MZTestSDWebImageVC *vc = [[MZTestSDWebImageVC alloc] initWithNibName:@"MZTestSDWebImageVC" bundle:nil];
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
