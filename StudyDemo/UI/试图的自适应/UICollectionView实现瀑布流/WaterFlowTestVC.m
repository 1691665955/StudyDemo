//
//  WaterFlowTestVC.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/1/16.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "WaterFlowTestVC.h"
#import "MZWaterFlowLayout.h"
#import "WaterFlowTestCell.h"
@interface WaterFlowTestVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic ,strong)UICollectionView *collectionView;
@property (nonatomic ,strong)MZWaterFlowLayout *layout;
@property (nonatomic ,strong)NSArray *dataSource;
@property (nonatomic ,assign)NSInteger page;
@end

@implementation WaterFlowTestVC

//这里的dataSource用本地plist文档模拟
- (NSArray *)dataSource {
    if (!_dataSource) {
        NSArray *arr = [NSArray arrayWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"waterFlow.plist" withExtension:nil]];
        _dataSource = [WaterFlowModel mj_objectArrayWithKeyValuesArray:arr];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"UICollectionView实现瀑布流";
    
    self.layout = [[MZWaterFlowLayout alloc] initWithColumnNum:3 rowSpace:5 columnSpace:5 edgeInset:UIEdgeInsetsMake(10, 10, 10, 10)];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-Navi_Height) collectionViewLayout:self.layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerNib:[UINib nibWithNibName:@"WaterFlowTestCell" bundle:nil] forCellWithReuseIdentifier:@"WaterFlowTestCell"];
    [self.view addSubview:self.collectionView];
    
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNew)];
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    
    if (iOS11Later) {
        adjustsScrollViewInsets_NO(self.collectionView, self);
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.collectionView.mj_header beginRefreshing];
}

- (void)loadNew {
    self.page = 1;
    self.layout.dataSource = [self.dataSource subarrayWithRange:NSMakeRange(0, 20)];
    [self.collectionView reloadData];
    [self.collectionView.mj_header endRefreshing];
}

- (void)loadMore {
    self.page ++;
    if (self.page >= 3) {
        self.layout.dataSource = self.dataSource;
        [self.collectionView reloadData];
        [self.collectionView.mj_footer endRefreshingWithNoMoreData];
    } else {
        self.layout.dataSource = [self.dataSource subarrayWithRange:NSMakeRange(0, 40)];
        [self.collectionView reloadData];
        [self.collectionView.mj_footer endRefreshing];
    }
}

#pragma mark -UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.layout.dataSource.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WaterFlowTestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WaterFlowTestCell" forIndexPath:indexPath];
    cell.model = self.layout.dataSource[indexPath.row];
    return cell;
}

#pragma mark -UICollectionViewDelegate

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
