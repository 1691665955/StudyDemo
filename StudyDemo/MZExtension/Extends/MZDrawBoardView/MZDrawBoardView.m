//
//  MZDrawBoardView.m
//  StudyDemo
//
//  Created by 曾龙 on 2019/4/18.
//  Copyright © 2019年 曾龙. All rights reserved.
//

#import "MZDrawBoardView.h"

@interface MZDrawBoardView ()
@property (nonatomic, assign) CGPoint startPoint;
@property (nonatomic, assign) CGPoint endPoint;
@end

@implementation MZDrawBoardView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.fillColor = [UIColor blackColor];
    self.lineWidth = 4;
    self.clipsToBounds = YES;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:tap];
}

- (void)clear {
    for (int i = 0; i < self.layer.sublayers.count; ) {
        CALayer *layer = self.layer.sublayers[i];
        [layer removeFromSuperlayer];
    }
}

- (UIImage *)getImage {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)pan:(UIPanGestureRecognizer *)pan {
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.startPoint = [pan locationInView:self];
            self.endPoint = [pan locationInView:self];
            [self updateLayer];
        }
            break;
        case UIGestureRecognizerStateChanged:
        case UIGestureRecognizerStateEnded:
        {
            self.startPoint = self.endPoint;
            self.endPoint = [pan locationInView:self];
            [self updateLayer];
        }
            break;
        default:
            break;
    }
}

- (void)tap:(UITapGestureRecognizer *)tap {
    self.startPoint = [tap locationInView:self];
    self.endPoint = [tap locationInView:self];
    [self updateLayer];
}


- (void)updateLayer {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:self.startPoint];
    [path addLineToPoint:self.endPoint];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.lineWidth = self.lineWidth;
    shapeLayer.strokeColor = self.fillColor.CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.path = path.CGPath;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    [self.layer addSublayer:shapeLayer];
}


@end
