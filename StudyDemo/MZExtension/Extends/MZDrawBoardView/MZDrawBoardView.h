//
//  MZDrawBoardView.h
//  StudyDemo
//
//  Created by 曾龙 on 2019/4/18.
//  Copyright © 2019年 曾龙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MZDrawBoardView : UIView
@property (nonatomic, strong) UIColor *fillColor;
@property (nonatomic, assign) CGFloat lineWidth;

- (void)clear;
- (UIImage *)getImage;
@end

NS_ASSUME_NONNULL_END
