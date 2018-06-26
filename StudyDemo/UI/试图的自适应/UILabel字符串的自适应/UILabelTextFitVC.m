//
//  UILabelTextFitVC.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/1/15.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "UILabelTextFitVC.h"

@interface UILabelTextFitVC ()

@end

@implementation UILabelTextFitVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"UILabel字符串的自适应";
    
    /*************************自适应高度***********************/
    UILabel *lb1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 30, SCREEN_WIDTH-40, 10)];
    lb1.numberOfLines = 0;
    lb1.backgroundColor = RGB(223, 223, 223);
    lb1.text = @"月有阴晴圆缺，人有离合死生，命有否泰变化，年有四季更替。只要你细细观察，便会发现，他们看似无常，却是有常；看似残破，却是完满；看似动荡，实则凝止。它们千年万年总脱不开盈与虚、死与生、否与泰、寒与暖、消与长、日与夜，合与分、得意与夫意、繁荣与凋零的更换。";
    [self.view addSubview:lb1];
    
    CGSize maxSize1 = CGSizeMake(SCREEN_WIDTH-40, CGFLOAT_MAX);
    CGSize size1 = [lb1 sizeThatFits:maxSize1];
    CGRect frame1 = lb1.frame;
    frame1.size.height = size1.height;
    lb1.frame = frame1;
    
    
    /*************************自适应宽度***********************/
    UILabel *lb2 = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(frame1)+30, SCREEN_WIDTH-40, 20)];
    lb2.text = @"塞翁失马，焉知非福";
    lb2.backgroundColor = RGB(223, 223, 223);
    [self.view addSubview:lb2];
    
    CGSize maxSize2 = CGSizeMake(CGFLOAT_MAX, 20);
    CGSize size2 = [lb2 sizeThatFits:maxSize2];
    CGRect frame2 = lb2.frame;
    frame2.size.width = size2.width;
    lb2.frame = frame2;
    
    /*************************文字大小自适应***********************/
    UILabel *lb3 = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(frame2)+30, SCREEN_WIDTH-40, 20)];
    lb3.font = [UIFont systemFontOfSize:16];
    lb3.backgroundColor = RGB(223, 223, 223);
    lb3.adjustsFontSizeToFitWidth = YES;
    lb3.text = @"你的双脚，踏碎了多少时间？但不要懊悔吧，只要踏得真实，谁的步子，都会有深浅。";
    [self.view addSubview:lb3];
}



@end
