//
//  TestFitCell.h
//  StudyDemo
//
//  Created by 曾龙 on 2018/1/15.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestFitModel.h"
@interface TestFitCell : UITableViewCell
@property (nonatomic ,strong)TestFitModel *model;
@property (nonatomic ,assign)CGFloat Height;
@end
