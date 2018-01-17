//
//  ShapeLayerMaskVC.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/1/12.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "ShapeLayerMaskVC.h"
#import "MZCircleProgress.h"
@interface ShapeLayerMaskVC ()
@property (nonatomic, strong)UIView *dynamicView;
@property (nonatomic, strong)CAShapeLayer *layer;
@property (nonatomic, strong)NSTimer *timer;
@property (nonatomic, assign)NSInteger power;
@property (nonatomic, strong)MZCircleProgress *progressView;
@end

@implementation ShapeLayerMaskVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"view的遮罩效果";
    
    [self setupMaskView];
    [self setupDynamicView];
    [self setupCircleView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.timer invalidate];
    self.timer = nil;
}

- (void)setupMaskView {
    //实现view的遮罩效果
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 30, 140, 200)];
    view.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:view];
    
    CGFloat rightSpace = 10;
    CGFloat topSpace = 15;
    CGFloat height = 10;
    
    CGSize size = view.frame.size;
    
    //拐点
    CGPoint point1 = CGPointMake(0, 0);
    CGPoint point2 = CGPointMake(size.width-rightSpace, 0);
    CGPoint point3 = CGPointMake(size.width-rightSpace, topSpace);
    CGPoint point4 = CGPointMake(size.width, topSpace);
    CGPoint point5 = CGPointMake(size.width-rightSpace, topSpace+height);
    CGPoint point6 = CGPointMake(size.width-rightSpace, size.height);
    CGPoint point7 = CGPointMake(0, size.height);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:point1];
    [path addLineToPoint:point2];
    [path addLineToPoint:point3];
    [path addLineToPoint:point4];
    [path addLineToPoint:point5];
    [path addLineToPoint:point6];
    [path addLineToPoint:point7];
    [path closePath];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    
    view.layer.mask = layer;
}

- (void)setupDynamicView {
    UIView *dynamicView = [[UIView alloc] initWithFrame:CGRectMake(200, 30, 80, 150)];
    dynamicView.backgroundColor = RGB(233, 233, 233);
    dynamicView.clipsToBounds = YES;
    dynamicView.layer.cornerRadius = 40;
    dynamicView.layer.masksToBounds = YES;
    dynamicView.layer.borderColor = RGB(136, 136, 136).CGColor;
    dynamicView.layer.borderWidth = 3.0f;
    [self.view addSubview:dynamicView];
    self.dynamicView = dynamicView;
    
    self.power = 10;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(timeFun) userInfo:nil repeats:YES];
}

- (void)timeFun {
    if (self.power == 80) {
        self.power = 10;
    } else {
        self.power += 5;
    }
    if (self.progressView.ratio >= 1.0) {
        self.progressView.ratio = 0;
    } else {
        self.progressView.ratio += 0.02;
    }
    self.progressView.textLabel.text = [NSString stringWithFormat:@"%ld",(NSInteger)(self.progressView.ratio*100)];
    [self refreshViewWithVoicePower:self.power];
}

- (void)refreshViewWithVoicePower:(NSInteger)power {
    CGFloat height = CGRectGetHeight(self.dynamicView.frame)*(power/100.0);
    
    [self.layer removeFromSuperlayer];
    self.layer = nil;
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, CGRectGetHeight(self.dynamicView.frame)-height, CGRectGetWidth(self.dynamicView.frame), height)];
    self.layer = [CAShapeLayer layer];
    self.layer.path = path.CGPath;
    self.layer.fillColor = [UIColor whiteColor].CGColor;
    [self.dynamicView.layer addSublayer:self.layer];
}

- (void)setupCircleView {
    MZCircleProgress *view = [[MZCircleProgress alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2, 250, 200, 200)];
    view.ratio = 0;
    self.progressView = view;
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
