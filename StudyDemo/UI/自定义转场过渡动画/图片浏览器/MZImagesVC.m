//
//  MZImagesVC.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/10/15.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "MZImagesVC.h"
#import "MZImageBrowsingVC.h"

@interface MZImagesVC ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;
@property (weak, nonatomic) IBOutlet UIImageView *imageView4;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imageViewArray;
@end

@implementation MZImagesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"图片浏览器";
}

- (IBAction)imageSelected:(UITapGestureRecognizer *)sender {
    MZImageBrowsingVC *vc = [[MZImageBrowsingVC alloc] initWithImageViewArray:self.imageViewArray currentIndex:sender.view.tag-100];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
