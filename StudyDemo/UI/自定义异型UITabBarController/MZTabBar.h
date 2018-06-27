//
//  MZTabBar.h
//  StudyDemo
//
//  Created by 曾龙 on 2018/6/27.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MZTabBar;
@protocol MZTabBarDelegate<NSObject>
- (void)tabbarMiddleBtnDidClicked:(MZTabBar *)tabBar;
@end

@interface MZTabBar : UITabBar
@property (nonatomic, weak)id<MZTabBarDelegate> mzTabBarDelegate;
@end
