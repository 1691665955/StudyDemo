//
//  TestCellFitVC.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/1/15.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "TestCellFitVC.h"
#import "TestFitCell.h"
@interface TestCellFitVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)NSMutableArray *dataSource;
@end

@implementation TestCellFitVC

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        for (int i=0; i<10; i++) {
            NSArray *imageNames = @[@"路飞.jpg",@"艾斯.jpg",@"索隆.jpg"];
            NSArray *titles = @[@"蒙奇·D·路飞",@"波特卡斯·D·艾斯",@"梦想成为世界第一的大剑豪的草帽海贼团剑士-罗罗诺亚·索隆"];
            NSArray *descs = @[@"蒙奇·D·路飞，日本漫画《航海王》的主角，草帽海贼团、草帽大船团船长，极恶的世代之一。橡胶果实能力者，悬赏金5亿贝里。梦想是找到传说中的One Piece，成为海贼王。",@"波特卡斯·D·艾斯，日本动漫《海贼王》中的角色。主角蒙奇·D·路飞的义兄。",@"罗罗诺亚·索隆，日本漫画《航海王》及衍生作品中的角色，草帽一伙的剑士，使用三把刀战斗的三刀流剑士，极恶的世代之一，也是二年前集结香波地群岛的十一超新星之一。目前悬赏3亿2000万贝利。实力强劲。"];
            NSInteger index = arc4random()%3;
            TestFitModel *model = [[TestFitModel alloc] init];
            model.image = [UIImage imageNamed:imageNames[index]];
            model.title = titles[index];
            model.desc = descs[index];
            [_dataSource addObject:model];
        }
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"UITableViewCell自适应";
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
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"TestFitCell";
    TestFitCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[TestFitCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.model = self.dataSource[indexPath.row];
    return cell;
}

#pragma mark -UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TestFitCell *cell = (TestFitCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.Height;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
