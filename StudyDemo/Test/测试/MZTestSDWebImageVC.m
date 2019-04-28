//
//  MZTestSDWebImageVC.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/7/12.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "MZTestSDWebImageVC.h"
#import "MZWaveView.h"
#import "NSObject+MZTool.h"
#import "UIView+MZTool.h"
#import "UIImage+MZTool.h"

@interface MZTestSDWebImageVC ()
@property (weak, nonatomic) IBOutlet MZWaveView *waveView;


@end

@implementation MZTestSDWebImageVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"测试";
    
    self.waveView.frontColor = RGB(229, 89, 89);
    self.waveView.insideColor = RGB(90, 160, 245);
    self.waveView.frontSpeed = 0.01;
    self.waveView.insideSpeed = 0.017;
    self.waveView.waveOffset = M_PI_4;
    self.waveView.wavePI = 0.7;
    self.waveView.directionType = WaveDirectionTypeForward;
    
    NSLog(@"WiFi_name========%@",[NSObject SSID]);
    NSLog(@"Version==========%@",[NSObject getAppVersion]);
    NSLog(@"Build============%@",[NSObject getAppBuild]);
    NSLog(@"AppName==========%@",[NSObject getAppName]);
    NSLog(@"AppBundleID======%@",[NSObject getAppBundleIdentifier]);
    
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-100)/2, 200, 100, 100)];
    iconView.image = [UIImage cutCircleImage:[NSObject getAppIcon]];
    [self.view addSubview:iconView];
    
    
    [self.waveView setRoundedCorners:UIRectCornerBottomRight radii:CGSizeMake(10, 10)];
}

@end

