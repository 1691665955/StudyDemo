//
//  BezierPathVC.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/1/11.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "BezierPathVC.h"
#import "LineView.h"
#import "PolygonView.h"
#import "RectangleView.h"
#import "CircleView.h"
#import "ArcView.h"
#import "cornerRadiusView.h"
@interface BezierPathVC ()

@end

@implementation BezierPathVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"贝塞尔曲线绘制";
    
    //绘制线条
    LineView *view = [[LineView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2, SCREEN_WIDTH/2)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    //绘制正六边形(填充式)
    PolygonView *view1 = [[PolygonView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2+10, 10, SCREEN_WIDTH/2-20, SCREEN_WIDTH/2-20)];
    view1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view1];
    
    //绘制正方形
    RectangleView *view2 = [[RectangleView alloc] initWithFrame:CGRectMake(0, SCREEN_WIDTH/2+20, SCREEN_WIDTH/2, SCREEN_WIDTH/2)];
    view2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view2];
    
    //绘制圆
    CircleView *view3 = [[CircleView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2, SCREEN_WIDTH/2+20, SCREEN_WIDTH/2, SCREEN_WIDTH/2)];
    view3.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view3];
    
    //绘制弧线
    ArcView *view4 = [[ArcView alloc] initWithFrame:CGRectMake(20, SCREEN_WIDTH+40 , SCREEN_WIDTH/2-40, SCREEN_WIDTH/2-40)];
    view4.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view4];
    
    //绘制右上角圆角和左下角
    cornerRadiusView *view5 = [[cornerRadiusView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2+20, SCREEN_WIDTH+40, SCREEN_WIDTH/2-40, SCREEN_WIDTH/2-40)];
    view5.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view5];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
