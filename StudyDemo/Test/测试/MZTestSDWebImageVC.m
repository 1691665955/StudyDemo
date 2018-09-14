//
//  MZTestSDWebImageVC.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/7/12.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "MZTestSDWebImageVC.h"
#import "MZMarqueeLabel.h"

@interface MZTestSDWebImageVC ()

@end

@implementation MZTestSDWebImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"测试";
    
    MZMarqueeLabel *marqueeLabel = [[MZMarqueeLabel alloc] initWithFrame:CGRectMake(20, 100, SCREEN_WIDTH-40, 40)];
    marqueeLabel.backgroundColor = [UIColor lightGrayColor];
    [marqueeLabel setupText:@"简单方法简单方法简单方法简单方法简单方法简单方法简单方法简单方法简单方法简单方法简单方法简单方法简单方法简单方法简单方法简单方法" font:[UIFont systemFontOfSize:16] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft direction:MZMarqueeDirectionLeftToRight whiteSpace:@"        "];
    [self.view addSubview:marqueeLabel];
}

@end
