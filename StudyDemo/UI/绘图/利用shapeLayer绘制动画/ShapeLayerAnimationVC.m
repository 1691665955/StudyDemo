//
//  ShapeLayerAnimationVC.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/6/27.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "ShapeLayerAnimationVC.h"

@interface ShapeLayerAnimationVC ()
@property (nonatomic, strong)NSTimer *timer;
@property (nonatomic, strong)UIView *bgView;
@property (nonatomic, assign)NSInteger count;
@property (nonatomic, strong)CAShapeLayer *shapeLayer;
@end

@implementation ShapeLayerAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"利用shapeLayer绘制动画";
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 250, 250)];
    self.bgView.center = self.view.center;
    self.bgView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.bgView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.count = 0;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(timeFun) userInfo:nil repeats:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.timer invalidate];
    self.timer = nil;
}

- (void)timeFun {
    self.count += 10;
    NSInteger start = self.count%1000;
    CGPoint startPoint;
    CGPoint middlePoint;
    CGPoint endPoint;
    if (start <= 250) {
        startPoint = CGPointMake(start, 0);
        middlePoint = CGPointMake(250, 0);
        endPoint = CGPointMake(250, start);
    } else if (start <= 500) {
        startPoint = CGPointMake(250, start-250);
        middlePoint = CGPointMake(250, 250);
        endPoint = CGPointMake(500-start, 250);
    } else if (start <= 750) {
        startPoint = CGPointMake(750-start, 250);
        middlePoint = CGPointMake(0, 250);
        endPoint = CGPointMake(0, 750-start);
    } else {
        startPoint = CGPointMake(0, 1000-start);
        middlePoint = CGPointMake(0, 0);
        endPoint = CGPointMake(start-750, 0);
    }
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:startPoint];
    [path addLineToPoint:middlePoint];
    [path addLineToPoint:endPoint];
    
    if (self.shapeLayer) {
        [self.shapeLayer removeFromSuperlayer];
        self.shapeLayer = nil;
    }
    
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.lineWidth = 4;
    self.shapeLayer.strokeColor = RGB(5, 184, 141).CGColor;
    self.shapeLayer.fillColor = [UIColor clearColor].CGColor;
    self.shapeLayer.path = path.CGPath;
    [self.bgView.layer addSublayer:self.shapeLayer];
}

@end
