//
//  PolygonView.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/1/11.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "PolygonView.h"

@implementation PolygonView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    UIColor *color = [UIColor redColor];
    [color set];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 5.0f;
    
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    
    [path moveToPoint:CGPointMake(rect.size.width/4, 0)];
    //draw the line
    [path addLineToPoint:CGPointMake(rect.size.width/4*3, 0)];
    [path addLineToPoint:CGPointMake(rect.size.width, rect.size.width/4*sqrt(3))];
    [path addLineToPoint:CGPointMake(rect.size.width/4*3, rect.size.width/2*sqrt(3))];
    [path addLineToPoint:CGPointMake(rect.size.width/4, rect.size.width/2*sqrt(3))];
    [path addLineToPoint:CGPointMake(0, rect.size.width/4*sqrt(3))];
    [path closePath];
    
    [path fill];
}

@end
