//
//  MZWaterFlowLayout.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/1/16.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "MZWaterFlowLayout.h"
#import "WaterFlowModel.h"
@interface MZWaterFlowLayout()
@property (nonatomic ,assign)NSInteger columnNum;
@property (nonatomic ,assign)CGFloat rowSpace;
@property (nonatomic ,assign)CGFloat columnSapce;
@property (nonatomic ,assign)UIEdgeInsets edgeInset;

@property (nonatomic ,assign)CGFloat cellWidth;
@property (nonatomic ,strong)NSMutableArray *cellHeightArr;

@property (nonatomic ,strong)NSMutableArray *attributeArr;
@property (nonatomic ,strong)NSMutableArray *columnHeightArr;
@property (nonatomic ,assign)NSInteger minHeightColumn;
@end

@implementation MZWaterFlowLayout
- (instancetype)initWithColumnNum:(NSInteger)columnNum rowSpace:(CGFloat)rowSpace columnSpace:(CGFloat)columnSapce edgeInset:(UIEdgeInsets)edgeInset {
    self = [super init];
    if (self) {
        self.columnNum = columnNum;
        self.rowSpace = rowSpace;
        self.columnSapce = columnSapce;
        self.edgeInset = edgeInset;
    }
    return self;
}

//获取数据源后，计算每个cell的高度
- (void)setDataSource:(NSArray *)dataSource {
    _dataSource = dataSource;
    [self.cellHeightArr removeAllObjects];
    for (int i=0; i<dataSource.count; i++) {
        WaterFlowModel *model = dataSource[i];
        [self.cellHeightArr addObject:@(self.cellWidth*model.imgHeight/model.imgWidth)];
    }
}

//初始化或数据源改变后会调用该方法，计算cell的宽度和cell的布局
- (void)prepareLayout {
    [super prepareLayout];
    self.cellWidth = (self.collectionView.frame.size.width-self.edgeInset.left-self.edgeInset.right-(self.columnNum-1)*self.columnSapce)/self.columnNum;
    [self.columnHeightArr removeAllObjects];
    [self.attributeArr removeAllObjects];
    for (int i=0; i<self.columnNum; i++) {
        [self.columnHeightArr addObject:@(self.edgeInset.top)];
    }
    self.minHeightColumn = 0;
    
    for (int i=0; i<self.dataSource.count; i++) {
        [self.attributeArr addObject:[self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]]];
    }
}

//计算cell的布局
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGFloat x = self.edgeInset.left+(self.cellWidth+self.columnSapce)*self.minHeightColumn;
    attribute.frame = CGRectMake(x, [self.columnHeightArr[self.minHeightColumn] floatValue], self.cellWidth, [self.cellHeightArr[indexPath.row] floatValue]);
    [self.columnHeightArr replaceObjectAtIndex:self.minHeightColumn withObject:@(CGRectGetMaxY(attribute.frame)+self.rowSpace)];
    
    CGFloat height = [self.columnHeightArr[0] floatValue];
    self.minHeightColumn = 0;
    for (int i=1; i<self.columnHeightArr.count; i++) {
        CGFloat hh = [self.columnHeightArr[i] floatValue];
        if (hh < height) {
            self.minHeightColumn = i;
            height = hh;
        }
    }
    return attribute;
}

//设置collectionView的滑动范围
- (CGSize)collectionViewContentSize {
    CGFloat height = 0.0f;
    for (NSNumber *hh in self.columnHeightArr) {
        CGFloat tempHeight = [hh floatValue];
        if (tempHeight > height) {
            height = tempHeight;
        }
    }
    return CGSizeMake(self.collectionView.frame.size.width, height+self.edgeInset.bottom);
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attributeArr;
}

#pragma mark -懒加载
- (NSMutableArray *)attributeArr {
    if (!_attributeArr) {
        _attributeArr = [NSMutableArray array];
    }
    return _attributeArr;
}

- (NSMutableArray *)columnHeightArr {
    if (!_columnHeightArr) {
        _columnHeightArr = [NSMutableArray array];
    }
    return _columnHeightArr;
}

- (NSMutableArray *)cellHeightArr {
    if (!_cellHeightArr) {
        _cellHeightArr = [NSMutableArray array];
    }
    return _cellHeightArr;
}
@end
