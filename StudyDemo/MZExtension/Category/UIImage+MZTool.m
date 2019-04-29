//
//  UIImage+MZTool.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/1/11.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "UIImage+MZTool.h"

@implementation UIImage (MZTool)

/**
 根据颜色生成图片
 */
+ (UIImage *)getImageWithColor:(UIColor *)color {
    CGRect frame = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, frame);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/*
 根据字符串和二维码图片大小来生成二维码图片
 */
+ (UIImage *)createBarCodeImageWithString:(NSString *)string size:(CGFloat)size {
    //创建滤镜对象
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    //恢复默认设置
    [filter setDefaults];
    //设置数据
    NSData *infoData = [string dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:infoData forKey:@"inputMessage"];
    //生成二维码
    CIImage *outputImage = [filter outputImage];
    return [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:size];
}

+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

/**
 根据颜色的渐变色获取图片
 
 @param frame 图片大小
 @param startColor 起始颜色
 @param endColor 终止颜色
 @param startPoint 起始位置
 @param endPoint 终止位置
 eg:startPoint为(0,0) endPoint为(1,0)代表渐变色从左到右 startPoint为(0,0) endPoint为(0,1)代表渐变色从上到下
 */
+ (UIImage *)createImageWithFrame:(CGRect)frame startColor:(UIColor *)startColor endColor:(UIColor *)endColor startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint {
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.startPoint = startPoint;
    gradient.endPoint = endPoint;
    gradient.frame = frame;
    gradient.colors = [NSArray arrayWithObjects:(id)startColor.CGColor, (id)endColor.CGColor, nil];
    
    //创建CGContextRef
    UIGraphicsBeginImageContext(frame.size);
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    //创建CGMutablePathRef
    CGMutablePathRef path = CGPathCreateMutable();
    
    //绘制Path
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, frame.size.width, 0);
    CGPathAddLineToPoint(path, NULL, frame.size.width, frame.size.height);
    CGPathAddLineToPoint(path, NULL, 0, frame.size.height);
    CGPathCloseSubpath(path);
    [self drawLinearGradient:contextRef path:path startColor:startColor.CGColor endColor:endColor.CGColor startPoint:startPoint endPoint:endPoint];
    CGPathRelease(path);
    
    //从Context中获取图像
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (void)drawLinearGradient:(CGContextRef)context path:(CGPathRef)path startColor:(CGColorRef)startColor endColor:(CGColorRef)endColor startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint {
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };
    
    NSArray *colors = @[(__bridge id) startColor, (__bridge id) endColor];
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    
    
    CGRect pathRect = CGPathGetBoundingBox(path);
    
    //具体方向可根据需求修改
    startPoint = CGPointMake(pathRect.size.width*startPoint.x, pathRect.size.height*startPoint.y);
    endPoint = CGPointMake(pathRect.size.width*endPoint.x, pathRect.size.height*endPoint.y);
    
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}

/**
 base64字符串转图片
 */
+ (UIImage *)stringToImage:(NSString *)base64String {
    NSData * imageData =[[NSData alloc] initWithBase64EncodedString:base64String options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *image = [UIImage imageWithData:imageData];
    return image;
}

/**
 图片转base64字符串
 */
- (NSString *)imageToBase64String {
    NSData *imagedata = UIImagePNGRepresentation(self);
    NSString *base64String = [imagedata base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return base64String;
}

/**
 截取view成图片
 */
+ (UIImage *)clipsImage:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/**
 对图片进行剪切，获取指定范围的图片

 @param image 被截取的图片
 @param frame 截取的范围
 */
+ (UIImage *)clipsImage:(UIImage *)image frame:(CGRect)frame {
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat x = frame.origin.x*scale;
    CGFloat y = frame.origin.y*scale;
    CGFloat w = frame.size.width*scale;
    CGFloat h = frame.size.height*scale;
    CGRect newFrame = CGRectMake(x, y, w, h);
    
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, newFrame);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
    return newImage;
}


/**
 重新生成指定大小图片

 @param image 原图片
 @param size 生成图片的大小
 */
+ (UIImage *)resizeImage:(UIImage *)image toSize:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0.0, size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, CGRectMake(0, 0, size.width, size.height), image.CGImage);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

/**
 生成圆形图片
 
 @param image 原图片
 */
+ (UIImage *)cutCircleImage:(UIImage *)image {
    return [self cutPartCircleImage:image corners:UIRectCornerAllCorners radii:CGSizeMake(image.size.width/2, image.size.height/2)];
}

/**
 生成部分圆角图片

 @param image 原图片
 @param corners 圆角方向
 @param radii 圆角大小
 */
+ (UIImage *)cutPartCircleImage:(UIImage *)image corners:(UIRectCorner)corners radii:(CGSize)radii {
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0);
    CGContextRef ref = UIGraphicsGetCurrentContext();
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, image.size.width, image.size.height) byRoundingCorners:corners cornerRadii:radii];
    CGContextAddPath(ref, path.CGPath);
    CGContextClip(ref);
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    CGContextDrawPath(ref, kCGPathStroke);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
