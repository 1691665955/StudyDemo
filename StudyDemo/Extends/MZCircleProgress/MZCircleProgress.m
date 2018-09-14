//
//  MZCircleProgress.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/1/12.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "MZCircleProgress.h"

@interface MZCircleProgress()
@property (nonatomic ,strong)CAShapeLayer *lineLayer;
@end

@implementation MZCircleProgress

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
    self.backgroundColor = [UIColor clearColor];
    
    UILabel *textLabel = [[UILabel alloc] init];
    self.textLabel = textLabel;
    textLabel.textColor = [UIColor cyanColor];
    textLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:textLabel];
    
    self.backLineColor = [UIColor lightGrayColor];
    self.backLineWidth = 6.0f;
    
    self.progressColor = [UIColor cyanColor];
    self.progressWidth = 6.0f;
    
    self.textLabel.font = [UIFont systemFontOfSize:50];
    
    self.startAngle = -M_PI_2;
    self.endAngle = M_PI_2+M_PI;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGFloat radius = ((self.frame.size.width > self.frame.size.height ? self.frame.size.height : self.frame.size.width)-(self.backLineWidth > self.progressWidth ? self.backLineWidth : self.progressWidth))*0.5;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGPoint centerPoint = CGPointMake(self.bounds.size.width*0.5, self.bounds.size.height*0.5);
    [path addArcWithCenter:centerPoint radius:radius startAngle:self.startAngle endAngle:self.endAngle clockwise:YES];
    
    CAShapeLayer *backlayer = [CAShapeLayer layer];
    backlayer.frame = self.bounds;
    backlayer.fillColor = [UIColor clearColor].CGColor;
    backlayer.lineWidth = self.backLineWidth;
    backlayer.strokeColor = self.backLineColor.CGColor;
    backlayer.strokeStart = 0;
    backlayer.strokeEnd = 1;
    backlayer.path = path.CGPath;
    [self.layer addSublayer:backlayer];
    
    CAShapeLayer *linelayer = [CAShapeLayer layer];
    linelayer.frame = self.bounds;
    linelayer.fillColor = [UIColor clearColor].CGColor;
    linelayer.lineWidth = self.progressWidth;
    linelayer.strokeColor = self.progressColor.CGColor;
    linelayer.strokeStart = 0;
    linelayer.strokeEnd = self.ratio;
    linelayer.path = path.CGPath;
    self.lineLayer = linelayer;
    [self.layer addSublayer:linelayer];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.textLabel.frame = CGRectMake(0, 0, self.bounds.size.width*0.8, self.bounds.size.width*0.5);
    self.textLabel.center = CGPointMake(self.bounds.size.width*0.5, self.bounds.size.height*0.5);
}

- (void)setRatio:(double)ratio {
    if (ratio < 0) {
        _ratio = 0;
    } else if (ratio > 1) {
        _ratio = 1;
    } else {
        _ratio = ratio;
    }
    
    self.lineLayer.strokeEnd = self.ratio;
}

@end
