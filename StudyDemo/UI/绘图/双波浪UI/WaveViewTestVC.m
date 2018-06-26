//
//  WaveViewTestVC.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/2/1.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "WaveViewTestVC.h"
#import "MZWaveView.h"
@interface WaveViewTestVC ()

@end

@implementation WaveViewTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"双波浪UI";
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    v.backgroundColor = RGB(90, 160, 245);
    [self.view addSubview:v];
    
    MZWaveView *view = [[MZWaveView alloc] initWithFrame:CGRectMake(0, 190, SCREEN_WIDTH, 10)];
    view.frontColor = [UIColor whiteColor];
    view.insideColor = [RGB(245, 245, 245) colorWithAlphaComponent:0.5];
    [v addSubview:view];
}



@end
