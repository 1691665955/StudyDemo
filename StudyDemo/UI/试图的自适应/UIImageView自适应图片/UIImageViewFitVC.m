//
//  UIImageViewFitVC.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/1/15.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "UIImageViewFitVC.h"

@interface UIImageViewFitVC ()

@end

@implementation UIImageViewFitVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"UIImageView自适应图片";
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-Navi_Height)];
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    
    if (iOS11Later) {
        adjustsScrollViewInsets_NO(scrollView, self);
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    //图片回自动放缩，显示全部，但是可能会有留白
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 30, SCREEN_WIDTH-40, 150)];
    imageView.backgroundColor = RGB(223, 223, 223);
    imageView.image = [UIImage imageNamed:@"艾斯.jpg"];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [scrollView addSubview:imageView];
    
    //图片会成比例填充，但是可能会超出imageView界面，用clipsToBounds截取
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 200, SCREEN_WIDTH-40, 150)];
    imageView1.backgroundColor = RGB(223, 223, 223);
    imageView1.image = [UIImage imageNamed:@"艾斯.jpg"];
    imageView1.contentMode = UIViewContentModeScaleAspectFill;
    imageView1.clipsToBounds = YES;
    [scrollView addSubview:imageView1];
    
    
    //固定图片宽度，自适应高度
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 370, SCREEN_WIDTH-40, 100)];
    imageView2.backgroundColor = RGB(223, 223, 223);
    UIImage *image2 = [UIImage imageNamed:@"艾斯.jpg"];
    imageView2.image = image2;
    imageView2.frame = CGRectMake(20, 370, SCREEN_WIDTH-40, image2.size.height/image2.size.width*(SCREEN_WIDTH-40));
    [scrollView addSubview:imageView2];
    
    //固定图片高度，自适应宽度
    UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(imageView2.frame)+20, SCREEN_WIDTH-40, 100)];
    imageView3.backgroundColor = RGB(223, 223, 223);
    UIImage *image3 = [UIImage imageNamed:@"艾斯.jpg"];
    imageView3.image = image3;
    imageView3.frame = CGRectMake(20, CGRectGetMaxY(imageView2.frame)+20, image3.size.width/image3.size.height*100, 100);
    [scrollView addSubview:imageView3];
    
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, CGRectGetMaxY(imageView3.frame)+20);
}



@end
