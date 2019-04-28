//
//  MZWaveView.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/2/1.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "MZWaveView.h"

@interface MZWaveView()
{
    CGFloat waveWidth;
    CGFloat waveHeight;
    
    //y = A*sin(w*x+φ)+k  正弦三角函数
    
    CGFloat waveA;   //振幅：波浪最高点到最低点距离的一半
    CGFloat waveW;   //频率：代表波浪流动的快慢
    CGFloat offSetF; //初相：外层波浪水平开始点
    CGFloat offSetS; //初相：内层波浪水平开始点
    CGFloat currentK; //偏移：波浪垂直起始点
}

@property (nonatomic ,strong)CAShapeLayer *frontWaveLayer;
@property (nonatomic ,strong)CAShapeLayer *insideWaveLayer;
@property (nonatomic ,strong)CADisplayLink *waveDisplayLink;
@end

@implementation MZWaveView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configWaveProperties];
        [self createWaves];
        [self setupDisplayLink];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self configWaveProperties];
        [self createWaves];
        [self setupDisplayLink];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    waveWidth = self.frame.size.width;
    waveHeight = self.frame.size.height;
    
    waveA = waveHeight/2;
    waveW = 2*M_PI/waveWidth*_wavePI;
    
    offSetF = 0;
    offSetS = offSetF + _waveOffset;
    currentK = waveHeight/2;
}

//给参数赋初值
- (void)configWaveProperties {
    _frontColor = [UIColor blackColor];
    _insideColor = [UIColor grayColor];
    _frontSpeed = 0.01;
    _insideSpeed = 0.01*1.2;
    _waveOffset = M_PI;
    _wavePI = 1.5;
    _directionType = WaveDirectionTypeBackWard;
}

//设置波浪参数
- (void)createWaves {
    waveWidth = self.frame.size.width;
    waveHeight = self.frame.size.height;
    
    waveA = waveHeight/2;
    waveW = 2*M_PI/waveWidth*_wavePI;
    
    offSetF = 0;
    offSetS = offSetF + _waveOffset;
    currentK = waveHeight/2;
    
    _frontWaveLayer = [CAShapeLayer layer];
    _frontWaveLayer.fillColor = _frontColor.CGColor;
    [self.layer addSublayer:_frontWaveLayer];
    
    _insideWaveLayer = [CAShapeLayer layer];
    _insideWaveLayer.fillColor = _insideColor.CGColor;
    [self.layer insertSublayer:_insideWaveLayer below:_frontWaveLayer];
}

- (void)setupDisplayLink {
    _waveDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(refreshCurrentWave:)];
    [_waveDisplayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

//根据正弦函数绘制两个波形
- (void)drawCurrentWaveWithLayer:(CAShapeLayer *)waveLayer offset:(CGFloat)offset {
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGFloat y = currentK;
    CGPathMoveToPoint(path, nil, 0, y);//将坐标移到坐标(0,k);
    
    for(int i=0 ;i<= waveWidth; i++) {
        y = waveA * sin(waveW*i+offset)+currentK;
        CGPathAddLineToPoint(path, nil, i, y);
    }
    CGPathAddLineToPoint(path, nil, waveWidth, waveHeight);
    CGPathAddLineToPoint(path, nil, 0, waveHeight);
    CGPathCloseSubpath(path);
    waveLayer.path = path;
    CGPathRelease(path);
}

- (void)refreshCurrentWave:(CADisplayLink *)displayLink {
    offSetF += _frontSpeed*_directionType;
    offSetS += _insideSpeed*_directionType;
    [self drawCurrentWaveWithLayer:_frontWaveLayer offset:offSetF];
    [self drawCurrentWaveWithLayer:_insideWaveLayer offset:offSetS];
}

- (void)setFrontColor:(UIColor *)frontColor {
    if (_frontColor != frontColor) {
        _frontColor = frontColor;
        _frontWaveLayer.fillColor = frontColor.CGColor;
    }
}

- (void)setInsideColor:(UIColor *)insideColor {
    if (_insideColor != insideColor) {
        _insideColor = insideColor;
        _insideWaveLayer.fillColor = insideColor.CGColor;
    }
}

- (void)setWaveOffset:(CGFloat)waveOffset {
    if (_waveOffset != waveOffset) {
        _waveOffset = waveOffset;
        offSetS = offSetF + waveOffset;
    }
}

- (void)dealloc {
    [_waveDisplayLink invalidate];
    _waveDisplayLink = nil;
}

@end
