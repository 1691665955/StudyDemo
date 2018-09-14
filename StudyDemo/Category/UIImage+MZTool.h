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

/**
 根据颜色的渐变色获取图片
 
 @param frame 图片大小
 @param startColor 起始颜色
 @param endColor 终止颜色
 @param startPoint 起始位置
 @param endPoint 终止位置
 eg:startPoint为(0,0) endPoint为(1,0)代表渐变色从左到右 startPoint为(0,0) endPoint为(0,1)代表渐变色从上到下
 */
+ (UIImage *)createImageWithFrame:(CGRect)frame startColor:(UIColor *)startColor endColor:(UIColor *)endColor startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

/**
 base64字符串转图片
 */
+ (UIImage *)stringToImage:(NSString *)base64String;

/**
 图片转base64字符串
 */
- (NSString *)imageToBase64String;

/**
 截取view成图片

 @param view 被截取的view
 */
+ (UIImage *)clipsImage:(UIView *)view;

/**
 对图片进行剪切，获取指定范围的图片
 
 @param image 被截取的图片
 @param frame 截取的范围
 */
+ (UIImage *)clipsImage:(UIImage *)image frame:(CGRect)frame;

/**
 重新生成指定大小图片
 
 @param image 原图片
 @param size 生成图片的大小
 */
+ (UIImage *)resizeImage:(UIImage *)image toSize:(CGSize)size;
@end
