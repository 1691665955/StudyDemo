//
//  MZCircleProgress.h
//  StudyDemo
//
//  Created by 曾龙 on 2018/1/12.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MZCircleProgress : UIView

/**
 底条颜色
 */
@property (nonatomic ,strong)UIColor *backLineColor;

/**
 底条宽度
 */
@property (nonatomic ,assign)CGFloat backLineWidth;

/**
 进度条颜色
 */
@property (nonatomic ,strong)UIColor *progressColor;

/**
 进度条宽度
 */
@property (nonatomic ,assign)CGFloat progressWidth;

/**
 进度比例（0～1）
 */
@property (nonatomic ,assign)double ratio;


/**
 开始弧度
 */
@property (nonatomic, assign)CGFloat startAngle;


/**
 结束弧度
 */
@property (nonatomic, assign)CGFloat endAngle;

/**
  中间文本框
 */
@property (nonatomic, strong)UILabel *textLabel;
@end
