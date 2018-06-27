//
//  MZTabBarController.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/6/27.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "MZTabBarController.h"
#import "MZTabBar.h"
#import "MZNavigationController.h"
@interface MZTabBarController ()<MZTabBarDelegate>

@end

@implementation MZTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    MZTabBar *tabbar = [[MZTabBar alloc] init];
    tabbar.mzTabBarDelegate = self;
    [self setValue:tabbar forKey:@"tabBar"];
    
    [self setupChildViewControllers];
    
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSForegroundColorAttributeName] = RGB(102, 102, 102);
    attributes[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    
    NSMutableDictionary *selectAttri = [NSMutableDictionary dictionary];
    selectAttri[NSForegroundColorAttributeName] = RGB(5, 184, 141);
    selectAttri[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    //通过appearance对tabBarItem的文字属性进行统一设置，这样所有的控制的tabBarItem的文字属性久都是这种样式的了
    UITabBarItem *tabbarItem = [UITabBarItem appearance];
    [tabbarItem setTitleTextAttributes:attributes forState:UIControlStateNormal];
    [tabbarItem setTitleTextAttributes:selectAttri forState:UIControlStateSelected];
}

-(void)setupController:(UIViewController*)viewController
                 title:(NSString*)title
                 image:(UIImage*) image
         selectedImage:(UIImage*)selectedImage
{
    
    UITabBarItem* item = [[UITabBarItem alloc]initWithTitle:title image:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    viewController.tabBarItem = item;
    MZNavigationController *nvc = [[MZNavigationController alloc] initWithRootViewController:viewController];
    [self addChildViewController:nvc];
}

- (void)setupChildViewControllers {
    UIViewController *mainPageVC = [[UIViewController alloc] init];
    [self setupController:mainPageVC title:@"首页" image:[UIImage imageNamed:@"menu1"] selectedImage:[UIImage imageNamed:@"menu1_sel"]];
    
    UIViewController *personVC = [[UIViewController alloc] init];
    [self setupController:personVC title:@"个人中心" image:[UIImage imageNamed:@"menu2"] selectedImage:[UIImage imageNamed:@"menu2_sel"]];
}

#pragma mark -TDTabBarDeleagte
- (void)tabbarMiddleBtnDidClicked:(MZTabBar *)tabBar {
    NSLog(@"中间按钮点击了");
}

@end
