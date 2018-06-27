//
//  OrientationVC.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/6/27.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "OrientationVC.h"

@interface OrientationVC ()

@end

@implementation OrientationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"横竖屏处理";
    
    /*
     因为我是后来才坐横竖屏的demo，所以处理的并不完善
     具体请参照：https://www.jianshu.com/p/a2201f39b6a7
     */
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscapeRight;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeRight;
}
@end
