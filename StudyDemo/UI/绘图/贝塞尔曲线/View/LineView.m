//
//  LineView.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/1/11.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "LineView.h"

@implementation LineView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    //设置线条颜色
    UIColor *color = [UIColor redColor];
    [color set];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(10, 10)];
    [path addLineToPoint:CGPointMake(rect.size.width-10, rect.size.height-10)];
    path.lineWidth = 5.0;
    path.lineCapStyle = kCGLineCapRound;//终点样式
    path.lineJoinStyle = kCGLineJoinRound;//拐点样式
    
    [path stroke];
}

/*
 1、[color set];设置线条颜色，也就是相当于画笔颜色
 2、path.lineWidth = 5.0;这个很好理解了，就是划线的宽度
 3、path.lineCapStyle这个线段起点是终点的样式，这个样式有三种：
 （
     1、kCGLineCapButt该属性值指定不绘制端点， 线条结尾处直接结束。这是默认值。
     2、kCGLineCapRound 该属性值指定绘制圆形端点， 线条结尾处绘制一个直径为线条宽度的半圆。
     3、kCGLineCapSquare 该属性值指定绘制方形端点。 线条结尾处绘制半个边长为线条宽度的正方形。需要说明的是，这种形状的端点与“butt”形状的端点十分相似，只是采用这种形式的端点的线条略长一点而已
 ）
 4、path.lineJoinStyle这个属性是用来设置两条线连结点的样式，同样它也有三种样式供我们选择
 (
     1、kCGLineJoinMiter 斜接
     2、kCGLineJoinRound 圆滑衔接
     3、kCGLineJoinBevel 斜角连接
 ）
 5、[path stroke];用 stroke 得到的是不被填充的 view ，[path fill]; 用 fill 得到的内部被填充的 view
 */

//https://www.jianshu.com/p/c883fbf52681
@end
