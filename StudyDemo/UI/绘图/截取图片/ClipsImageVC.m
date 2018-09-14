//
//  ClipsImageVC.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/1/15.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "ClipsImageVC.h"

@interface ClipsImageVC ()
@property (nonatomic ,strong)UIImageView *imageView;
@end

@implementation ClipsImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"截取图片";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, (SCREEN_WIDTH-60)/2, (SCREEN_WIDTH-60)*3/8.0)];
    imageView.image = [UIImage imageNamed:@"艾斯.jpg"];
    [self.view addSubview:imageView];
    self.imageView = imageView;
    
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(imageView.frame), 25)];
    lb.backgroundColor = [UIColor clearColor];
    lb.textColor = [UIColor whiteColor];
    lb.textAlignment = NSTextAlignmentCenter;
    lb.font = [UIFont boldSystemFontOfSize:18];
    lb.text = @"D的意志";
    [imageView addSubview:lb];
    
    /*********************************截取imageView成图片**********************************/
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2+10, 20, (SCREEN_WIDTH-60)/2, (SCREEN_WIDTH-60)*3/8.0)];
    imageView1.image = [self clipsImage1:imageView];
    [self.view addSubview:imageView1];
}

- (UIImage *)clipsImage1:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 2);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)clipsImage2:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置截图的背景颜色，如果view底色是白色，那么在微信分享时，微信看到的图片底色会是黑色
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, view.bounds);
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

//对图片进行剪切，获取指定范围的图片
- (UIImage *)clipsImage3:(UIImage *)image frame:(CGRect)frame {
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

//重新生成指定大小图片
- (UIImage *)resizeImage:(UIImage *)image toSize:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0.0, size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, CGRectMake(0, 0, size.width, size.height), image.CGImage);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

//将图片保存到相册
- (void)saveImageToPhotosAlbumWithImage:(UIImage *)image {
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
    if (!error) {
        [MBProgressHUD showSuccess:@"已经保存到相册"];
    } else {
        [MBProgressHUD showError:@"保存失败"];
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.imageView.frame)+20, (SCREEN_WIDTH-60)/2, (SCREEN_WIDTH-60)*3/8.0)];
    imageView2.image = [self clipsImage2:self.imageView];
    [self.view addSubview:imageView2];
    
    UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2+10, CGRectGetMaxY(self.imageView.frame)+20+25, (SCREEN_WIDTH-60)/2, (SCREEN_WIDTH-60)*3/8.0-25)];
    imageView3.image = [self clipsImage3:imageView2.image frame:CGRectMake(0, 25, SCREEN_WIDTH, (SCREEN_WIDTH-60)*3/8.0-25)];
    [self.view addSubview:imageView3];
    
    UIImageView *imageView4 = [[UIImageView alloc] initWithFrame:CGRectMake(40, CGRectGetMaxY(imageView3.frame)+30, 200, 150)];
    imageView4.image = [self resizeImage:self.imageView.image toSize:CGSizeMake(200, 150)];
    [self.view addSubview:imageView4];
}



@end
