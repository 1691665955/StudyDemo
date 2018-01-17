//
//  WaterFlowTestCell.h
//  StudyDemo
//
//  Created by 曾龙 on 2018/1/16.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WaterFlowModel.h"
@interface WaterFlowTestCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodImageView;
@property (weak, nonatomic) IBOutlet UILabel *priceLB;
@property (nonatomic ,strong) WaterFlowModel *model;
@end
