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
    
    CGFloat frontWaveA;        //振幅：外层波浪最高点到最低点距离的一半
    CGFloat insideWaveA;       //振幅：内层波浪最高点到最低点距离的一半
    CGFloat frontWaveW;        //频率：代表外层波浪流动的快慢
    CGFloat insideWaveW;       //频率：代表内层浪流动的快慢
    CGFloat frontOffSet;       //初相：外层波浪水平开始点
    CGFloat insideOffSet;      //初相：内层波浪水平开始点
    CGFloat frontCurrentK;     //偏移：外层波浪垂直起始点
    CGFloat insideCurrentK;    //偏移：内层波浪垂直起始点
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
    if (self.frontHeight == 0) {
        self.frontHeight = waveHeight*2/3;
    }
    if (self.insideHeight == 0) {
        self.insideHeight = waveHeight;
    }
    
    frontWaveA = self.frontHeight/2;
    insideWaveA = self.insideHeight/2;
    frontWaveW = 2*M_PI/waveWidth*_frontWavePI;
    insideWaveW = 2*M_PI/waveWidth*_insideWavePI;
    
    frontOffSet = 0;
    insideOffSet = frontOffSet + _waveOffset;
    frontCurrentK = waveHeight-self.frontHeight/2;
    insideCurrentK = waveHeight-self.insideHeight/2;
}

//给参数赋初值
- (void)configWaveProperties {
    _frontColor = [UIColor blackColor];
    _insideColor = [UIColor grayColor];
    _frontSpeed = 0.02;
    _insideSpeed = 0.03;
    _waveOffset = M_PI;
    _frontWavePI = 2.5;
    _insideWavePI = 3;
    _directionType = WaveDirectionTypeBackWard;
}

//设置波浪参数
- (void)createWaves {
    waveWidth = self.frame.size.width;
    waveHeight = self.frame.size.height;
    
    frontWaveA = self.frontHeight/2;
    insideWaveA = self.insideHeight/2;
    frontWaveW = 2*M_PI/waveWidth*_frontWavePI;
    insideWaveW = 2*M_PI/waveWidth*_insideWavePI;
    
    frontOffSet = 0;
    insideOffSet = frontOffSet + _waveOffset;
    frontCurrentK = self.frontHeight/2;
    insideCurrentK = self.insideHeight/2;
    
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
    if (waveLayer == _frontWaveLayer) {
        CGFloat y = frontCurrentK;
        CGPathMoveToPoint(path, nil, 0, y);//将坐标移到坐标(0,k);
        for(int i=0 ;i<= waveWidth; i++) {
            y = frontWaveA * sin(frontWaveW*i+frontOffSet)+frontCurrentK;
            CGPathAddLineToPoint(path, nil, i, y);
        }
        CGPathAddLineToPoint(path, nil, waveWidth, waveHeight);
        CGPathAddLineToPoint(path, nil, 0, waveHeight);
        CGPathCloseSubpath(path);
        waveLayer.path = path;
        CGPathRelease(path);
    } else {
        CGFloat y = insideCurrentK;
        CGPathMoveToPoint(path, nil, 0, y);//将坐标移到坐标(0,k);
        for(int i=0 ;i<= waveWidth; i++) {
            y = insideWaveA * sin(insideWaveW*i+insideOffSet)+insideCurrentK;
            CGPathAddLineToPoint(path, nil, i, y);
        }
        CGPathAddLineToPoint(path, nil, waveWidth, waveHeight);
        CGPathAddLineToPoint(path, nil, 0, waveHeight);
        CGPathCloseSubpath(path);
        waveLayer.path = path;
        CGPathRelease(path);
    }
}

- (void)refreshCurrentWave:(CADisplayLink *)displayLink {
    frontOffSet += _frontSpeed*_directionType;
    insideOffSet += _insideSpeed*_directionType;
    [self drawCurrentWaveWithLayer:_frontWaveLayer offset:frontOffSet];
    [self drawCurrentWaveWithLayer:_insideWaveLayer offset:insideOffSet];
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
        insideOffSet = frontOffSet + waveOffset;
    }
}

- (void)dealloc {
    [_waveDisplayLink invalidate];
    _waveDisplayLink = nil;
}

@end
