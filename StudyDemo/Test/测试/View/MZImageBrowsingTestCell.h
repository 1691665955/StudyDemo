//
//  MZImageBrowsingTestCell.h
//  StudyDemo
//
//  Created by 曾龙 on 2018/10/16.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^MZImageBrowsingTestCellBlock)(NSArray<UIImageView *> *imageViewArray,NSInteger currentIndex);
@interface MZImageBrowsingTestCell : UITableViewCell
@property (nonatomic, copy) MZImageBrowsingTestCellBlock previewImage;

- (void)loadImageViews;
@end
