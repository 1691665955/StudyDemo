//
//  MZNavigationController.h
//  StudyDemo
//
//  Created by 曾龙 on 2018/1/11.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MZNavigationControllerDelegate<NSObject>
@optional
- (void)navigationBackHandle;
- (BOOL)navigationHiddenBackBtn;
@end

@interface MZNavigationController : UINavigationController
@property (nonatomic, weak) id<MZNavigationControllerDelegate> mzDelegate;
@end
