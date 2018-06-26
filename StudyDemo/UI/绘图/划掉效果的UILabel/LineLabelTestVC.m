//
//  LineLabelTestVC.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/1/14.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "LineLabelTestVC.h"
#import "UILabel+MZTool.h"
@interface LineLabelTestVC ()

@end

@implementation LineLabelTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"划掉效果的UILabel";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(20, 30, SCREEN_WIDTH-40, 40)];
    lb.text = @"划掉效果的UILabel";
    lb.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lb];
    
    CGSize maxSize = CGSizeMake(CGFLOAT_MAX, 40);
    CGSize size = [lb sizeThatFits:maxSize];
    [lb drawLineWithFrame:CGRectMake((lb.frame.size.width-size.width)/2, 10, size.width, 20) lineColor:[UIColor blackColor] lineWidth:1.0f];

    UILabel *lb1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, SCREEN_WIDTH-40, 60)];
    lb1.text = @"sajfdlakfldksfdlksafkslaflkas";
    lb1.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:lb1];
    [lb1 drawLine];
}



@end
