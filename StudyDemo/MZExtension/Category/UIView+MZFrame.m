//
//  UIView+MZFrame.m
//  StudyDemo
//
//  Created by 曾龙 on 2019/4/18.
//  Copyright © 2019年 曾龙. All rights reserved.
//

#import "UIView+MZFrame.h"

@implementation UIView (MZFrame)
/**
 获取试图的origin x
 
 @return 返回 origin x
 */
- (CGFloat)mz_x {
    return self.frame.origin.x;
}

/**
 设置试图的origin x
 
 @param mz_x 试图的origin x
 */
- (void)setMz_x:(CGFloat)mz_x {
    CGRect frame = self.frame;
    frame.origin.x = mz_x;
    self.frame = frame;
}

/**
 获取试图的origin y
 
 @return 返回 origin y
 */
- (CGFloat)mz_y {
    return self.frame.origin.y;
}

/**
 设置试图的origin y
 
 @param mz_y 试图的origin y
 */
- (void)setMz_y:(CGFloat)mz_y {
    CGRect frame = self.frame;
    frame.origin.y = mz_y;
    self.frame = frame;
}

/**
 获取试图的size width
 
 @return 返回试图的size width
 */
- (CGFloat)mz_width {
    return self.frame.size.width;
}

/**
 设置试图的size width
 
 @param mz_width 试图的size width
 */
- (void)setMz_width:(CGFloat)mz_width {
    CGRect frame = self.frame;
    frame.size.width = mz_width;
    self.frame = frame;
}

/**
 获取试图的size height
 
 @return 返回试图的size height
 */
- (CGFloat)mz_height {
    return self.frame.size.height;
}

/**
 设置试图的size height
 
 @param mz_height 试图的size height
 */
- (void)setMz_height:(CGFloat)mz_height {
    CGRect frame = self.frame;
    frame.size.height = mz_height;
    self.frame = frame;
}

/**
 获取试图的center x
 
 @return 返回试图的center x
 */
- (CGFloat)mz_centerX {
    return self.center.x;
}

/**
 设置试图的center x
 
 @param mz_centerX 试图的center x
 */
- (void)setMz_centerX:(CGFloat)mz_centerX {
    CGPoint center = self.center;
    center.x = mz_centerX;
    self.center = center;
}

/**
 获取试图的center y
 
 @return 返回试图的center y
 */
- (CGFloat)mz_centerY {
    return self.center.y;
}

/**
 设置试图的center y
 
 @param mz_centerY 试图的center y
 */
- (void)setMz_centerY:(CGFloat)mz_centerY {
    CGPoint center = self.center;
    center.y = mz_centerY;
    self.center = center;
}
@end
