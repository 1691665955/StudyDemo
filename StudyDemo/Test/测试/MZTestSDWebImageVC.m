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
#import "MZAudioPlayTool.h"

@interface MZTestSDWebImageVC ()
@property (weak, nonatomic) IBOutlet MZWaveView *waveView;

@property (weak, nonatomic) IBOutlet UIView *testView;

@end

@implementation MZTestSDWebImageVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"测试";
    self.view.backgroundColor = RGB(229, 89, 89);
    
    
    self.waveView.frontColor = RGB(229, 89, 89);
    self.waveView.insideColor = RGB(90, 160, 245);
    self.waveView.backgroundColor = RGB(80, 190, 230);
    self.waveView.frontHeight = 10;
    self.waveView.insideHeight = 17;
    self.waveView.directionType = WaveDirectionTypeForward;
    
    NSLog(@"WiFi_name========%@",[NSObject SSID]);
    NSLog(@"Version==========%@",[NSObject getAppVersion]);
    NSLog(@"Build============%@",[NSObject getAppBuild]);
    NSLog(@"AppName==========%@",[NSObject getAppName]);
    NSLog(@"AppBundleID======%@",[NSObject getAppBundleIdentifier]);
    
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-100)/2, 200, 100, 100)];
    iconView.image = [UIImage cutPartCircleImage:[NSObject getAppIcon] corners:UIRectCornerTopRight|UIRectCornerBottomLeft radii:CGSizeMake(30, 40)];
    [self.view addSubview:iconView];
    
    [self.testView setRoundedCorners:UIRectCornerTopRight radii:CGSizeMake(10, 10)];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(37.5, 150, SCREEN_WIDTH-75, 44);
    btn.layer.cornerRadius = 18;
    btn.layer.masksToBounds = YES;
    [btn setBackgroundColor:RGB(229, 89, 89)];
    [btn setTitle:@"播放" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [btn addTarget:self action:@selector(playAudio) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)playAudio {
    [MZAudioPlayTool playAudioWithName:@"test.mp3"];
    [MZAudioPlayTool vibrate];
}

@end

