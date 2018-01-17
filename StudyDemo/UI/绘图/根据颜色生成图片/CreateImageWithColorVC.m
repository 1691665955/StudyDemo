//
//  CreateImageWithColorVC.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/1/11.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "CreateImageWithColorVC.h"

@interface CreateImageWithColorVC ()

@end

@implementation CreateImageWithColorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"根据颜色生成图片";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-250)/2, 100, 250, 250)];
    imageView.image = [UIImage getImageWithColor:[UIColor cyanColor]];
    [self.view addSubview:imageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
