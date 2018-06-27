//
//  UIImage+MZTool.h
//  StudyDemo
//
//  Created by 曾龙 on 2018/1/11.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MZTool)

/**
 根据颜色生成图片
 */
+ (UIImage *)getImageWithColor:(UIColor *)color;

/**
 根据字符串和二维码图片大小来生成二维码图片
 
 @param string 生成二维码的内容
 @param size 二维码图片的大小
 @return 二维码图片
 */
+ (UIImage *)createBarCodeImageWithString:(NSString *)string size:(CGFloat)size;
@end
