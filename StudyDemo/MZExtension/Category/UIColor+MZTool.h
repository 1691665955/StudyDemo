//
//  UIColor+MZTool.h
//  StudyDemo
//
//  Created by 曾龙 on 2019/4/11.
//  Copyright © 2019年 曾龙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (MZTool)

/**
 获取图片上某个点的颜色

 @param point 图片位置
 @param image 图片
 @return 颜色
 */
+ (UIColor *)colorAtPixel:(CGPoint)point withImage:(UIImage *)image;

/**
 根据16进制字符串获取颜色
 
 @param hexString 16进制字符串
 @return 颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString;
@end

NS_ASSUME_NONNULL_END
