//
//  UIView+MZFrame.h
//  StudyDemo
//
//  Created by 曾龙 on 2019/4/18.
//  Copyright © 2019年 曾龙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (MZFrame)
@property (nonatomic, assign) CGFloat mz_x;
@property (nonatomic, assign) CGFloat mz_y;
@property (nonatomic, assign) CGFloat mz_width;
@property (nonatomic, assign) CGFloat mz_height;
@property (nonatomic, assign) CGFloat mz_centerX;
@property (nonatomic, assign) CGFloat mz_centerY;
@end

NS_ASSUME_NONNULL_END
