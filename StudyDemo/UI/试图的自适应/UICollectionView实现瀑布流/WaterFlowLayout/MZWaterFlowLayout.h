//
//  MZWaterFlowLayout.h
//  StudyDemo
//
//  Created by 曾龙 on 2018/1/16.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MZWaterFlowLayout : UICollectionViewLayout
@property (nonatomic ,strong)NSArray *dataSource;
/**
 初始化UICollectionView布局

 @param columnNum 列数
 @param rowSpace 行间距
 @param columnSapce 列间距
 @param edgeInset UICollectionView四周边距
 */
- (instancetype)initWithColumnNum:(NSInteger)columnNum rowSpace:(CGFloat)rowSpace columnSpace:(CGFloat)columnSapce edgeInset:(UIEdgeInsets)edgeInset;
@end
